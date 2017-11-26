// Organ Cycle 1 (26 Nov 2017)
// read in organ recording
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

// Record it.
(
var s1, s2, s3;
s.record(path: '../../Users/ollie/Music/sounds/organ_cycle_1.wav');
//s1 = [0.25,0.25,0.25,0.25, 0.125, 0.125, 0.25, 0.5, 1];
s1 = [2, 1, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125];
s3 = [0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3].reverse;
s2 = [100000, 150000, 200000, 250000, 100000, 100000, 230000, 500000, 110000];
Pseq([
Pbind(
	\instrument, \playBuf,
	\bufnum, Pfunc({b.bufnum}),
	\dur, Pseq(s1, 16),
	\amp, 1,
	\startPos, Pfunc({b.numFrames.rand}),
	\rate, Pseq(s3, 16)	//Pseq(s2, 8)
)], 1).play
)
