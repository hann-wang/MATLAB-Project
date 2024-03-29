close all
%clear
image=imread('graygroundtruth.jpg');
%image=imread('graycapture.jpg');
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

temp=mean_h(1:h_size*0.5);
gap_h=find(temp==min(temp),1);

block_v=floor(h/w_size);

temp=mean_v(1:w_size*0.5);
gap_v=find(temp==min(temp),1);

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


HPF1=fir1(32,0.4,'high');
HPF2=zeros(21,21);
for i=1:21
	for j=1:21
		HPF2(i,j)=HPF1(17+floor(sqrt((i-11)^2+(j-11)^2))+1);
	end
end
figure(5)
subplot(1,2,1)
stem(HPF1)
subplot(1,2,2)
mesh(-HPF2)
image=double(image-127);

HP_image=conv2(HPF2,image);
HP_image=HP_image(11:h+10,11:w+10);

result=zeros(block_h*block_v,block_h*block_v)-1;
mtx=zeros(block_v,block_h);
count=0;

for m=1:block_h*block_v
	i=ceil(m/block_h);
	j=mod(m,block_h);
	if j==0
		j=block_h;
	end
	if mtx(i,j)==0
		count=count+1;
		mtx(i,j)=count;
	end

	v_s_1=floor(gap_v+(i-1)*w_size+1);
	v_e_1=v_s_1+floor(w_size);
	h_s_1=floor(gap_h+(j-1)*h_size+1);
	h_e_1=h_s_1+floor(h_size);

	for n=m+1:block_h*block_v
		x=ceil(n/block_h);
		y=mod(n,block_h);
		if y==0
			y=block_h;
		end
		if mtx(x,y)~=0
			continue;
		end
		v_s_2=floor(gap_v+(x-1)*w_size+1);
		v_e_2=v_s_2+floor(w_size);
		h_s_2=floor(gap_h+(y-1)*h_size+1);
		h_e_2=h_s_2+floor(h_size);
		sublock_1=HP_image(v_s_1:v_e_1,h_s_1:h_e_1);
		sublock_2=HP_image(v_s_2:v_e_2,h_s_2:h_e_2);
		r_temp=max(max(xcorr2(double(sublock_1),double(sublock_2))))/(norm(double(sublock_1(:)))* norm(double(sublock_2(:))));
		result(m,n)=max(r_temp);
		if r_temp > 0.8
			mtx(x,y)=count;
		end
	end
end
image=imread('graygroundtruth.jpg');
%image=imread('graycapture.jpg');
close all
for i=1:max(max(mtx))
	figure(i)
	[c l]=find(mtx==i);
	n=length(c);
	subimage=[];
	for j=1:n
		v_s_1=floor(gap_v+(c(j)-1)*w_size+1);
		v_e_1=v_s_1+floor(w_size);
		h_s_1=floor(gap_h+(l(j)-1)*h_size+1);
		h_e_1=h_s_1+floor(h_size);
		subimage=[subimage image(v_s_1:v_e_1,h_s_1:h_e_1)];
	end
	imshow(subimage)
end
mtx
%{
temp=result;
image=imread('graygroundtruth.jpg');
for k=1:400
	total=max(max(temp));
	[m n]=find(temp==total);
	temp(m,n)=0;
	i=ceil(m/block_h);
	j=mod(m,block_h);
	if j==0
		j=block_h;
	end
	x=ceil(n/block_h);
	y=mod(n,block_h);
	if y==0
		y=block_h;
	end
	v_s_1=floor(gap_v+(i-1)*w_size+1);
	v_e_1=v_s_1+floor(w_size);
	h_s_1=floor(gap_h+(j-1)*h_size+1);
	h_e_1=h_s_1+floor(h_size);
	v_s_2=floor(gap_v+(x-1)*w_size+1);
	v_e_2=v_s_2+floor(w_size);
	h_s_2=floor(gap_h+(y-1)*h_size+1);
	h_e_2=h_s_2+floor(h_size);
	sublock_1=image(v_s_1:v_e_1,h_s_1:h_e_1);
	sublock_2=image(v_s_2:v_e_2,h_s_2:h_e_2);
	figure(k)
	imshow([sublock_1 sublock_2])
	title(sprintf('%f',total))
end
%}
