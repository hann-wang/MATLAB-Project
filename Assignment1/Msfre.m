function [fre]=Msfre(array)
	temp=[];
	Fs=8000;
	for i=1:1000
		temp=[temp;array];
	end
	f=fft(temp,8000);
	r=abs(f);
	%plot(r);
	%axis([0 400 -600 600]);
	%getframe();
	fre=find(r>70);
	
