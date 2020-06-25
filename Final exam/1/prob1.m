h1 = [0.0037 (0.0054+0.0158*j) (0.082) (-0.033-0.194*j) 0.637 (-0.033+0.194*j) 0.082 (0.0054 - 0.0158*j) 0.0037];
h2 = [0.0468 (0.0259 + 0.075*j) 0.1514 (-0.038 - 0.2251*j) 0.637 (-0.038 + 0.2251*j) 0.1514 (0.0259-0.075*j) 0.0468];

x = 0:8;
stem(x,abs(h))
title("Band-stop filter impulse response");
ylabel("Amplitude");
xlabel("Sample (n)");

%% Calculate group delay

b = h1;
a = [1];

delay = grpdelay(b,a);

maximum = max(delay)
average = mean(delay)
minimum = min(delay)

%% Plot hamming versus rectangular window

figure()

b = h1;
a = [1];

[h,w] = freqz(b,a);
w = w.*16000;

plot(w/pi,20*log10(abs(h)))
xlabel('Frequency (hz)')
ylabel('Magnitude (dB)')
hold on;

b = h2;
a = [1];

[h,w] = freqz(b,a);
w = w.*16000;
plot(w/pi,20*log10(abs(h)))

title("Band-stop filter frequency response")
legend("Hamming window","Rectangular window")