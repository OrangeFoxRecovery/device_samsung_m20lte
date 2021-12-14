#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2021 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="m20lte"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	
	# Base
	export ALLOW_MISSING_DEPENDENCIES=true
	export LC_ALL="C"
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"
	
	# m20lte specific
	export TARGET_DEVICE_ALT="m20lte"
	export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/13500000.dwmmc0/by-name/RECOVERY"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/platform/13500000.dwmmc0/by-name/SYSTEM"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/platform/13500000.dwmmc0/by-name/VENDOR"
	export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/13500000.dwmmc0/by-name/BOOT"
	export OF_FLASHLIGHT_ENABLE="1"
	export OF_FL_PATH1="/system/flashlight"
	export OF_DEVICE_WITHOUT_PERSIST=1
	export OF_SKIP_FBE_DECRYPTION=1
	
	# Screen Settings
	export OF_SCREEN_H=2340
	export OF_STATUS_H=81
	export OF_STATUS_INDENT_LEFT=55 # m20lte Specific
	export OF_STATUS_INDENT_RIGHT=55 # m20lte Specific
	export OF_CLOCK_POS=1
	export OF_ALLOW_DISABLE_NAVBAR=0
	
	# R11.1 Settings
	export FOX_R11="1"
	export FOX_VERSION="R11.1"
	export OF_MAINTAINER="Sushrut1101"
	export OF_MAINTAINER_AVATAR="misc/Sushrut1101.png"
	export FOX_BUILD_TYPE="Stable"
	
	export FOX_ADVANCED_SECURITY="1"
	export OF_USE_TWRP_SAR_DETECT="1"
	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=0
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	export OF_OTA_BACKUP_STOCK_BOOT_IMAGE=1

	# Quick Backup Defaults
	export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"
	
	# Common
	export TARGET_ARCH=arm64
	export TW_DEFAULT_LANGUAGE="en"
	export OF_KEEP_FORCED_ENCRYPTION="1"
	export OF_PATCH_AVB20="1"
	export OF_USE_MAGISKBOOT="1"
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
	export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"
	export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
	export FOX_USE_LZMA_COMPRESSION="1"
	
	export FOX_USE_BASH_SHELL="1"
	export FOX_ASH_IS_BASH="1"
	export FOX_USE_TAR_BINARY="1"
	export FOX_USE_ZIP_BINARY="1"
	export FOX_REPLACE_BUSYBOX_PS="1"
	export OF_USE_NEW_MAGISKBOOT="1"
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP="1"
	
	# Use the System (ROM) Fingerprint where Available
	export OF_USE_SYSTEM_FINGERPRINT="1"

	# Run Post Format Process for MTP
	export OF_RUN_POST_FORMAT_PROCESS=1
	
	# Create Odin Flashable .tar files
	export OF_NO_SAMSUNG_SPECIAL=0
	
	# OF_MAINTAINER_AVATAR Setup
    if [ -n "$OF_MAINTAINER_AVATAR" ]; then
        if [ ! -f "$OF_MAINTAINER_AVATAR" ]; then
              # some colour codes
              RED='\033[0;31m'
              GREEN='\033[0;32m'
              ORANGE='\033[0;33m'
              BLUE='\033[0;34m'
              PURPLE='\033[0;35m'
              echo -e "${RED}-- File \"$OF_MAINTAINER_AVATAR\" not found  ...${NC}"
              echo -e "${ORANGE}-- Downloading...${NC}"
              mkdir -p misc
              curl https://raw.githubusercontent.com/OrangeFoxRecovery/avatar/fox/Sushrut1101.png >> $OF_MAINTAINER_AVATAR
              echo -e "${BLUE}-- Successfully Downloaded the Avatar Image \"$OF_MAINTAINER_AVATAR\" ...${NC}"
              echo -e "${PURPLE}-- Using A Custom Maintainer Avatar from the Downloaded Image \"$OF_MAINTAINER_AVATAR\" ...${NC}"
              echo -e "${GREEN}-- Done!"
        fi
    fi

	# Let's See what are our Build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
#
