
DIST=${DIST:=wheezy}

TARGET=${TARGET:=obsax3}

export TARGET DIST

case ${DIST} in
wheezy)
	case ${TARGET} in
	obsax3)
		RAMDISK_SIZE=160
		KERNEL=3.2.36
		# 2013/xx/xx
		PATCHLEVEL=0
		ARCH=armhf
	;;
	obsa6)
		RAMDISK_SIZE=144
		KERNEL=3.2.36
		PATCHLEVEL=0
	;;
	*) exit 1 ;;
	esac
;;
squeeze)
	ISOFILE=debian-6.0.5-armel-DVD-1.iso
	case ${TARGET} in
	obsax3)
		RAMDISK_SIZE=128
		KERNEL=3.0.6
		# 2013/04/18
		PATCHLEVEL=12
		# test
		#KERNEL=3.2.36
		#PATCHLEVEL=13
	;;
	obsa6)
		RAMDISK_SIZE=128
		KERNEL=2.6.31
		# 2013/01/31
		PATCHLEVEL=8
	;;
	*) exit 1 ;;
	esac
;;
esac




if [ -f _config.sh ] ; then
	. _config.sh
elif [ -f ../_config.sh ] ; then
	. ../_config.sh
else
	echo "could't read _config.sh"
	exit 1
fi

