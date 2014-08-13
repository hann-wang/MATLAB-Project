load hall.mat;
load JpegCoeff.mat;
[h w]=size(hall_gray);
num_h=ceil(h/8);
num_w=ceil(w/8);
temp=zeros(num_h*8,num_w*8);
r=zeros(64,num_h*num_w);
temp(1:h,1:w)=double(hall_gray)-128;
for i=1:num_h
	for j=1:num_w
		r(:,(i-1)*num_w+j)=zigzag(round((dct2(temp((i-1)*8+1:i*8,(j-1)*8+1:j*8))./QTAB)));
	end
end


