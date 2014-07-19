clear
e=[1 0 0];
s=[1 -1.3789 0.9506];
result=filter(e,s,varyfre());
sound(varyfre());
pause(1);
sound(result);
plot(result);
