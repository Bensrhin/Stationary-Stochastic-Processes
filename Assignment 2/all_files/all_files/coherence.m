load threeprocessdata;
n = length(y1);
y = [x1 x2 x3];
figure()
t = tiledlayout(3,3);
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
L = lenwin(90, x1);
% Welch's method
for k=1:3
    nexttile;
    [Rhat,f]=pwelch(y(1:end,k),hanning(L),[],2048, 1);
    plot(f, Rhat)
    xlabel(['f']);
    ylabel('R(f) ');
    title(['Welch 50% overlap : y' num2str(k)]);
    set(gca,'xlim', [0 0.5]);
end

%--------------------------------------------------------
L = lenwin(10, x1);
figure()
t = tiledlayout(1,2);
nexttile;
mscohere(x1,y1,hanning(L),[],4096);
nexttile;
mscohere(x3,y1,hanning(L),[],4096);


set(gcf,'position',[300,300,1000,1000])
saveas(gcf, 'covariance.jpg');
%------------------------------------------------------------
function L = lenwin(K,x)
    % K : number of time-shifted windows
    Lm = 2*length(x)/(K+1);
    L = round(Lm) - 1;
end
%------------------------------------------------------------