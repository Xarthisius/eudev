ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

rootprefix=@rootprefix@
udevlibexecdir=$(rootprefix)/lib/udev
udevrulesdir = $(udevlibexecdir)/rules.d

dist_udevrules_DATA = \
	42-usb-hid-pm.rules \
	50-udev-default.rules \
	60-cdrom_id.rules \
	60-persistent-storage-tape.rules \
	60-persistent-serial.rules \
	60-persistent-input.rules \
	60-persistent-alsa.rules \
	60-persistent-storage.rules \
	60-persistent-v4l.rules \
	61-accelerometer.rules \
	64-btrfs.rules \
	75-net-description.rules \
	75-probe_mtd.rules
	75-tty-description.rules \
	78-sound-card.rules \
	80-drivers.rules \
	95-udev-late.rules

if ENABLE_KEYMAP
dist_udevrules_DATA += \
	95-keymap.rules \
	95-keyboard-force-release.rules
endif
