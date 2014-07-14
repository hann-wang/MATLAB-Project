function [array]=readscript(Fs)
	data=load('script.dat');
	array=[];
	m=size(data,1);
	count=0;	
	fre=0;
	for i=1:size(data,1)
		switch data(i,1)
		case 1
			fre=261.63;
		case 2
			fre=293.66;
		case 3
			fre=329.63;
		case 4
			fre=349.23;
		case 5
			fre=392;
		case 6
			fre=440;
		case 7
			fre=523.25;
		end
		fre=fre*2^(data(i,3)/12);
		%disp(fre)
		temp=frequency(fre,Fs,data(i,2));
		array=[array zeros(1,count*Fs+size(temp,2)-size(array,2))];	%extend array  
		array=array+[zeros(1,count*Fs) temp];
		count=count+2/data(i,2);
	end
