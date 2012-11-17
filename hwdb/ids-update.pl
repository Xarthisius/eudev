#!/usr/bin/perl

use strict;
use warnings;

sub usb_vendor {
        my $vendor;

        open(IN, "<", "usb.ids");
        open(OUT, ">", "20-usb-vendor-product.hwdb");
        print(OUT "# This file is part of eudev.\n" .
                  "#\n" .
                  "# Data imported and updated from: http://www.linux-usb.org/usb.ids\n");

        while (my $line = <IN>) {
                $line =~ s/\s+$//;
                $line =~ m/^([0-9a-f]{4})\s*(.*)$/;
                if (defined $1) {
                        $vendor = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "usb:v" . $vendor . "*\n");
                        print(OUT " ID_VENDOR_FROM_DATABASE=" . $text . "\n");
                        next;
                }

                $line =~ m/^\t([0-9a-f]{4})\s*(.*)$/;
                if (defined $1) {
                        my $product = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "usb:v" . $vendor . "p" . $product . "*\n");
                        print(OUT " ID_PRODUCT_FROM_DATABASE=" . $text . "\n");
                }
        }

        close(INP);
        close(OUTP);
}

sub usb_classes {
        my $class;
        my $subclass;
        my $protocol;

        open(IN, "<", "usb.ids");
        open(OUT, ">", "20-usb-classes.hwdb");
        print(OUT "# This file is part of eudev.\n" .
                  "#\n" .
                  "# Data imported and updated from: http://www.linux-usb.org/usb.ids\n");

        while (my $line = <IN>) {
                $line =~ s/\s+$//;

                $line =~ m/^C\ ([0-9a-f]{2})\s*(.*)$/;
                if (defined $1) {
                        $class = uc $1;
                        if ($class =~ m/^00$/) {
                                next;
                        }
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "usb:v*p*d*dc" . $class . "*\n");
                        print(OUT " ID_USB_CLASS_FROM_DATABASE=" . $text . "\n");
                        next;
                }

                if (not defined $class) {
                        next;
                } elsif ($line =~ m/^$/) {
                        last;
                }

                $line =~ m/^\t([0-9a-f]{2})\s*(.*)$/;
                if (defined $1) {
                        $subclass = uc $1;
                        if ($subclass =~ m/^00$/) {
                                next;
                        }
                        my $text = $2;
                        if ($text =~ m/^(\?|None|Unused)$/) {
                                next;
                        }
                        print(OUT "\n");
                        print(OUT "usb:v*p*d*dc" . $class . "dsc" . $subclass . "*\n");
                        print(OUT " ID_USB_SUBCLASS_FROM_DATABASE=" . $text . "\n");
                        next;
                }

                $line =~ m/^\t\t([0-9a-f]{2})\s*(.*)$/;
                if (defined $1) {
                        $protocol = uc $1;
                        my $text = $2;
                        if ($text =~ m/^(\?|None|Unused)$/) {
                                next;
                        }
                        print(OUT "\n");
                        print(OUT "usb:v*p*d*dc" .  $class . "dsc" . $subclass . "dp" . $protocol . "*\n");
                        print(OUT " ID_USB_PROTOCOL_FROM_DATABASE=" . $text . "\n");
                }
        }

        close(INP);
        close(OUTP);
}

sub pci_vendor {
        my $vendor;
        my $device;

        open(IN, "<", "usb.ids");
        open(IN, "<", "pci.ids");
        open(OUT, ">", "20-pci-vendor-product.hwdb");
        print(OUT "# This file is part of eudev.\n" .
                  "#\n" .
                  "# Data imported and updated from: http://pci-ids.ucw.cz/v2.2/pci.ids\n");

        while (my $line = <IN>) {
                $line =~ s/\s+$//;
                $line =~ m/^([0-9a-f]{4})\s*(.*)$/;

                if (defined $1) {
                        $vendor = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "pci:v0000" . $vendor . "*\n");
                        print(OUT " ID_VENDOR_FROM_DATABASE=" . $text . "\n");
                        next;
                }

                $line =~ m/^\t([0-9a-f]{4})\s*(.*)$/;
                if (defined $1) {
                        $device = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "pci:v0000" . $vendor . "d0000" . $device . "*\n");
                        print(OUT " ID_PRODUCT_FROM_DATABASE=" . $text . "\n");
                        next;
                }

                $line =~ m/^\t\t([0-9a-f]{4})\s*([0-9a-f]{4})\s*(.*)$/;
                if (defined $1) {
                        my $sub_vendor = uc $1;
                        my $sub_device = uc $2;
                        my $text = $3;
                        print(OUT "\n");
                        print(OUT "pci:v0000" . $vendor . "d0000" . $device . "sv0000" . $sub_vendor . "sd0000" . $sub_device . "*\n");
                        print(OUT " ID_PRODUCT_FROM_DATABASE=" . $text . "\n");
                }
        }

        close(INP);
        close(OUTP);
}

sub pci_classes {
        my $class;
        my $subclass;
        my $interface;

        open(IN, "<", "pci.ids");
        open(OUT, ">", "20-pci-classes.hwdb");
        print(OUT "# This file is part of eudev.\n" .
                  "#\n" .
                  "# Data imported and updated from: http://pci-ids.ucw.cz/v2.2/pci.ids\n");

        while (my $line = <IN>) {
                $line =~ s/\s+$//;

                $line =~ m/^C\ ([0-9a-f]{2})\s*(.*)$/;
                if (defined $1) {
                        $class = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "pci:v*d*sv*sd*bc" . $class . "*\n");
                        print(OUT " ID_PCI_CLASS_FROM_DATABASE=" . $text . "\n");
                        next;
                }

                if (not defined $class) {
                        next;
                } elsif ($line =~ m/^$/) {
                        last;
                }

                $line =~ m/^\t([0-9a-f]{2})\s*(.*)$/;
                if (defined $1) {
                        $subclass = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "pci:v*d*sv*sd*bc" . $class . "sc" . $subclass . "*\n");
                        print(OUT " ID_PCI_SUBCLASS_FROM_DATABASE=" . $text . "\n");
                        next;
                }

                $line =~ m/^\t\t([0-9a-f]{2})\s*(.*)$/;
                if (defined $1) {
                        $interface = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "pci:v*d*sv*sd*bc" .  $class . "sc" . $subclass . "i" . $interface . "*\n");
                        print(OUT " ID_PCI_INTERFACE_FROM_DATABASE=" . $text . "\n");
                }
        }

        close(INP);
        close(OUTP);
}

sub oui {
        open(IN, "<", "oui.txt");
        open(OUT, ">", "20-OUI.hwdb");
        print(OUT "# This file is part of eudev.\n" .
                  "#\n" .
                  "# Data imported and updated from: http://standards.ieee.org/develop/regauth/oui/oui.txt\n");

        while (my $line = <IN>) {
                $line =~ s/\s+$//;
                $line =~ m/^([0-9A-F]{6})\s*\(base 16\)\s*(.*)$/;
                if (defined $1) {
                        my $vendor = uc $1;
                        my $text = $2;
                        print(OUT "\n");
                        print(OUT "OUI:" . $vendor . "\n");
                        print(OUT " ID_OUI_FROM_DATABASE=" . $text . "\n");
                }
        }

        close(INP);
        close(OUTP);
}

usb_vendor();
usb_classes();

pci_vendor();
pci_classes();

oui();
