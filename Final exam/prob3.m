% Louis Rosenblum
% EEE509-ASU
% 06/25/2020
% Final exam part B

%% Problem 3
% Initialization

clear all
close all

cd 'C:\Users\Louis\Desktop\DSP\Final exam'

% Use FFT?
use_fft = 1;

% Start timing

tic

%% Read audio from file

[input, Fs1] = audioread('New_clean_male.wav');

%% Create frames from vector

len = length(input);
nFrames = ceil(len/256);

[dataFrames, len1] = createFrames(input,nFrames);

%% Take FFT of data frames

N = 256;

if (use_fft)
    framesFFT = fft(dataFrames,N);
else
    framesFFT = dft(dataFrames);
end

%% Select first M components

M = 128;

framesFFT_reduced = framesFFT(1:M,:);

%% Take IFFT

if (use_fft)
    output_frames = ifft(framesFFT_reduced);
else
    output_frames = idft(framesFFT_reduced);
end



%% Convert frames to vector

output = createVector(output_frames);

%% Create plots

plot(input)

figure()

plot(abs(output))

%% Calculate SNR

snr_result = snr(abs(output))

%% Stop timing

toc

%% Function definitions

function output = dft(input)
    [rows,columns] = size(input);
    
    len = rows;
    
    output = zeros(rows,columns);
    
    for i = 1:columns
        for k = 0:len-1
            for n = 0:len-1
                output(k+1,i) = output(k+1,i) + input(n+1,i)*exp(-j*pi/2*n*k);
            end
        end
    end
end

function output = idft(input)
    [rows,columns] = size(input);
    
    len = rows;
    
    for i = 1:columns
        for k = 0:len-1
            for n = 0:len-1
                output(k+1,i) = (exp(j*2*pi*k'*n)/len) * input(k+1,i)/len;
            end
        end
    end
end

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