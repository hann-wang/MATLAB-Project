c2p8
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
save jpegcodes.mat DC_Code AC_Code h w;



