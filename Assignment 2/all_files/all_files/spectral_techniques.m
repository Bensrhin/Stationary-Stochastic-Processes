%--------------------------------------------
% Simulate a 500 sample realization of the ARMA(4,2)-process
e = randn(500,1);
modell.A=[1 -2.39 3.35 -2.34 0.96];
modell.C=[1 0 1];
x = filter(modell.C, modell.A, e);
figure()
plot(x)
%--------------------------------------------
% compute the spectral density RX(f)
[H,w]=freqz(modell.C,modell.A,2048);
R=abs(H).^2;
figure()
plot(w/2/pi,10*log10(R))
%--------------------------------------------
% Estimate the spectral density with zero-padding up to fft-length 4096,
figure()
% Using the periodogram function
periodogram(x,[],4096)

%================================================
% Using what we learn from the first exercise
%N=4096;
%n=length(x);
%X=fft(x,N);
%R=(X.*conj(X))/n;
%f=[0:N-1]/N;
%figure()
%plot(f-0.5,10*log10(fftshift(R)))
%set(gca,'xlim', [0 0.5])
%================================================

% receive the computed spectrum estimates
[Rhat,f]=periodogram(x,[],4096,1);
figure()
plot(f,Rhat) % Linear scale
figure()
semilogy(f,Rhat) % Logarithmic scale
%--------------------------------------------
% The large variation in the periodogram
var_periodogram = max(R.^2);

%--------------------------------------------
% The hanning windowed periodogram
figure()
periodogram(x,hanning(500),4096);
[Rhat,f]=periodogram(x,hanning(500),4096, 1);
figure()
semilogy(f,Rhat) % Logarithmic scale
%--------------------------------------------
% K : number of time-shifted windows
K = 10;
% Lm : the maximum length of time-shited window
Lm = 2*length(x)/(K+1);
Lm = round(Lm) - 1;
%==============================================

% welch method
figure()
[Rhat,f]=pwelch(x,hanning(Lm),[],4096, 1);

semilogy(f,Rhat);
xlabel(['Frequency']);
ylabel('Estimated spectrum');
title(['L=' num2str(Lm) ' length of the time-shifted window']);
set(gca,'xlim', [0 0.5]);
%---------------------------------------------------0---------------------
%--------------------------------------------
% The large variation in the welch periodogram
var_welch = max(Rhat.^2)
%---------------------------------------------------------------
% Variation
L = Lm;
e=randn(500,1);
Rhate=periodogram(e,[],4096);
Rhatew=pwelch(e,hanning(L),[],4096);
var(Rhate)/var(Rhatew);

%--------------------------------------------------------
% The thomson multitaper estimator with 10 multitapers
figure();
pmtm(x,(10-1)/2,[],4096);
Rhatet = pmtm(e,(10-1)/2,[],4096);
% Comparing the variances
var(Rhatet)/var(Rhatew);
