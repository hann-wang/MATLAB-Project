clear
load hall
origin=dct2(hall_gray);
d_r=[origin(:,1:size(origin,2)-4) zeros(size(origin,1),4)];
d_l=[zeros(size(origin,1),4) origin(:,5:size(origin,2))];
id_r=idct2(d_r);
id_l=idct2(d_l);
figure
imshow(hall_gray);
figure
imshow(id_r);
figure
imshow(id_l);
