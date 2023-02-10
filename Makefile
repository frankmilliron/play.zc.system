#
# play.zc.system Makefile
# Feb 9, 2023
# "make all"
#


# third-party tools required

# https://sourceforge.net/projects/acme-crossass/
# current version 0.97

# https://github.com/mach-kernel/cadius
# current version 1.4.5


# set up variables
imagename=ZCJukebox2.hdv
prodos_vol=ZCJKBX2

V2config="/Users/$(USER)/Library/Application Support/Virtual ][/DefaultConfig.vii"
current_dir = $(shell pwd)



image:	# set up new disk image
	unzip bin/blank32mb.hdv.zip -d build
	mv build/blank.hdv build/$(imagename)
	cadius RENAMEVOLUME build/$(imagename) $(prodos_vol)


		# add all audio files in assets folder (Filetype $D8 - Auxtype $10xx)
	for f in assets/*#D810* ; do \
		cadius ADDFILE build/$(imagename) /$(prodos_vol) "$$f"; \
	done


		# add QUIT.SYSTEM to drop to BitsyBye on boot
	cadius ADDFILE build/$(imagename) /$(prodos_vol) bin/QUIT.SYSTEM#FF2000


		# compile audio player & add it
	acme play.zc.system.a
	cadius ADDFILE build/$(imagename) /$(prodos_vol) build/BASIS.SYSTEM#ff0000


		# add PRODOS to make it bootable
	cadius ADDFILE build/$(imagename) /$(prodos_vol) bin/PRODOS#FF0000



mount:	# open new disk image in Virtual ][
	osascript -e 'tell app "Virtual ][" to close every machine saving no'
	osascript -e 'tell app "Virtual ][" to open $(V2config)'
	osascript -e 'tell app "Virtual ][" to insert "$(current_dir)/build/$(imagename)" into device "S7D1" of front machine'
	osascript -e 'tell app "Virtual ][" to type line "PR#7"'
	osascript -e 'tell app "Virtual ][" to activate'


clean:	# delete old builds
	rm -rf build/ || rm -rf build

all: clean image mount
