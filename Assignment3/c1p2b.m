load hall.mat
[h w rgb]=size(hall_color);
for i=1:h
	for j=1:w
		if mod(floor((i)/8)+floor((j)/8),2)==0
			hall_color(i,j,:)=0;
		end
	end
end
imshow(hall_color);
