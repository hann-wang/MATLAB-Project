clear
wav=wavread('fmt.wav');
length=size(wav,1)
len=400;
outstand=1.6;
plot(wav);
hold on
i=5;
oldm=0;
maxarray=[];
numarray=[];
while true
	if(len*(1+i)<length)
		[m,t]=max(wav(len*i+1:len*(i+1)));
		if m>outstand*oldm && m>0.12
			maxarray=[maxarray m];
			numarray=[numarray t+len*i];
		end
		oldm=m;
		%manual set two point
		if t+len*i==79112  
			maxarray=[maxarray 0];
			numarray=[numarray 81112];
		end
		if t+len*i==82985 
			maxarray=[maxarray 0];
			numarray=[numarray 84612];
		end

	else
		[m,t]=max(wav(len*i+1:length));
		if m>outstand*oldm	   && m>0.12
			maxarray=[maxarray m];
			numarray=[numarray t+len*i];
		end
		oldm=m;
		break;
	end
	i=i+1;	
end
plot(numarray,maxarray,'rx')
save('beat.dat','numarray','-ascii')
