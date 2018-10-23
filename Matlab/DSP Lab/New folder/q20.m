n=0:30;
f=0.1;
Amax=4;
phimax=2*pi;
A=Amax*rand;phi=phimax*rand;
arg=2*pi*f*n+phi;
x=A*cos(arg);
stem(n,x);
Ylim = 4;
axis([0 length(n) -Ylim Ylim]);
grid;
title('Sinusoidal Sequence with Random Amplitude and Phase');
xlabel('Time index n');
ylabel('Amplitude');