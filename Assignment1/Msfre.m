function [fre]=Msfre(array)
	temp=[];
	Fs=8000;
	for i=1:1000
		temp=[temp;array];
	end
	f=fft(temp,8000);
	r=abs(f);
	plot(r);
	axis([100 800 0 600]);
	getframe();
	for i=1:300
		fre=find(r>i);
		num=find(fre<800);
		N=size(num,1);
		if N<7
			break
		end
	end
	[fre(num) r(fre(num))]
	
