function s = fof(w, bw, amp, at, phi, sr)
% w = center frequency (Hz)
% bw = bandwidth (in samples)
% amp = amplitude
% at = attack time (in samples)
% phi = phase (in radians)
% sr = sample rate
% y = vector containing the time domain samples of a FOF

T = 1 / sr; % time interval

beta = pi / at; % at = pi / beta
alpha = bw / pi; % alpha * pi = bw at -3dB
omega = 2 * pi * w; %center frequency (rad/sec)

t_nsamples = (0 : T : 1 - T); % time vector

s = zeros(1,length(t_nsamples));

k_attack = t_nsamples(1:at);
k_decay = t_nsamples(at + 1:length(t_nsamples));

s(1:at) = amp * 0.5 * (1-cos(beta .* k_attack)) ...
    .* exp(- alpha .* k_attack) .* sin(omega .* k_attack + phi);
s(at + 1 : length(t_nsamples)) = amp * exp(- alpha .* k_decay) ...
    .* sin(omega .* k_decay + phi);


end