function u=cpt_u(m,L)
num=2^(3*L);
[h w s]=size(m);
u=zeros(1,num);
r=2^(8-L);
d=2^L;
for i=1:h
	for j=1:w
		n=0;
		for k=1:3
			n=double(n*d+floor(double(m(i,j,k))/r));
		end
		n=floor(n)+1;
		u(n)=u(n)+1;

	end
end
u=u/(h*w);

