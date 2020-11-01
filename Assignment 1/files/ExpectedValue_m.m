% loading thedata
load data1;

% plotting the realizations over time
plot(data1.x)
xlabel(['t']);
ylabel('x(t)');
title(['Realization']);
set(gcf,'position',[300,300,400,300])
saveas(gcf, 'data1.jpg');

mu = mean(data1.x)

s = std(data1.x);
n = 100;
alpha = 0.05;

% student value
st = tinv(1-alpha/2, n-1);

% The confidence interval of an unknown variance
a = mu - (s*st)/sqrt(n);
b = mu + (s*st)/sqrt(n);

% The final result
[a b]

