function [array]=frequencyG_pro(fre,Fs,time)
	time=4/time*0.5;
	t=Fs/fre;
	l=floor(Fs*time*1.1);
	%With 5%space+5%start+20%lose+60%maintain+10%lose+10%overlapping
	array=zeros(l,1);
	wav=log10(linspace(1,10,floor(0.2*l)));
	wav=[wav logspace(0,-2,floor(0.5*l))];	
	strength=zeros(1,l);
	strength=strength+[wav zeros(1,l-size(wav,2))];
	strength=strength+[zeros(1,floor(0.15*l)) 0.4*wav zeros(1,l-size(wav,2)-floor(0.15*l))];
	%plot(strength);	
	for i=1:l
		array(i)=array(i)+sin(i/t*2*pi);
		array(i)=array(i)+0.227/0.2*sin(i/t*2*2*pi);
		array(i)=array(i)+0.17/0.2*sin(i/t*3*2*pi);
		array(i)=array(i)+0.233/0.2*sin(i/t*4*2*pi);
	end
	array=array'.*strength;

	
