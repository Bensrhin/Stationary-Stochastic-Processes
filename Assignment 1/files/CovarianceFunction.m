load covProc;
t = tiledlayout(1,3);
for k=1:3
    nexttile;
    plot(covProc(1:end-k),covProc(k+1:end),'.');
    xlabel(['y(t-' num2str(k) ')']);
    ylabel('y(t)');
    title(['ρ(t-' num2str(k) ', t)']);
end
width=700;
height=200;
set(gcf,'position',[300,300,width,height])
saveas(gcf, 'correlations.jpg');

% Estimating the covariance function
[ycov,lags]=xcov(covProc,20,'biased');
t = figure();
plot(lags, ycov)
xlabel(['τ']);
ylabel('r(τ)');
title(['Covariance function of the process']);
set(gcf,'position',[300,300,500,400])
saveas(gcf, 'covariance.jpg');

% Estimating the correlation function
[ycov,lags]=xcov(covProc,20,'coeff');
t = figure();
plot(lags, ycov)
xlabel(['τ']);
ylabel('ρ(τ)');
title(['Correlation function of the process']);
set(gcf,'position',[300,300,600,400])
saveas(gcf, 'correlation.jpg');
ycov