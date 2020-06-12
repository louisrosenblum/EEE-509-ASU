% Louis Rosenblum
% Project 2
% EEE 509 - ASU
% 06/10/2020

%% Initialization

clear all
close all

cd 'C:\Users\Louis\Desktop\DSP\Project 2'
%% Read audio from file

[mic1, Fs1] = audioread('mic1_2019.wav');
[mic2, Fs2] = audioread('mic2_2019.wav');

%%
x1 = createFrames(mic1,7)

%% Function definitions

function data = createFrames(audio,nFrames)

    len = length(audio);

 	frameSize = ceil(len/nFrames);

    total = frameSize*nFrames;

    z = total - len;

    pad = [audio;zeros(z,1)];
 
    data = reshape(pad,frameSize,nFrames);
end