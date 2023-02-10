# Zero-Crossing 1-bit Audio Playback Engine for Apple II

Have you ever wished your Apple //, II, or ][ could rock the party? Is your stereo system too high fidelity? Have you found yourself hoping to listen to low bandwidth audio versions of your favorite 35-year-old songs on a 45-year-old home computer? If you answered yes to any of the above, this is your lucky day!


# Creating Audio Files

To create audio files, we will use [Audacity](https://www.audacityteam.org/), which has downloads available on their website. Audacity can handle MP3, WAV, OGG, FLAC, M4A/AAC), AIFF, and WMA formats, among others. It can import any unprotected audio files from your collection.

If you don't have an amazing collection of audio to convert, don't fret, there's a great online resource to find lots of audio. Where you ask? Why, YouTube of course! Let's begin by installing a couple pieces of software that will come in handy. First, we will need to install [Homebrew](https://brew.sh/). Details for installation are on the Homebrew website. Then we will need both [youtube-dl](https://github.com/ytdl-org/youtube-dl/) to handle downloading the files, and [ffmpeg](https://ffmpeg.org/) to allow conversion to a format that Audacity can import.


``` shell
$ brew install youtube-dl ffmpeg
```

Begin by identifying a song or audio clip that you like. Keep in mind the limitations of the Apple II speaker, which is very small. Songs with large amounts of bass will not work. A good rule of thumb is that if it would sound good on a cassette walkman, there's a good chance it will sound good in play.zc.system. Once you have identified an audio source, take the unique identifier from the YouTube URL (the piece following "watch?v=") and append it to youtube-dl, as such.

Song: Billy Idol - Eyes Without a Face
https://www.youtube.com/watch?v=9OFpfTd0EIs

``` shell
$ youtube-dl --extract-audio --audio-format mp3 9OFpfTd0EIs
```







# Building the Project

The project was written targeting macOS. The following instructions were tested under macOS 12.6.3 "Monterey".

Necessary Pieces that must be present:
 - [Xcode command line tools](https://developer.apple.com/xcode/features/)
 - [ACME](https://sourceforge.net/projects/acme-crossass/)
 - [Cadius](https://github.com/mach-kernel/cadius)



To install the Xcode command line tools:

``` shell
$ xcode-select --install
```


ACME and Cadius are also installable via [Homebrew](https://brew.sh/).

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

