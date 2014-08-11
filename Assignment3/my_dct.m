function ans=my_dct(input)
[h,w]=size(input);
d=zeros(h,w);
for i=1:h
	for j=1:w
		if i==1
			d(i,j)=sqrt(1/h);
		else
			d(i,j)=sqrt(2/h)*cos((i-1)*(2*j-1)*pi/2/h);
		end
	end
end
ans=d*double(input)*d';

		
