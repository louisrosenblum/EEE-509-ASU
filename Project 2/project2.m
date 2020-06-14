% Louis Rosenblum
% Project 2
% EEE 509 - ASU
% 06/10/2020

%% Initialization

clear all
close all

cd 'C:\Users\Louis\Desktop\DSP\Project 2'

%% Set runtime constants

N = 64;
nFrames = 8;

%% Read audio from file

[mic1, Fs1] = audioread('mic1_2019.wav');
[mic2, Fs2] = audioread('mic2_2019.wav');

%% Create frame data structures

[mic1_frames, len1] = createFrames(mic1,nFrames);
[mic2_frames, len2] = createFrames(mic2,nFrames);

%% Perform N-point fft

mic1_fft = fft(mic1_frames);
mic2_fft = fft(mic2_frames);

%% Create diaganol matrices

E = []
B = zeros(len1,1);

for i = 1:nFrames
    diaganol = diag(mic1_fft(:,1));
    E(i) = mic2_fft(:,i) - diaganol * B;
end

%% Function definitions

function [data, len] = createFrames(audio,nFrames)
    len = length(audio);
 	frameSize = ceil(len/nFrames);
    total = frameSize*nFrames;
    z = total - len;
    pad = [audio;zeros(z,1)];
    data = reshape(pad,frameSize,nFrames);
end