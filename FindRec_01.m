%
% Ideatore e sviluppatore Antonio Lisotti
%
% Elaborazione di calcoli vettoriali a scopo didattico.
% Per permettere una chiara interpretazione gli algoritmi non sono stati 
% volutamente ottimizzati.

v = [0,0,0,1,1,1,0,0,1,1,0,0,1,2,1,3,1,0,1];
N = length(v);
vn= zeros(1, N);

i=1;

while i<=N
    if v(i)==0
        fprintf('v(%d) = %2d\n', i, v(i));
        vn(i)=0;
        i=i+1;        
    else
        j=0;
        k=0;
        while v(i+j)~=0
            fprintf('v(%d) = %2d\n', i+j, v(i+j));
            vn(i+j) = v(i+j) + 1;
            if v(i+j) == 1
                k=k+1;
            end
            j=j+1;    
            if j+i>N 
                break
            end
        end
        fprintf('           ric(1) = %d\n', k);
        i=i+j;
    end
end