function [array]=frequencyG(fre,Fs,time)
	time=4/time*0.5;
	t=Fs/fre;
	l=floor(Fs*time*1.1);
	%With 5%space+5%start+20%lose+60%maintain+10%lose+10%overlapping
	array=zeros(l,1);
	for i=1:l
		array(i)=array(i)+sin(i/t*2*pi);
		array(i)=array(i)+0.227/0.2*sin(i/t*2*2*pi);
		array(i)=array(i)+0.17/0.2*sin(i/t*3*2*pi);
		array(i)=array(i)+0.233/0.2*sin(i/t*4*2*pi);
	end
	array=array';

	
