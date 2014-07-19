clear
e=[1 0 0];
s=[1 -1.3789 0.9506];
zplane(e,s);
figure()
freqz(e,s);
figure()
impz(e,s);
figure()
plot(filter(e,s,[1 zeros(1,400)]),'o');
