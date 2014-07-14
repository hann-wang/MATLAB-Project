function [array]=readscript(Fs,Base,scriptname)
	data=load(scriptname);
	array=[];
	m=size(data,1);
	count=0;	
	fre=0;
	b=0;
	switch Base
	case 'C'
		b=0;
	case 'D'
		b=2;
	case 'E'
		b=4;
	case 'F'
		b=5;
	case 'G'
		b=7;
	case 'A'
		b=9;
	case 'B'
		b=11;
	end
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
		case 0
			fre=0;
		end
		if data(i,2)==2.67
				data(i,2)=8/3;
		end
		fre=fre*2^((data(i,3)+b)/12);
		%disp(fre)
		temp=frequency(fre,Fs,data(i,2));
		array=[array zeros(1,count*Fs+size(temp,2)-size(array,2))];	%extend array  
		array=array+[zeros(1,count*Fs) temp];
		count=count+2/data(i,2);
	end
