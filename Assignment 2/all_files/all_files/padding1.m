load unknowndata;
mu = mean(data);
% the mean of the data is not zero

% we adjust the data to zero-mean by substracting
% the mean from all components of the data
x = data - mu;
mean(x)
%--------------------------------------------
% implement the periodogram using the DFT:
X = fft(x);
n = length(x);
Rhat=(X.*conj(X))/n;
f=[0:n-1]/n;
% plot(f,Rhat)
figure()
plot(f-0.5,fftshift(Rhat))
%--------------------------------------------
% zero-padding for much better resolution
N = 4096;
X=fft(x,N);
Rhat=(X.*conj(X))/n;
f=[0:N-1]/N;
figure()
plot(f,Rhat)
figure();
plot(f-0.5,fftshift(Rhat))
%--------------------------------------------
% the estimated covariance function
rhat=ifft(Rhat);
figure()
plot([0:15],rhat(1:16))
%--------------------------------------------



