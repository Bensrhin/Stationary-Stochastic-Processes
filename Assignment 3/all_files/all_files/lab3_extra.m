%% Estimation of AR(20) parameters
[x,Fs] = audioread('fa.wav');       %Load audio file into Matlab. 
                                    % x is the audio, and Fs is the sampling frequency    
%sound(x,Fs);                        %Listen to audio
p = 20
n = length(x);               
t = (0:n-1)/Fs;
dt = p*10^(-3);                   % Set length of time-windows (20 ms)
dn = Fs*dt;                        % Sample length of each time-window
N_sec = floor(n/dn);               % Number of sections with length 20ms.

M = p;                             % Set AR modelorder
ar_param = zeros(N_sec,M+1);

for ii=1:N_sec                              % For each time frame:
    x_temp = x((ii-1)*dn+1:ii*dn);          % Pick out the ii:th  20 ms section
    X = x_temp(p+1:end);
    U = zeros(p, dn-p);
    for j=p:-1:1
        u = x_temp(j:dn-p-1+j);
        U(p+1-j,:) = -u;
    end
    U = U';
    ar_temp = (inv(U'*U)*U'*X);
    Q = (X-U*ar_temp)'*(X-U*ar_temp);
    e_temp = Q / (dn-p);
    % verify : DONE
    [r, e] = arcov(x_temp,p);
    %  
    % Estimate the ar_parameters of x_temp and store in ar_temp. If you use
    % a method that includes the inital 1-parameter; remove this. Ex if
    % your estimated parameters are [1 0.1 -0.1], set ar_temp = [0.1 -0.1].
    % Also estimate the variance of the noise, and save as e_temp. 
    ar_param(ii,:) = [ar_temp; e_temp];     % and save in ar_param. Why do we not need to save the first one?
    
end
whos x ar_param

%% Calculate spectrum

ii = floor(N_sec/2);                % Pick the middle section.
x_temp = x((ii-1)*dn+1:ii*dn);      % 
x_rec_temp=filter(1,[1 ar_param(ii,1:end-1)],sqrt(ar_param(ii,end))*randn(dn,1)); 
N_fft = 1024;

f = (0:N_fft-1)/N_fft;
Px = abs(fft(x_temp,N_fft)).^2/N_sec ;

w  = exp( 2i*pi*f );
Pa = (ar_param(ii,end)) ./abs( polyval([1 ar_param(ii,1:end-1)],w).' ).^2;


figure
semilogy(f,Px);
hold on
semilogy(f,Pa,'--');
legend('Speech','AR Reconstruction');


%% Recreation of audio

x_rec = zeros(n,1);
for jj = 1:N_sec        %Recreat the audio in each time frame using the AR parameters
   x_rec((jj-1)*dn+1:jj*dn)=filter(1,[1 ar_param(jj,1:end-1)],sqrt(ar_param(jj,end))*randn(dn,1)); 
end

figure(1)
subplot(211);
plot(t,x);
subplot(212);
plot(t,x_rec);



sound(x_rec,Fs)         % Listen to the reconstruction

