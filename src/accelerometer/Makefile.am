ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

rootprefix=@rootprefix@
udevlibexecdir=$(rootprefix)/lib/udev

AM_CPPFLAGS = \
	-I $(top_srcdir)/src/libudev \
	-I $(top_srcdir)/src/udev

udevlibexec_PROGRAMS = \
	accelerometer

accelerometer_SOURCES = \
	accelerometer.c

accelerometer_LDADD = \
	$(top_builddir)/src/libudev/libudev-private.la \
	$(top_builddir)/src/udev/libudev-core.la \
	-lm
