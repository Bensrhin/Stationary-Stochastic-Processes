% n = 2
cello2.x=cello.x(1:2:end);
cello2.dt=cello.dt*2;
% without aliasing
cello2filter.x=decimate(cello.x,2);
cello2filter.dt=cello.dt*2;

trombone2.x=trombone.x(1:2:end);
trombone2.dt=trombone.dt*2;
% without
trombone2filter.x=decimate(trombone.x,2);
trombone2filter.dt=trombone.dt*2;

% n = 3
cello3.x=cello.x(1:3:end);
cello3.dt=cello.dt*3;

trombone3.x=trombone.x(1:3:end);
trombone3.dt=trombone.dt*3;

% n = 4
cello4.x=cello.x(1:4:end);
cello4.dt=cello.dt*4;

trombone4.x=trombone.x(1:4:end);
trombone4.dt=trombone.dt*4;

