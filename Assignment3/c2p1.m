load hall
block=hall_gray(1:8,1:8);
dct_128=dct2(128*ones(8,8));
dct_b=dct2(block);
dct_r=dct_b-dct_128;
dct_direct=dct2(double(block)-128*ones(8,8));
dct_direct-dct_r
