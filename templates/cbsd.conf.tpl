# DO NOT EDIT THIS FILE. PLEASE USE INSTEAD:
# cbsd jconfig jname=SERVICE
relative_path="1";
jname="SERVICE";
path="CBSD_WORKDIR/jails/SERVICE";
host_hostname="SERVICE.DOMAIN";
ip4_addr="DHCP";
mount_devfs="1";
allow_mount="1";
allow_devfs="1";
allow_nullfs="1";
mount_fstab="CBSD_WORKDIR/jails-fstab/fstab.SERVICE";
arch="native";
mkhostsfile="1";
devfs_ruleset="DEVFS_RULESET";
ver="native";
basename="";
baserw="0";
mount_src="0";
mount_obj="0";
mount_kernel="0";
mount_ports="0";
data="CBSD_WORKDIR/jails-data/SERVICE-data";
vnet="0";
applytpl="1";
mdsize="0";
rcconf="CBSD_WORKDIR/jails-rcconf/rc.conf_SERVICE";
floatresolv="1";
zfs_snapsrc="";

exec_poststart="0";
exec_poststop="0";
exec_prestart="0";
exec_prestop="0";

exec_master_poststart="0";
exec_master_poststop="0";
exec_master_prestart="0";
exec_master_prestop="0";
pkg_bootstrap="1";
with_img_helpers="";
interface="INTERFACE";
jailskeldir="CBSD_WORKDIR/share/FreeBSD-jail-reggae-skel";
jail_profile="reggae";
systemskeldir="CBSD_WORKDIR/share/jail-system-reggae";
pkglist="sudoEXTRA_PACKAGES";
exec_start="/bin/sh /etc/rc"
exec_stop="/bin/sh /etc/rc.shutdown"
emulator="jail"
