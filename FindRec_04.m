%
% Ideatore e sviluppatore Antonio Lisotti
%
% Elaborazione di calcoli vettoriali a scopo didattico.
% Per permettere una chiara interpretazione gli algoritmi non sono stati 
% volutamente ottimizzati.

% N=16;
% V = rand(1,N)>=.5;
% v=V;
% v = [0   0   0   1   1   0   1   0   0   0   1   1   0   0   0   1];
v = [1,1,0,0,0,1,0,0,0,1,1,1,0,0,1,1,0,0,1,2,1,3,1,0,1,2];
% v = [1,1,0,0,0,1,0,0,0,1,1,1,0,2,3,4,1,0,1,1,0,1,2,0,1,2,1,3,1,0,1,2,1,1,0,1,7];

N = length(v);
% vn= zeros(1, N);

dRmin=3;

i=1;
K=0;
while i<=N
    if v(i)==0
        fprintf('v(%d) = %2d\n', i, v(i));       
        i=i+1;        
    else
        j=0;
        k=0;
        while v(i+j)~=0 && i+j<=N
            fprintf('v(%d) = %2d\n', i+j, v(i+j));
            if v(i+j) == 1
                k=k+1;                
            end
            v(i+j) = v(i+j) + 1;            
            j=j+1;  
            if j+i>N 
                break
            end
        end
        if k >= 1 && j >= dRmin
            K=K+k;
            fprintf('           ric(1) = %d\n', k)
        elseif j>0
            fprintf('     j: %d\n', j)
                ij=i+j;
                while ij > i
                    ij=ij-1;
                    v(ij) = v(ij)-1;  
                    fprintf('     ij: %d\n', ij)
                end
        end
        i=i+j;
    end
   
end
fprintf([' All''interno di un insieme di numeri naturali di %d elementi, la somma delle \n' ...
             'ricorrenze totali dell''elemento 1 in sottoinsiemi, composti da almeno %d elementi, \n' ...
             'i cui elementi siano tutti diversi da zero è: %d.\n'], N, dRmin, K);

disp(v);
