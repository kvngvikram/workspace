clear;
clc;

x = [ 4 2 6 3 8 1 5 ] % x1 
h = [ 3 8 6 9 6 7  ]   % x2 
ax = -1      % starting point of x1 
ah = -2      % starting point of x2 

% padding zeros for adjusting origen of two signals at same index
if ax>ah
    x = [zeros(1,ax-ah) x];
elseif ax<ah 
    h = [zeros(1,ah-ax) h];
end

% defining the final cross correlation solution
Y = zeros(1,numel(x)+numel(h)-1);

% x axis variable of final solution
s = -numel(h)+1:numel(x)-1;

% padding zeros to x 
xa = [x , zeros(1,(numel(Y)-numel(x)))];
 

for i = 1:numel(Y) % caluclating for each element of Y
    
    Y(i) = 0; % initially assigned zero
   
    for j = 1:i    
        
        if (j-s(i))>0  % not considering non overlapping elements of shifted h  
            % h is shifted and multiplied to x element wise by the
            % corresponding shift and added to Y(i)
            Y(i) = Y(i)+xa(j)*h(j-s(i)); 
        end
        
    end
   
end

% plotting the calculated values
subplot(1,2,1)
stem(s,Y)
xlabel('n')
ylabel('Amplitude')
title('Calculated cross correlation')

% by inbuilt function 'xcorr(x,h)' 

% xcorr() has different dimensions and shift as of Y 
% so corresponding shift 'r' is used adjust x axis vector 's'
if numel(x)==numel(h)
    r = 0;
else
    r = numel(x)-numel(h)
end

 v = [s(1)-r:s(1)+numel(xcorr(x,h))-r-1];
 u = xcorr(x,h);

subplot(1,2,2)
stem(v,u)
xlabel('n')
ylabel('Amplitude')
title('correlation by built in function')