function [array]=cut(num)
	array=[];
	script=load('numarray.mat');
	wav=wavread('fmt.wav');
	if num == size(script)
		array=wav(script(i):size(wav,1));
	else
		array=wav(script(i):script(i+1));
	end

