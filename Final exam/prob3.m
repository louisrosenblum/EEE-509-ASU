% Louis Rosenblum
% EEE509-ASU
% 06/25/2020
% Final exam part B

%% Problem 3

%% Read audio from file

[input, Fs1] = audioread('New_clean_male.wav');

%% Create frames from vector

len = length(input);
nFrames = ceil(len/256);

[dataFrames, len1] = createFrames(input,nFrames);

%% Take FFT of data frames

N = 256;

framesFFT = fft(dataFrames,N);

%% Select first M components

M = 128;

framesFFT_reduced = framesFFT(1:M,:);

%% Take IFFT

output_frames = ifft(framesFFT_reduced);

%% Convert frames to vector

output = createVector(output_frames);

%% Create plots

plot(input)

figure()

plot(abs(output))

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