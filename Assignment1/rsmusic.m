clear
load Guitar.mat
rs=resample(realwave,10,1);
m=floor(size(rs,1)/10);
avr=zeros(m,1);
for i=0:9
	avr=avr+rs(i*m+1:(i+1)*m,1);
end
avr=avr/10;
extent=[];
for i=1:10
	extent=[extent;avr];
end
rs=resample(extent,1,10);
plot(rs,'b');
hold on
plot(rs-wave2proc,'r');
max(wave2proc-rs)
