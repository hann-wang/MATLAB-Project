function [fre]=Msfre(array)
	temp=[];
	Fs=8000;
	for i=1:100
		temp=[temp;array];
	end
	f=fft(temp);
	r=abs(f)/size(f,1);
	plot(r)
	res=find(r>0.01)*Fs/size(f,1);
	fre=res(1);
	
