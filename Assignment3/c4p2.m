img=imread('test.jpg');
%img=imrotate(img,90);
[h w s]=size(img);
%img=imresize(img,[h,2*w]);
%img=imadjust(img,[0.2 0.8]);
[h w s]=size(img);


L=4;
v=train(L);
e=0.5;
n=2^(3*L);
u=zeros(1,n);
h_f=70;
w_f=70;
h_l=floor(h/h_f);
w_l=floor(w/w_f);
for i=1:h_l
	for j=1:w_l
		u=cpt_u(img((i-1)*h_f+1:i*h_f,(j-1)*w_f+1:j*w_f,1:3),L);
		s=sum(sqrt(v.*u));
		if 1-s<=e
			img((i-1)*h_f+1:i*h_f,(j-1)*w_f+1:(j-1)*w_f+3,1)=255;
			img((i-1)*h_f+1:i*h_f,j*w_f-3:j*w_f,1)=255;
			img((i-1)*h_f+1:(i-1)*h_f+3,(j-1)*w_f+1:j*w_f,1)=255;
			img(i*h_f-3:i*h_f,(j-1)*w_f+1:j*w_f,1)=255;
		end
	end	
end
imshow(img)

