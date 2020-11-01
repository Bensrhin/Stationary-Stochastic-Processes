load threeprocessdata;
n = length(y1);
y = [y1 y2 y3];
t = tiledlayout(5,3);
% Plot the sequences
for k=1:3
    nexttile;
    plot(y(1:end,k));
    xlabel(['t']);
    ylabel(['y' num2str(k) '(t)']);
    title(['Sequence y' num2str(k)]);
    set(gca,'xlim', [0 500])
end
% Estimating the covariance function
for k=1:3
    nexttile;
    [ycov,lags]=xcov(y(1:end,k),50,'biased');
    plot(lags, ycov)
    xlabel(['τ']);
    ylabel('r(τ)');
    title(['Covariance function of y' num2str(k)]);
    set(gca,'xlim', [0 50]);
end

% Estimating the spectral density
%------------------------------------------------------------
% The periodogram
for k=1:3
    nexttile;
    [Rhat,f]=periodogram(y(1:end,k),[],2048,1);
    plot(f, 10*log10(Rhat))
    xlabel(['f']);
    ylabel('10log10(R(f)) ');
    title(['Periodogram of y' num2str(k)]);
    set(gca,'xlim', [0 0.5]);
end


L = lenwin(10, y1);
% Welch's method
for k=1:3
    nexttile;
    [Rhat,f]=pwelch(y(1:end,k),hanning(L),[],2048, 1);
    plot(f, 10*log10(Rhat))
    xlabel(['f']);
    ylabel('10log10(R(f)) ');
    title(['Welch 50% overlap : y' num2str(k)]);
    set(gca,'xlim', [0 0.5]);
end
%--------------------------------------------------------
% The thomson multitaper estimator with 10 multitapers
for k=1:3
    nexttile;
    pmtm(y(1:end,k),(11-1)/2,[],2048);
    xlabel(['f']);
    ylabel('10log10(R(f)) ');
    title(['Thomson 11 multitapers: y' num2str(k)]);
    %set(gca,'xlim', [0 0.5]);
end


set(gcf,'position',[300,300,1000,1000])
saveas(gcf, 'covariance.jpg');
%------------------------------------------------------------
function L = lenwin(K,x)
    % K : number of time-shifted windows
    Lm = 2*length(x)/(K+1);
    L = round(Lm) - 1;
end
%------------------------------------------------------------
