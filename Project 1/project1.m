% Louis Rosenblum
% EEE 509 - ASU
% 5/21/2020

%% Initialization
clear all
close all

cd 'C:\Users\Louis\Desktop\DSP\Project 1'
%% Section 1-1: Help
help

%% Section 1-2: Info
version
computer
%% Section 1-3: Load, Display, and Playback Speech Files 
%  (See function definitions at bottom of script)

[s,fs,bits] = ex13("cleanspeech.wav",1);

figure()
plot(s)
title("WAV File Plot");
xlabel("Sample");
ylabel("Amplitude");

figure()
plot(s,':')
title("WAV File Plot");
xlabel("Sample");
ylabel("Amplitude");

figure()
plot(s,'r:')
title("WAV File Plot");
xlabel("Sample");
ylabel("Amplitude");

figure()
plot(s(1:256))
title("WAV File Plot");
xlabel("Sample");
ylabel("Amplitude");

figure()
j=1:256;
plot(s(j));
title("WAV File Plot");
xlabel("Sample");
ylabel("Amplitude");

figure()
plot(j+512,s(j));
title("WAV File Plot");
xlabel("Sample");
ylabel("Amplitude");

figure()
N=256;
j=j+N;
plot(j,s(j))
title("WAV File Plot");
xlabel("Sample");
ylabel("Amplitude");

figure()
plot(s)
title('Cleanspeech time waveform');
xlabel('Sample Number');
ylabel('Normalized Amplitude');

% Test false case
[s,fs,bits] = ex13("cleanspeech.wav",0);

%% Section 1-4: Create m-file to Load and Display Two Speech Files Frame-by-Frame
%  (See function definitions at bottom of script)

close all

% Run function ex14
[s,fs,bits] = ex14("cleanspeech.wav","noisyspeech.wav",256);

%% Section 1-5:



%% Function definitions
function [s,fs,bits] = ex15( infile1, infile2, N )

% [s,fs,bits]=ex14(infile1,infile2)
%
% infile1, infile2 - .WAV input files
% N – frame size (in samples)
%
% s – signals loaded from infile1 and infile2
% fs – sample rates
% bits – bits per sample in each file
%
% Function loads infile1 and infile2, then displays
% records frame-by-frame. Computes average energy
% per sample in each file.

[s1,fs1] = audioread(infile1);
[s2,fs2] = audioread(infile2);

length1 = length(s1);
length2 = length(s2);
M = min(length1,length2);
K = fix(M/N);

e = s1-s2;

for k = 1:K
    % Compute indices for current frame
    n = (1:N)+(N*(k-1));
    % Signal 1
    subplot(211);
    plot(n,s1(n),'b',n,e(n),'g:');
    msg=sprintf('%s Frame %d',infile1,k);
    title(msg);
    ylabel('Normalized Amplitude');
    xlabel('Sample index');
    
    n = 0:N-1;
    Em1 = 1/N * (s1.^2 *(k*N+n));
    text(Em1);
    
    % Signal 2
    subplot(212);
    plot(n,s2(n),'b',n,e(n),'g:');
    msg=sprintf('%s Frame %d',infile2,k);
    title(msg);
    ylabel('Normalized Amplitude');
    xlabel('Sample index');
    % Pause between frames, waiting for keypress
    pause
end

info1 = audioinfo(infile1);
info2 = audioinfo(infile2);

s = [s1 s2];
fs = [fs1 fs2];
bits = [info1.BitsPerSample info2.BitsPerSample];




end

function [s,fs,bits] = ex14( infile1, infile2, N )
% [s,fs,bits]=ex14(infile1,infile2)
%
% infile1, infile2 - .WAV input files
% N – frame size (in samples)
%
% s – signals loaded from infile1 and infile2
% fs – sample rates
% bits – bits per sample in each file
%
% Function loads infile1 and infile2, then displays
% records frame-by-frame.

[s1,fs1] = audioread(infile1);
[s2,fs2] = audioread(infile2);

length1 = length(s1);
length2 = length(s2);
M = min(length1,length2);
K = fix(M/N);

e = s1-s2;

for k = 1:K
    % Compute indices for current frame
    n = (1:N)+(N*(k-1));
    % Signal 1
    subplot(211);
    plot(n,s1(n),'b',n,e(n),'g:');
    msg=sprintf('%s Frame %d',infile1,k);
    title(msg);
    ylabel('Normalized Amplitude');
    xlabel('Sample index');
    % Signal 2
    subplot(212);
    plot(n,s2(n),'b',n,e(n),'g:');
    msg=sprintf('%s Frame %d',infile2,k);
    title(msg);
    ylabel('Normalized Amplitude');
    xlabel('Sample index');
    % Pause between frames, waiting for keypress
    pause
end

info1 = audioinfo(infile1);
info2 = audioinfo(infile2);

s = [s1 s2];
fs = [fs1 fs2];
bits = [info1.BitsPerSample info2.BitsPerSample];
end



function [s,fs,bits] = ex13(infile, playstate)
% ex13(infile,playstate)
%
% infile - .WAV input file
% playstate – Switch playback on/off
%
% s – signal loaded from infile
% fs – sample rate
% bits – bits per sample
%
% Function loads infile, displays entire
% record, then optionally plays back the
% sound depending upon state of playstate

[y,Fs] = audioread(infile);

t = 0:1/Fs:(length(y)-1)/Fs;

%plot(t,y)

if(playstate)
    soundsc(y);
end

info = audioinfo(infile);


s = y;
fs = Fs;
bits = info.BitsPerSample;

end
