clear
load hall;
origin=dct2(hall_gray);
r=origin';
r_90=rot90(origin);
r_180=rot90(r_90);
figure
imshow(uint8(idct2(r)));
figure
imshow(uint8(idct2(r_90)));
figure
imshow(uint8(idct2(r_180)));

