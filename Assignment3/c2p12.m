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
		r(:,(i-1)*num_w+j)=zigzag(round((dct2(temp((i-1)*8+1:i*8,(j-1)*8+1:j*8))./QTAB*2)));
	end
end

[h2 w2]=size(r);
DC=zeros(1,w2);
DC(1)=r(1,1);
for i=2:w2
	DC(i)=r(1,i-1)-r(1,i);
end
DC_Code=[];
for i=1:w2
	if DC(i)==0
		cat=0;
	else
		cat=floor(log2(abs(DC(i))))+1;
	end
	huf=DCTAB(cat+1,2:DCTAB(cat+1,1)+1);
	DC_Code=[DC_Code huf d2b(DC(i))];
end


AC=r(2:h2,:);
AC_Code=[];
for i=1:w2
	run=0;
	t=AC(:,i);
	last_0=find(t~=0,1,'last');
	for j=1:last_0
		if t(j)==0
			if run==15
				AC_Code=[AC_Code 1 1 1 1 1 1 1 1 0 0 1];
				run=0;
			else
				run=run+1;
			end
		else
			l=floor(log2(abs(t(j))))+1;
			AC_Code=[AC_Code ACTAB(run*10+l,4:ACTAB(run*10+l,3)+3) d2b(t(j))];
			run=0;
		end
	end
	AC_Code=[AC_Code 1 0 1 0];
end
DC_Code=logical(DC_Code);
AC_Code=logical(AC_Code);

dc_l=size(DC_Code,2);
DC=[];
i=1;
while(i<dc_l)
	cat=0;
	if(DC_Code(i)==1) &&(DC_Code(i+1)==1)
		len_c=0;
		while(DC_Code(i)==1)
			len_c=len_c+1;
			i=i+1;
		end
		cat=len_c+3;
		i=i+1;
	elseif DC_Code(i)==1 
		if DC_Code(i+2)==0
			cat=3;
		else
			cat=4;
		end
		i=i+3;
	elseif DC_Code(i+1)==1 
		if DC_Code(i+2)==0 
			cat=1;
		else
			cat=2;
		end
		i=i+3;
	else
		cat=0;
		i=i+2;
	end
	
	len_b=max(1,cat);
	bin='';
	for j=i:i+len_b-1
		if DC_Code(j)==1
			bin=strcat(bin,'1');
		else
			bin=strcat(bin,'0');
		end
	end
	dec=bin2dec(bin);
	if dec<2^(cat-1)
		dec=dec-2^cat+1;
	end
	i=i+len_b;
	DC=[DC dec];
end
for i=2:length(DC)
	DC(i)=DC(i-1)-DC(i);
end

ac_l=size(AC_Code,2);
AC=[];
num=1;
i=1;
t=[];
AC_r=zeros(63,1);
while(i<=ac_l)
	t=[t AC_Code(i)];
	if length(t)==4 & t==[1 0 1 0]
		AC=[AC AC_r];
		AC_r=zeros(63,1);
		t=[];
		num=1;
	elseif (length(t)==11) & (t==[1 1 1 1 1 1 1 1 0 0 1])
		t=[];
		num+num+16;
	else
		for j=1:160
			n=ACTAB(j,3);
			l=ACTAB(j,4:n+3);
			if(length(t)==n) & (t==l)
				run=floor((j-1)/10);
				len_b=j-run*10;
				bin='';
				for k=i+1:i+len_b
					if AC_Code(k)==1
						bin=strcat(bin,'1');
					else
						bin=strcat(bin,'0');
					end
				end
				dec=bin2dec(bin);
				if dec<2^(len_b-1)
					dec=dec-2^len_b+1;
				end
				num=num+run;
				AC_r(num)=double(dec);
				num=num+1;
				i=i+len_b;
				t=[];
				break;
			end
		end
	end
	i=i+1;
end
jpg=zeros(h,w);
jpg=uint8(jpg);
r=[DC;AC];
for i=1:ceil(h/8)
	for j=1:ceil(w/8)
		temp=r(:,(i-1)*ceil(w/8)+j);
		m=inzigzag(temp);
		jpg((i-1)*8+1:i*8,(j-1)*8+1:j*8)=idct2(m.*QTAB/2)+128;
	end
end
jpg=uint8(jpg);
subplot(1,2,1)
imshow(jpg)
load hall.mat
subplot(1,2,2)
imshow(hall_gray)
s=sum(sum((jpg-hall_gray).^2));
s=double(s)
psnr=10*log10(255^2*h*w/s)

				


			
	

		
		 
