% Louis Rosenblum
% HW3
% EEE509-ASU
% 06/12/2020

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