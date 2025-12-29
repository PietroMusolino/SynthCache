(
{
	var sig,freq, env,dur;
	dur=3;
	env=XLine.kr(1,0.1,dur,doneAction:2);
	freq=XLine.kr(440,220,dur, doneAction: 2 );
	sig= Pulse.ar(freq)*env;
	sig=FreeVerb.ar(sig, 0.35, 0.3, 0.3);
}.play;
)

(
{
	var sig,freq,env;
	env=EnvGen.kr(Env.new([1,0,1,0,1,0],[pi/2,pi/2,pi/2,pi/2,pi/2,pi/2], [\sin,\sin,\sin,\sin]),doneAction:2);
	freq=XLine.kr(440,220,0.1)*env;
	sig=Pulse.ar(freq)*env;

}.play
)

//Envelopes for Ambient stuff!
(
{
	var sig1,sig2,freq1,freq2, env1,env2,sig;
	env1=EnvGen.kr(Env.new([0,0.6,0.2,0],[4,5,3], [2,-2,0]),doneAction:2);
	env2=EnvGen.kr(Env.new([0,1,0.3,0.1],[3,7,2], [1,-3,1]),doneAction:2);
	freq1=XLine.kr(220,275,7);
	sig1=Pulse.ar(freq1)*env1;
	sig2=SinOsc.ar(329.63)*env2;
	sig=sig1+sig2;
	sig=LPF.ar(sig,1500);

}.play
)
//to visualize the (cool) envelopes I make:
Env.new([0,1,0.2,0],[4,5,3], [3,-2,0]).plot;


//now I can use this to make some cool chords
(
{
	var sig, env, baseFreq = 220;

	env = EnvGen.kr(Env.new([0, 0.8, 0.3, 0], [3, 8, 4], [2, -3, 0]), doneAction: 2);

	// A major 7th chord: A(220), C#(277), E(330), G#(415)
	sig = [
		Pulse.ar(baseFreq, 0.5),          // Root
		SinOsc.ar(baseFreq * 1.5),        // Perfect fifth
		SinOsc.ar(baseFreq * 1.889)       // Major seventh (15:8 ratio)
	] * env * 0.3;

	sig = Splay.ar(sig, spread: 0.8);
	sig = FreeVerb.ar(sig, 0.5, 0.9, 0.7);
	sig = LPF.ar(sig, 1800);

}.play;
)

(
{
	var sig, env, baseFreq = 220;

	env = EnvGen.kr(Env.new([0, 0.7, 0.2, 0], [4, 10, 6], [2, -4, 0]), doneAction: 2);

	// A(add9) chord: A(220), C#(277), E(330), B(495)
	sig = [
		Pulse.ar(baseFreq),   // Root
		SinOsc.ar(baseFreq * 1.5),        // Fifth
		SinOsc.ar(baseFreq * 2.25)        // Ninth (9:4 ratio - B above A)
	] * env * 0.25;

	sig = Splay.ar(sig);
	sig = CombC.ar(sig, 0.5, 0.3, 3);
	sig = FreeVerb.ar(sig, 0.7, 0.9, 0.5);

}.play;
)
//suspended fourth
(
{
	var sig, env, baseFreq = 220;

	env = EnvGen.kr(Env.sine(10, 0.6), doneAction: 2);

	// Asus4 chord: A(220), D(293.66), E(330)
	sig = [
		Pulse.ar(baseFreq, 0.5),          // Root
		SinOsc.ar(baseFreq * 1.5),        // Fifth
		SinOsc.ar(baseFreq * 4/3)         // Fourth (D - 4:3 ratio)
	] * env * 0.3;

	// Make it shimmer with a slow LFO
	sig = sig * LFNoise1.kr(0.2).range(0.8, 1);
	sig = Splay.ar(sig, 0.8);
	sig = GVerb.ar(sig, roomsize: 80, revtime: 5);

}.play;
)
