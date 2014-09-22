function bool = detect(mx, x1, y1, x2, y2)
    % ========================== ����˵�� ==========================
    
    % ��������У�mtxΪͼ���ľ������������ĸ�ʽ��
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % ��ͬ�����ִ�����ͬ��ͼ����0����˴�û�п顣
    % ������[m, n] = size(mtx)��ȡ������������
    % (x1, y1)�루x2, y2��Ϊ���жϵ�������±꣬���ж�mtx(x1, y1)��mtx(x2, y2)
    % �Ƿ������ȥ��
    
    % �������bool = 1��ʾ������ȥ��bool = 0��ʾ������ȥ��
    
    %% �����������Ĵ���O(��_��)O
   	 
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
