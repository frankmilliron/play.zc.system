# Zero-Crossing 1-bit Audio Playback Engine for Apple II

Have you ever wished your Apple //, II, or ][ could rock the party? Is your stereo system too high fidelity? Have you found yourself hoping to listen to low bandwidth audio versions of your favorite 35-year-old songs on a 45-year-old home computer? If you answered yes to any of the above, this is your lucky day!


# Creating Audio Files

To create audio files, we will use [Audacity](https://www.audacityteam.org/), which has downloads available on their website. Audacity can handle MP3, WAV, OGG, FLAC, M4A/AAC, AIFF, and WMA formats, among others. It can import any unprotected audio files from your collection.

If you don't have an amazing collection of audio to convert, don't fret, there's a great online resource to find lots of audio. Where you ask? Why, YouTube of course! Let's begin by installing a couple pieces of software that will come in handy to procure our files. First, we will need to install [Homebrew](https://brew.sh/). Details for Homebrew installation are available on the Homebrew website. Then we will need both [youtube-dl](https://github.com/ytdl-org/youtube-dl/) to handle downloading the files, and [ffmpeg](https://ffmpeg.org/) to allow conversion to a format that Audacity can import.


``` shell
$ brew install youtube-dl ffmpeg
```

Begin by identifying a song or audio clip that you like. Keep in mind the limitations of the Apple II speaker, which is very small and not designed for high-fidelity reproduction. Songs with large amounts of bass will not work. A good rule of thumb is that if it would sound good on a cassette walkman on headphones, there's a good chance it will sound good in play.zc.system. Once you have identified an audio source, take the unique identifier from the YouTube URL (the piece following "watch?v=") and append it to youtube-dl, as such. Please note the following example.

Song: Billy Idol - Eyes Without a Face
https://www.youtube.com/watch?v=9OFpfTd0EIs

``` shell
$ youtube-dl --extract-audio --audio-format mp3 9OFpfTd0EIs
```

There should now be an MP3 file in the current working directory. Some videos are protected from download and may return an error instead. Sometimes you can continue searching and find the same song from a different source, with a different URL, and find success that way.


The following playback bitrates are available, and are set in the player using the ProDOS filetype and auxtype. [CiderPress](https://a2ciderpress.com/)-style filenames are below. Select one to use before working with an audio file.

 - #D81001 - 10,742 Hz (High)
 - #D81002 - 8,797 Hz (Mid)
 - #D81003 - 7,186 Hz (Default)
 - #D81004 - 5,899 Hz (Lo-fi)


Open your selected audio file in Audacity. We will need to convert the audio channels and bit rate to our target environment. Once open, navigate to "Tracks" --> "Mix" --> "Mix Stereo Down to Mono". Next, select "Tracks" --> "Resample..." and enter your target playback rate in the dialog box. Then, change the project bitrate to match. This is set in a small box in the bottom left corner of the waveform view that says "Project Rate (Hz)". Enter your bitrate there as well.

We are now ready to prepare the audio for a low bandwidth environment. Trim any leading silence or fade-in/out from the beginning and end of the file. If there is too much bass, select all audio (Command-A) and go to "Effect" --> "Filter Curve EQ" (or "Graphic Curve EQ"). Pull the left hand (low Hertz) side down to remove bass, which doesn't reproduce well. You can experiment with compression, or other effects, if you desire.

Next, we will export the resulting audio. Select "File" --> "Export" --> "Export as WAV...". Make sure "Microsoft WAV" is the File Type, and that Encoding is set to "Signed 16-bit PCM". Hit Save. On the "Edit Metadata Tags" dialog box, click on "Clear" to remove any metadata tags so that they are not added to the file.

To create a ZC Audio file from the exported WAV, use the "convert.pl" file in the "conversion" folder of the project, using the following syntax.

``` shell
chmod a+x convert.pl
./convert.pl < INFILE.wav > OUTFILE.zc
```

Once you change OUTFILE.zc into something like OUTFILE#D81003 it can be added directly to the "assets folder" and will be automatically added to the resulting image file when the project is built.



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
$ brew install acme mach-kernel-cadius
```


To build the project, enter the following.

``` shell
$ cd play.zc.system
$ make image
```

The output HDV file will be in the `build` subdirectory.



Optionally, you can automatically mount the disk image in [Virtual II](http://virtualii.com/).

``` shell
$ cd play.zc.system
$ make mount
```


# Acknowledgements and Thank Yous!

I would like to voice my appreciation for the help and contributions of the following pillars of the Apple II community for help, advice, and code over the years.

 - [Qkumba](https://github.com/peterferrie) for his lightning-fast [ProRWTS2](https://github.com/peterferrie/prorwts2), the original audio player that started this project, as well as one of my favorite Apple II projects, [Total Replay](https://github.com/a2-4am/4cade).

 - [Josh Bell](https://github.com/a2stuff) for help updating my WAV conversion workflow from an amazingly slow BASIC program (no joke!) to a modern perl implementation. Additional thanks for his amazing dissassembly and re-write of the [Apple II Desktop](https://www.a2desktop.com/), among other projects.

 