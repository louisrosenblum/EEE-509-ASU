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

length1 = length(mic1);
length2 = length(mic2);

%% 