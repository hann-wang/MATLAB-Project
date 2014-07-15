function [fre]=Msfre(array)
	temp=[];
	for i=1:100
		temp=[temp;array];
	end
	f=fft(temp);
	size(f)
	r=f(1:size(f,1));
	r=abs(f)./size(f);
	plot(abs(r))
	[m,fre]=max(r);
	fre=fre*8192/size(f,1);
	find(r>100)*8192/size(f,1)
	
