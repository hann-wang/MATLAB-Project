close all
clear
image=imread('graygroundtruth.jpg');
figure(1)
imshow(image)
[h w]=size(image);
mean_h=mean(image,1);
mean_v=mean(image,2);
min_h=min(mean_h);
min_v=min(mean_v);
min_fil_h=min_h+30;
min_fil_v=min_v+30;
s_h=mean_h-min_fil_h;
s_v=mean_v-min_fil_v;
s_h=abs(s_h)-s_h;
s_v=abs(s_v)-s_v;
s_h=mean(s_h)-s_h;
s_v=mean(s_v)-s_v;
mean_h=mean_h-mean(mean_h);
mean_v=mean(image,2);
mean_v=mean_v-mean(mean_v);
figure(2);
subplot(2,1,1)
plot(mean_h)
subplot(2,1,2)
plot(mean_v)
[t omg_h FT_h IFT]=prefourier([0 1],w,[0 1000],w);
fft_h_abs=abs(FT_h*mean_h');
[t omg_v FT_v IFT]=prefourier([0 1],h,[0 1000],h);
fft_v_abs=abs(FT_v*mean_v);
figure(3);
subplot(2,1,1)
plot(fft_h_abs)
subplot(2,1,2)
plot(fft_v_abs)
h_s=find(fft_h_abs==max(fft_h_abs),1)
w_s=find(fft_v_abs==max(fft_v_abs),1)
h_size=2*pi*w/omg_h(h_s);
w_size=2*pi*h/omg_v(w_s);

block_h=floor(w/h_size);
gap_h=0;
for i=1:block_h
	temp=mean_h((i-1)*h_size+1:i*h_size);
	gap_h=gap_h+find(temp==min(temp),1);
end
gap_h=floor(gap_h/block_h);

block_v=floor(h/w_size);
gap_v=0;
for i=1:block_v
	temp=mean_v((i-1)*w_size+1:i*w_size);
	gap_v=gap_v+find(temp==min(temp),1);
end
gap_v=floor(gap_v/block_v);

figure(4)
for i=1:block_v
	for j=1:block_h
		subplot(block_v,block_h,(i-1)*block_h+j)
		v_s=floor(gap_v+(i-1)*w_size+1);
		v_e=floor(gap_v+i*w_size);
		h_s=floor(gap_h+(j-1)*h_size+1);
		h_e=floor(gap_h+j*h_size);
		sublock=uint8(image(v_s:v_e,h_s:h_e));
		imshow(sublock);
	end
end
