% Louis Rosenblum
% Project 2
% EEE 509 - ASU
% 06/10/2020

%% Initialization

%clear all
close all

cd 'C:\Users\Louis\Desktop\DSP\Project 2'

%% Set runtime constants

N = 512;
nFrames = 128;

if (N == 4)
    mu = 0.0007;
elseif (N == 16)
    mu = 0.0636;
elseif (N == 64)
    mu = 0.1115; 
elseif (N == 128)
    mu = 0.058;
elseif (N == 256)
    mu = 0.0235;
else
    mu = 0.01;
end

%% Read audio from file

[mic1, Fs1] = audioread('mic1_2019.wav');
[mic2, Fs2] = audioread('mic2_2019.wav');

% Calculate starting SNR
snr1 = snr(mic1)

%% Create frame data structures

[mic1_frames, len1] = createFrames(mic1,nFrames);
[mic2_frames, len2] = createFrames(mic2,nFrames);

%% Perform N-point fft

mic1_fft = fft(mic1_frames,N);
mic2_fft = fft(mic2_frames,N);


%% Create diaganol matrices

Es = [];
Bs = [];
es = [];
B = zeros(N,1);

k = 1:nFrames;
figure();

error  = [];

figure();
q = 1:nFrames;

for i = 1:nFrames
    % Calculate for current frame
    diaganol = diag(mic1_fft(:,i));
    E = mic2_fft(:,i) - diaganol * B;
    e = ifft(E,N);
    
    Es = [Es E];
    Bs = [Bs B];
    es = [es e];
    
    % Prepare for next frame
    B = B + 2*mu * diaganol'*E;
end

%% Revert frames to vector

final_signal = createVector(es);

% Calculate ending SNR
snr2 = snr(final_signal)

diff = snr2 - snr1

%% Create plots

% Plot original signal

t = 0:1/Fs1:(length(mic1)-1)/Fs1;
t2 = 0:1/Fs1:(length(final_signal)-1)/Fs1;

figure();
plot(t,mic1);
title("Input Signal")
xlabel("Time (s)")
ylabel("Amplitude")

% Plot filtered signal
figure();
p = strcat("Output Signal N = ", string(N));
plot(t2,final_signal);
title(p)
xlabel("Time (s)")
ylabel("Amplitude")
%% Function definitions

function [data, len] = createFrames(audio,nFrames)
    len = length(audio);
 	frameSize = ceil(len/nFrames);
    total = frameSize*nFrames;
    z = total - len;
    pad = [audio;zeros(z,1)];
    data = reshape(pad,frameSize,nFrames);
end

function data = createVector(audio)
    [m,n] = size(audio);
    data = [];
    
    for i = 1:n
        data = [data rot90(audio(:,i))];
    end
end