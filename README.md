# Zero-Crossing 1-bit Audio Playback Engine for Apple II

Have you ever wished your Apple could rock the party? Is your stereo system too high fidelity? Have you found yourself hoping to listen to low bandwidth audio versions of your favorite songs on a 45 year old home computer? If you answered yes to any of the above, today is your lucky day!

# Creating Audio Files



# Building the Project

The project was written targeting macOS. The following were tested under macOS 12.6.3 "Monterey"

Necessary Pieces that must be present:
 - [Xcode command line tools]
``` shell
$ xcode-select --install
```

 - [ACME](https://sourceforge.net/projects/acme-crossass/)
 - [Cadius](https://github.com/mach-kernel/cadius)


ACME and Cadius are installable via [Homebrew](https://brew.sh/).

``` shell
$ brew tap lifepillar/appleii
$ brew install acme parallel mach-kernel-cadius
```

To build the project, enter the following.

``` shell
$ cd play.zc.system
$ make image
```

Output will be in the `build/` subdirectory.



Optionally, you can automatically mount the disk image in [Virtual II](http://virtualii.com/).

``` shell
$ cd play.zc.system
$ make mount
```

