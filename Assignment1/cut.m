function [array]=cut(num)
	load numarray
	wav=wavread('fmt.wav');
	if num == size(numarray)
		array=wav(numarray(num):size(wav,1));
	else
		array=wav(numarray(num):numarray(num+1));
	end
	Msfre(array);

