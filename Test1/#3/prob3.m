% Louis Rosenblum
% 06/13/2020
% Test 1
% EEE509 - ASU

%% Initialization

cd 'C:\Users\Louis\Desktop\DSP\Test1\#3';

close all
%% Problem #3

[x,Fs] = audioread('cleanspeech.wav');

xFrames = createFrames(x,ceil(length(x)/256))


%% Select a random vowel frame

i = ceil(rand(1,1)*10);
k = 1;

if (i == 1)
    k = 71;
elseif (i == 2)
    k = 123;
elseif (i == 3)
    k = 54;
elseif (i == 4)
    k = 5;
elseif (i == 5)
    k = 109;
elseif (i == 6)
    k = 97;
elseif (i == 7)
    k = 96;
elseif (i == 8)
    k = 22;
elseif (i == 6)
    k = 6;
else
    k = 89;
end

%% Time domain plot

t = 0:1/Fs:255/Fs

plot(t,xFrames(:,k));
title("Time Domain Frame Plot");
ylabel("Amplitude");
xlabel("Time relative to frame(s)");

%% FFT Plot

H = fft(xFrames(:,k));
                  
T = 1/Fs;             % Sampling period       
L = 256;             % Length of signal
t = (0:L-1)*T;        % Time vector

P2 = abs(H);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,20*log(P1)) 
p = strcat('Single-Sided Amplitude Spectrum of Frame ',string(k));
title(p)
xlabel('f (Hz)')
ylabel('dB')

%% LPC

a = lpc(xFrames(:,k),10);
b = [0 0 0 0 0 0 0 0 0 0 1];

sys = tf(b,a);

options = bodeoptions;
options.FreqUnits = 'Hz';

bode(sys,options);
p = strcat('All Pole Filter Bode Plot for Frame ',string(k));
title(p)

%% Pole-zero plot

pzmap(sys)
p = strcat('Pole-zero Map for Frame ',string(k));
title(p)

%% Select 3 frames

periodic = xFrames(:,109);
random = xFrames(:,36);
mid = xFrames(:,63);

%% Plot periodic frame

t = 0:1/Fs:255/Fs

figure();
plot(t,periodic);
title("Time Domain Periodic Frame Plot");
ylabel("Amplitude");
xlabel("Time relative to frame");

figure();
H = fft(periodic);
                  
T = 1/Fs;             % Sampling period       
L = 256;             % Length of signal
t = (0:L-1)*T;        % Time vector

P2 = abs(H);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,20*log(P1)) 
title('Single-Sided Spectrum of Periodic Frame')
xlabel('f (Hz)')
ylabel('dB')

figure();
a = lpc(periodic,10);
b = [0 0 0 0 0 0 0 0 0 0 1];

sys = tf(b,a);

options = bodeoptions;
options.FreqUnits = 'Hz';

bode(sys);
title('All Pole Filter Bode Plot for Periodic Frame')

%% Plot random frame

t = 0:1/Fs:255/Fs

figure();
plot(t,random);
title("Time Domain Random Frame Plot");
ylabel("Amplitude");
xlabel("Time relative to frame");

figure();
H = fft(random);
                  
T = 1/Fs;             % Sampling period       
L = 256;             % Length of signal
t = (0:L-1)*T;        % Time vector

P2 = abs(H);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,20*log(P1)) 
title('Single-Sided Spectrum of Random Frame')
xlabel('f (Hz)')
ylabel('dB')

figure();
a = lpc(random,10);
b = [0 0 0 0 0 0 0 0 0 0 1];

sys = tf(b,a);

options = bodeoptions;
options.FreqUnits = 'Hz';

bode(sys);
title('All Pole Filter Bode Plot for Random Frame')

%% Plot midway frame

t = 0:1/Fs:255/Fs

figure();
plot(t,mid);
title("Time Domain Midway Frame Plot");
ylabel("Amplitude");
xlabel("Time relative to frame");

figure();
H = fft(mid);
                  
T = 1/Fs;             % Sampling period       
L = 256;             % Length of signal
t = (0:L-1)*T;        % Time vector

P2 = abs(H);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,20*log(P1)) 
title('Single-Sided Spectrum of Midway Frame')
xlabel('f (Hz)')
ylabel('dB')

figure();
a = lpc(mid,10);
b = [0 0 0 0 0 0 0 0 0 0 1];

sys = tf(b,a);

options = bodeoptions;
options.FreqUnits = 'Hz';

bode(sys);
title('All Pole Filter Bode Plot for Midway Frame')


%% Function definitions

function [data, len] = createFrames(audio,nFrames)
    len = length(audio);
 	frameSize = ceil(len/nFrames);
    total = frameSize*nFrames;
    z = total - len;
    pad = [audio;zeros(z,1)];
    data = reshape(pad,frameSize,nFrames);
end