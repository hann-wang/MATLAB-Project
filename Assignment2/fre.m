function [array]=fre(fre,Fs,time)
	l=floor(Fs*time);
	array=zeros(1,l);
	t=1:l;
	array=(mod(t,floor(Fs/fre))==0);
