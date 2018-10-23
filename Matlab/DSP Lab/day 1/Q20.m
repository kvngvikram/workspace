n=0:30;
f=0.1;
maximumAmplitude=4;
maximumPhase=2*pi;
Amplitude=maximumAmplitude*rand;
phase=maximumPhase*rand;
arg=2*pi*f*n+phase;
x=Amplitude*cos(arg);
stem(n,x);
Ylimit = 4;
axis([0 length(n) -Ylimit Ylimit]);
title('Sinusoidal Sequence with Random Amplitude and Phase');
xlabel('Time index n');
ylabel('Amplitude');