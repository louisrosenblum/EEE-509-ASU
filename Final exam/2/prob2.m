% Louis Rosenblum
% EEE509 - ASU
% 06/25/2020
% Final exam part B

%% Plot hamming versus rectangular window

figure()

b = [1 0.9];
a = [1];

[h,w] = freqz(b,a);

plot(w/pi,20*log10(abs(h).^2))
ax = gca;
ax.XTick = 0:.5:2;
title("Power Spectral Density of y(n)")
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
