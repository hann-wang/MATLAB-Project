function steps = omg(mtx)
    % -------------- 输入参数说明 --------------
    
    %   输入参数中，mtx为图像块的矩阵，类似这样的格式：
    %   [ 1 2 3;
    %     0 2 1;
    %     3 0 0 ]
    %   相同的数字代表相同的图案，0代表此处没有块。
    %   可以用[m, n] = size(mtx)获取行数和列数。
    
    % --------------- 输出参数说明 --------------- %
    
    %   要求最后得出的操作步骤放在steps数组里,格式如下：
    %   steps(1)表示步骤数。
    %   之后每四个数x1 y1 x2 y2，代表把mtx(x1,y1)与mtx(x2,y2)表示的块相连。
    %   示例： steps = [2, 1, 1, 1, 2, 2, 1, 3, 1];
    %   表示一共有两步，第一步把mtx(1,1)和mtx(1,2)表示的块相连，
    %   第二步把mtx(2,1)和mtx(3,1)表示的块相连。
    
    %% --------------  请在下面加入你的代码 O(∩_∩)O~  ------------
    
    [m n] = size(mtx)
    steps(1) = 0;
    while sum(sum(mtx))~=0
		for i=1:m
			for j=1:n
				if mtx(i,j)~=0
					[r c]=find(mtx==mtx(i,j));
					o=length(c);
					for k=1:o
						if (r(k)~=i || c(k)~=j) && detect(mtx,i,j,r(k),c(k))==1
							steps(1)=steps(1)+1;
							steps=[steps i j r(k) c(k)];
							mtx(i,j)=0;
							mtx(r(k),c(k))=0;
							break;
						end
					end
				end
			end
		end
    end
end

