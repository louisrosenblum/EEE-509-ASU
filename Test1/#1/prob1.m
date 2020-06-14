% Louis Rosenblum
% Test 1 - Part B
% 06/13/2020
% EEE509-ASU

%% Question 1 - Part D

b = [1 0 1 0];
a = [0 -0.7 0 1];

[H,W] = freqz(b,a);

u = ones(512,1);

u_z = fft(u);

y_z = u_z .* H;

y = ifft(y_z)

plot(y)
title("Steady state response")
xlabel("Sample (n)")
ylabel("Magnitude")

%% Part E

sys = tf(b,a);

bode(sys)
