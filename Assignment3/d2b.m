function array=d2b(x)
t=dec2bin(abs(x));
array=str2num(t(:));
if x<0
	array(:)=~array(:);
end
array=array';
