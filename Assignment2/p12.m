clear
e=[1 0 0];
s=[1 -1.3789 0.9506];
zplane(e,s);
[z p k]=tf2zp(e,s);
a=angle(p);
a=a+150/8000*pi*2*sign(a);
p=abs(p).*exp(a*i);
[e s]=zp2tf(z,p,k);
figure()
zplane(e,s);
s
