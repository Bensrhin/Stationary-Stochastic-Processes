
% AR(1)-process
ar(0.5);

% Try a positive and a negative value of a1
a1 = [0.5 -0.5];

% covariance function
figure();
t = tiledlayout(1,2);
for k=1:2
    nexttile;
    [r, f, R] = ar_cov(a1(k));
    stem([0:49],r(1:50));
    xlabel(['τ']);
    ylabel('r(τ)');
    title(['Covariance function of a1=' num2str(a1(k))]);
    set(gca,'xlim', [0 50]);
end

% spectral density
figure();
t = tiledlayout(1,2);
for k=1:2
    nexttile;
    [r, f, R] = ar_cov(a1(k));
    plot(f, R);
    xlabel(['f']);
    ylabel('R(f)');
    title(['spectral densityf of a1=' num2str(a1(k))]);
    %set(gca,'xlim', [0 1]);
end

%-----------------------------------------------------------------------
% To  simulate  a  realisation  of  the  AR-process
n=400;
%m = 0;
%sigma = 1;
%e = normrnd(m, sigma, 1, n);
% e = randn(1,n);
%x= filter(C,A,e);

% Xt
figure();
t = tiledlayout(1,2);
for k=1:2
    nexttile;
    x = ftr(a1(k), n);
    plot(x);
    xlabel(['t']);
    ylabel('X(t)');
    title(['Realization for a1=' num2str(a1(k))]);
end


% Study of an ARMA(2,2)-process
figure()
A=[1 -1 0.5];
C=[1 1 0.5];
P = roots(A);
Z = roots(C);
zplane(Z,P);
[H,w]=freqz(C,A);
R=abs(H).^2;
f = w/2/pi;
figure()
plot(f, R);

function x = ftr(a1, n)
    C = 1;
    A = [1 a1];
    e = randn(1,n);
    x = filter(C,A,e);
end

function [r,f, R] = ar_cov(a1)
    C = 1;
    A = [1 a1];
    [H,w]=freqz(C,A,512,'whole');
    R=abs(H).^2;
    r=ifft(R);
    f = w/2/pi;
end


function [R,f] = ar(a1)
    C = 1;
    A = [1 a1];
    [H,w]=freqz(C,A);
    R=abs(H).^2;
    f = w/2/pi;
end