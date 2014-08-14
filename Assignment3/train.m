function v=train(L)
I=31;
n=2^(3*L);
v=zeros(1,n);
for i=1:I
	img=imread(['.\Faces\' num2str(i) '.bmp']);
	v=v+cpt_u(img,L);
end
v=v/I;
