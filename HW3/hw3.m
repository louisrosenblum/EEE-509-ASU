% Louis Rosenblum
% HW3
% EEE509-ASU
% 06/12/2020

%% Problem #18 (Chapter 5)
Fs = 8000;
Fn = Fs/2;
wp = 1200/Fn;
ws = 1800/Fn;
pb = -1;
sb = -30;

[N,Wn] = buttord(wp,ws,pb,sb);
[z,p,k] = butter(N,Wn);

N

z

p

%% Problem #1

b = [1 -1.8 1.62 -0.729];

a = [-0.729 1.62 -1.8 1];

%% 1-a
[z,p,k] = tf2zp(b,a);

z

p

%% 1-b

sys = tf(b,a);

bode(sys)

%% 1-d

a = [-0.85 0 0 0 0 1];
b = [0 0 0 0 0 1];

[z,p,k] = tf2zp(b,a);

sys = tf(b,a);
bode(sys)

%% Problem #2
% Butterworth filter

Fs = 10000;
Fn = Fs/2;
wp = 3000/Fn;
ws = 4000/Fn;
rp = 2;
rs = 50;

[N,Wn] = buttord(wp,ws,rp,rs)
[b,a] = butter(N,Wn);

sys = tf(b,a);
bode(sys)
k = strcat(string(N),"th Order Butterworth Filter");
title(k)

%% Chebychev filter

Fs = 10000;
Fn = Fs/2;
wp = 3000/Fn;
ws = 4000/Fn;
rp = 2;
rs = 50;

[N,Wn] = cheb1ord(wp,ws,rp,rs)
[b,a] = cheby1(N,rs,Wn);

sys = tf(b,a);
bode(sys)
k = strcat(string(N),"th Order Chebychev Filter");
title(k)

