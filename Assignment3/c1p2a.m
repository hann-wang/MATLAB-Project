load hall.mat
[h w rgb]=size(hall_color);
r=min(h,w)/2;
x_c=w/2;
y_c=h/2;
for i=1:h
	for j=1:w
		if r>=sqrt((i-y_c)^2+(j-x_c)^2)
			hall_color(i,j,1)=255;
			hall_color(i,j,2)=0;
			hall_color(i,j,3)=0;
		end
	end
end
imshow(hall_color);
