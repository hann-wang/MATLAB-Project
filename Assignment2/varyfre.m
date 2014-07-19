function [array]=varyfre()
	PT=80;
	Fs=8000;
	time=1;
	l=Fs*time;
	array=[];
	last_im=1;
	for i=1:100*time
		PTn=80+5*mod(i,50);
		array=[array fre(PTn,8000,0.01)];
	end



