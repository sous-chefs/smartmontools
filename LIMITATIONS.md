# Limitations

## Package Availability

smartmontools is available from the standard package repositories for the supported Linux
distributions. This cookbook does not configure upstream smartmontools repositories or compile
smartmontools from source.

### APT (Debian/Ubuntu)

* Debian 12: package available from Debian repositories.
* Ubuntu 22.04 and 24.04: package available from Ubuntu repositories.

### DNF/YUM (RHEL Family)

* AlmaLinux 8 and 9: package available from distribution repositories.
* Amazon Linux 2023: package available from Amazon Linux repositories.
* CentOS Stream 9: package available from distribution repositories.
* Fedora: package available from Fedora repositories.
* Oracle Linux 8 and 9: package available from distribution repositories.
* Rocky Linux 8 and 9: package available from distribution repositories.
* Red Hat Enterprise Linux 8 and 9: package available from distribution repositories.

### Zypper (SUSE)

* openSUSE Leap 16: package available from openSUSE repositories. Leap 15.6 reached end of life on
  2026-04-30, so the supported test target is Leap 16.0.

The `dokken/opensuse-leap-16` image is not published, so openSUSE Leap 16 remains in metadata and
non-Dokken Kitchen definitions but is excluded from Dokken CI until an image is available.

## Architecture Limitations

The upstream project supports common Linux architectures, and distribution package availability
depends on each operating system repository. The cookbook does not enforce architecture-specific
package constraints.

## Source/Compiled Installation

Source installation is not implemented. The upstream smartmontools project is written in C/C++ and
can be built from source, but this cookbook intentionally manages distribution packages only.

## Known Issues

* The resource does not automatically skip cloud or virtualized guests. Users should declare the
  resource only on nodes where disk SMART monitoring is meaningful.
* Dokken containers do not expose real host block device SMART data, so integration tests verify
  package, configuration, and service management rather than actual disk telemetry.

## Sources

* [smartmontools GitHub repository](https://github.com/smartmontools/smartmontools)
* [smartmontools SourceForge project](https://sourceforge.net/projects/smartmontools/)
