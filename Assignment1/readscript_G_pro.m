function [array]=readscript_G_pro(Fs,Base,scriptname)
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
			fre=fre*2^((data(i,3)+b)/12);
			temp=frequencyG_pro(fre,Fs,data(i,2));
			temp=temp+158/89*frequencyG_pro(2*fre,Fs,data(i,2));
		case 2
			fre=293.66;
			fre=fre*2^((data(i,3)+b)/12);
			temp=frequencyG_pro(fre,Fs,data(i,2));
			temp=temp+129/148*frequencyG_pro(2*fre,Fs,data(i,2));
		case 3
			fre=329.63;
			fre=fre*2^((data(i,3)+b)/12);
			temp=frequencyG_pro(fre,Fs,data(i,2));
			temp=temp+185/160*frequencyG_pro(2*fre,Fs,data(i,2));
			temp=temp+59/160*frequencyG_pro(1.5*fre,Fs,data(i,2));
		case 4
			fre=349.23;
			fre=fre*2^((data(i,3)+b)/12);
			temp=frequencyG_pro(fre,Fs,data(i,2));
			temp=temp+67/73*frequencyG_pro(2*fre,Fs,data(i,2));
		case 5
			fre=392;
			fre=fre*2^((data(i,3)+b)/12);
			temp=frequencyG_pro(fre,Fs,data(i,2));
			temp=temp+218/414*frequencyG_pro(2*fre,Fs,data(i,2));
			temp=temp+133/414*frequencyG_pro(3*fre,Fs,data(i,2));
		case 6
			fre=440;
			fre=fre*2^((data(i,3)+b)/12);
			temp=frequencyG_pro(fre,Fs,data(i,2));
			temp=temp+85/252*frequencyG_pro(2*fre,Fs,data(i,2));
		case 7
			fre=523.25;
			fre=fre*2^((data(i,3)+b)/12);
			temp=frequencyG_pro(fre,Fs,data(i,2));
			temp=temp+85/252*frequencyG_pro(2*fre,Fs,data(i,2));
		case 0
			fre=0;
		end
		if data(i,2)==2.67
				data(i,2)=8/3;
		end
		%disp(fre)
		array=[array zeros(1,count*Fs+size(temp,2)-size(array,2))];	%extend array  
		array=array+[zeros(1,count*Fs) temp];
		count=count+2/data(i,2);
	end
