#!/bin/bash

# Script to update Arch Linux system
#
#

SNAPSHOTS_LOCATION="/backups/snapshots/updates"

# Terminal colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check for failed systemd units
check_failed_systemd_units() {
  echo "${YELLOW}Checking for failed systemd units...${NC}"
  failed_units=$(systemctl --failed --plain --no-legend --full | awk '{print $1}')

  if [[ -n "$failed_units" ]]; then
    echo -e "${RED}Failed systemd units found:${NC}"
    echo -e "$failed_units"
    
    read -r -p "${YELLOW}Do you want to continue anyway? (y/N) ${NC}" response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      echo -e "${YELLOW}Aborted.${NC}"
      exit 1
    fi
  else
    echo -e "${GREEN}No failed systemd units found.${NC}"
  fi
}

# Create a BTRFS snapshot
create_btrfs_snapshot() {
  if ! command_exists btrfs; then
    echo -e "${RED}btrfs is not installed. Cannot create snapshot.${NC}"
    return 1
  fi

  root_subvolume="/"
  snapshot_dir=$SNAPSHOTS_LOCATION

  if [ ! -d "$snapshot_dir" ]; then
    echo -e "${YELLOW}Snapshot directory '$snapshot_dir' does not exist. Execute mkdir...${NC}"
    sudo mkdir -p "$snapshot_dir"
  fi

  timestamp=$(date +%Y%m%d_%H%M%S)
  snapshot_prefix=""
  snapshot_name="${snapshot_prefix}${timestamp}"
  snapshot_path="$snapshot_dir/$snapshot_name"
  snapshot_path_latest="$snapshot_dir/${snapshot_prefix}latest"
  local keep_count=4

  echo -e "${YELLOW}Creating BTRFS snapshot: $snapshot_path${NC}"

  # Create the snapshot
  sudo btrfs subvolume snapshot "$root_subvolume" "$snapshot_path"

  if [ $? -eq 0 ]; then
    echo -e "${GREEN}BTRFS snapshot created successfully: $snapshot_path${NC}"
    sudo btrfs subvolume snapshot "$snapshot_path" "$snapshot_path_latest"
  else
    echo -e "${RED}Failed to create BTRFS snapshot.${NC}"
  fi

  # Cleanup old snapshots
  mapfile -t snapshots < <(
    find "$snapshot_dir" -maxdepth 1 -type d -name "${snapshot_prefix}_*" ! -name "*_latest" -printf "%T@ %p\0" |
    sort -znr |
    awk -v RS='\0' '{print $2}'
  )
  local total_to_keep=$((keep_count - 1))
  if (( ${#snapshots[@]} > total_to_keep )); then
    echo -e "${YELLOW}Found ${#snapshots[@]} snapshots. Keeping $keep_count latest snapshots...${NC}"
    for (( i=total_to_keep; i<${#snapshots[@]}; i++ )); do
      local snapshot="${snapshots[$i]}"
      echo -e "${RED}Deleting old snapshot: $(basename "$snapshot")${NC}"
      sudo btrfs subvolume delete "$snapshot" || {
        echo -e "${RED}Failed to delete $snapshot${NC}" >&2
        return 1
      }
    done
  else
    echo -e "${GREEN}No excess snapshots found. ${#snapshots[@]} present.${NC}"
  fi
}

# Prompt for sudo password upfront
if ! sudo -v; then
  echo -e "${RED}Failed to obtain sudo privileges. Exiting...${NC}"
  exit 1
fi

check_failed_systemd_units

# Prompt to create BTRFS snapshot
read -r -p "Do you want to create a BTRFS snapshot before updating? (y/N) " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  if ! create_btrfs_snapshot; then
    echo -e "${YELLOW}Snapshot creation failed. Continuing without snapshot...${NC}"
  fi

  # Confirm before proceeding
  read -r -p "Are you sure you want to proceed with the update? (y/N) " response
  if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${YELLOW}Update aborted.${NC}"
    exit 0
  fi
fi

# Refresh pacman database
echo -e "${YELLOW}Refreshing pacman database...${NC}"
sudo pacman -Sy

# Update the system
echo -e "${YELLOW}Running upgrade...${NC}"
sudo pacman -Syu

# Clean up orphan packages
orphans=$(pacman -Qtdq)

if [[ -n "$orphans" ]]; then
    echo -e "${YELLOW}Cleaning up orphan packages...${NC}"
    echo -e "${YELLOW}The following packages will be removed:${NC}"
    echo "$orphans"
    
    read -r -p "${YELLOW}Do you want to proceed? (y/N) ${NC}" response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo pacman -Rns $orphans
        echo -e "${GREEN}Finished cleaning orphan packages.${NC}"
    else
        echo -e "${YELLOW}Skipping orphan package cleanup.${NC}"
    fi
else
    echo -e "${GREEN}No orphan packages found.${NC}"
fi

exit 0
