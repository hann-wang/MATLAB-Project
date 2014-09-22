function bool = detect(mx, x1, y1, x2, y2)
    % ========================== 参数说明 ==========================
    
    % 输入参数中，mtx为图像块的矩阵，类似这样的格式：
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % 相同的数字代表相同的图案，0代表此处没有块。
    % 可以用[m, n] = size(mtx)获取行数和列数。
    % (x1, y1)与（x2, y2）为需判断的两块的下标，即判断mtx(x1, y1)与mtx(x2, y2)
    % 是否可以消去。
    
    % 输出参数bool = 1表示可以消去，bool = 0表示不能消去。
    
    %% 在下面添加你的代码O(∩_∩)O
   	 
    [m, n] = size(mx);
	mtx=[zeros(1,n+2);
		zeros(m,1) mx zeros(m,1);
		zeros(1,n+2)]
    [m, n] = size(mtx);
	x1=x1+1;
	x2=x2+1;
	y1=y1+1;
	y2=y2+1;
    bool = 0;
	if mtx(x1,y1)==mtx(x2,y2)
		%sprintf('checking%d %d %d %d',x1,y1,x2,y2)
		if x1==x2 && sum(mtx(x1,min(y1,y2):max(y1,y2)))==(mtx(x1,y1)+mtx(x2,y2))
			bool=1;
			return;
		end
		if y1==y2 && sum(mtx(min(x1,x2):max(x1,x2),y1))==(mtx(x1,y1)+mtx(x2,y2))
			bool=1;
			return;
		end
		for i=1:m
			path=sum(mtx(min(i,x1):max(i,x1),y1))+sum(mtx(i,min(y1,y2):max(y1,y2)))+sum(mtx(min(i,x2):max(i,x2),y2));
			if path==(mtx(x1,y1)+mtx(x2,y2)) || (path==(mtx(x1,y1)*3) && (i==x1||i==x2))
				bool=1;
				return;
			end		
		end
		for j=1:n
			path=sum(mtx(min(x1,x2):max(x1,x2),j))+sum(mtx(x1,min(j,y1):max(j,y1)))+sum(mtx(x2,min(j,y2):max(j,y2)));
			if path==(mtx(x1,y1)+mtx(x2,y2)) || (path==(mtx(x1,y1)*3) &&(j==y1||j==y2))
				bool=1;
				return;
			end
		end
	else
		bool=0;
	end
end
