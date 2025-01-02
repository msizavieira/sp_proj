sr = 44100;
f0 = 117;

duration = 1;
T = 1/sr;
t = (0:T:duration-T); %time vector
vowel = zeros(1,length(t));
wsize = round(sr/f0);

%w = [826.2 1433.5 2412.4 3320.7]; % vowel a
%bw = [147 107 185 156]; % vowel a
w = [345.8 2198.4 2894.9 3685.8]; % vowel i
bw = [242 253 84 204]; % vowel i
amp = [0.02 0.02 0.02 0.02];
at = [20 20 20 20];
phi = [0 0 0 0];

for form = 1:length(w)
    
    formant = fof(w(form),bw(form),amp(form),at(form),phi(form),sr);

    for i = 1:length(vowel)
        formantvalue = 0;
        if i >= sr-1
            zlen = sr-1;
        else
            zlen = i;
        end
    
        for z = mod(i,wsize):wsize:zlen
            formantvalue = formantvalue + formant(z+1);
        end
    
        vowel(i) = vowel(i) + formantvalue;
    end
end

soundsc(vowel,sr);
%{
figure
plot((1000:1500),vowel(1000:1500));
title('Synth Output');
xlabel('Sample');
ylabel('Amplitude');

figure
f = 0:sr/(length(vowel)):sr-sr/(length(vowel));
Y=fft(vowel);
plot(f,20*log10(abs(Y)));
xlim([0 sr/2]);
title('Synth Spectrum');
xlabel('Frequency(kHz)');
ylabel('Magnitude(dB)');
%}