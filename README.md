# OrangeFox Recovery Project for the Samsung Galaxy M20

### How to build ###

```bash
# Create dirs
$ mkdir ~/OrangeFox ; cd ~/OrangeFox

# Init repo
$ repo init --depth=1 -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0

# Clone m20lte repo
$ git clone https://github.com/Sushrut1101/android_device_samsung_m20lte_OrangeFox.git -b fox_9.0 device/samsung/m20lte

# Sync
$ repo sync --no-repo-verify -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j`nproc`

# Build
$ source build/envsetup.sh ; lunch omni_m20lte-eng ; mka recoveryimage
```

Credits:
2021 - @Sushrut1101
