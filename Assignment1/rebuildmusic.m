clear
load Guitar.MAT
temp=[];
Fs=8000;
for i=1:1000
	temp=[temp;wave2proc];
end
f=fft(temp,8000);
r=abs(f);
plot(r);
%axis([0 400 -600 600]);
%getframe();
[find(r>160) r(find(r>160))]	
