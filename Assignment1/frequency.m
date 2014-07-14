function [array]=frequency(fre,Fs,time)
	time=4/time*0.5;
	t=Fs/fre;
	l=floor(Fs*time*1.1);
	%With 10%start+20%lose+60%maintain+10%lose+10%overlapping
	array=zeros(l,1);
	strength=[zeros(1,floor(0.05*time*Fs)) linspace(0,1,floor(0.05*time*Fs)) linspace(1,0.8,floor(0.2*time*Fs)) 0.8*ones(1,floor(0.6*time*Fs)) linspace(0.8,0,(floor(1.1*time*Fs)-floor(0.05*time*Fs)-floor(0.6*time*Fs)-floor(0.2*time*Fs)-floor(0.05*time*Fs)))];
	for i=1:l
		array(i)=array(i)+sin(i/t*2*pi);
		array(i)=array(i)+0.2*sin(i/t*2*2*pi);
		array(i)=array(i)+0.3*sin(i/t*3*2*pi);
	%{
		if i<0.1*time*Fs
			
		else if i<0.3*time*Fs

		else if i<0.9*time*Fs

		else  

		end

	%}
	end
	array=array'.*strength;

	
