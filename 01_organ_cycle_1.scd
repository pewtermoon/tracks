// Organ Cycle 1 (26 Nov 2017)
// read in organ recording
s.boot;
b = Buffer.read(s, "../../Users/ollie/Music/sounds/organ.wav");
b.numFrames;
// Define buffer reader
(
SynthDef(\playBuf0,{| out = 0, bufnum, startPos = 0, dur = 1, amp = 1, rate = 1|
	var scaledRate, player, env;
	env = EnvGen.kr(Env.perc(dur, amp), doneAction: 2);
	scaledRate = rate * BufRateScale.kr(bufnum);
	player = PlayBuf.ar(1, bufnum, scaledRate, startPos: startPos);
    Out.ar(out, player*env)
}).add;
)

// Record it to wav with no aiff-c compression
// otherwise can't convert to flac
(
var s1, s2;
s.recSampleFormat = "int16";
s.recChannels = 2;
s.recHeaderFormat = "WAV";
s.record(path: '../../Users/ollie/Music/sounds/organ_cycle_1.wav');
s1 = Pstutter(Pgeom(1.0, 2, 4), Pgeom(1.0, 0.5, 4));
s2 = Pseries(1.3, -0.1, 9);
Pseq([
Pbind(
	\instrument, \playBuf0,
	\bufnum, Pfunc({b.bufnum}),
	\dur, Pseq(s1, 8),
	\amp, 1,
	\startPos, Pfunc({b.numFrames.rand}),
	\rate, Pseq(s2, 8)
)], 1).play
// s.stopRecording;
)
s.quit;
