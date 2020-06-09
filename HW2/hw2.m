% Louis Rosenblum
% EEE-509 ASU
% Summer 2020

%% Initialization

close all
clear all

%% Section b-d

Fs = 8000;
f = 200;
w0 = 2*pi*f/Fs;

n = 0:10000;

h = cos(w0.*n);
x = zeros(1,10000);
x(1) = 1;

y = conv(h,x);

plot(y)

figure()
spectrogram(y)
title("Digital Oscillator System Output")

%% Section e

w0 = 2*pi*(100+0.01.*n)/Fs;
h = cos(w0.*n);

y = conv(h,x);

plot(y)

figure()
spectrogram(y)
title("Digital Oscillator System Output")