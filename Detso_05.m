%
% Ideatore e sviluppatore Antonio Lisotti
%
% Elaborazione di calcoli matriciali a scopo didattico.
% Per permettere una chiara interpretazione gli algoritmi non sono stati 
% volutamente ottimizzati.
%
%  Note:
% 1) In Matlab gli indici dele matrici 2D sono (righe, colonne) (x,y)!
% 2) Nella versione precedente Detso_01 è presente la verifica della
% correttezza degli indici e la verifica della corretta estrazione dei 
% vettori di tutte le diagonali della matrice N*N.
%
%
%
% % generazione di un vettore con valori casuali da utilizzarsi per produrre 
% % la matrice della correlazione.
% N=7;
% v = rand(1,N);

% v = [0.3 0.9 2.0 0.9 2.4];
v = [0.3 0.9 2.0 0.9 2.4 4.6 2.1 5.5 3.8];
N = length(v);

dRmin = 2;

MatDist = zeros(N, N);

sum = 0;
for x = 1:N
    for y = 1:N
        MatDist(y, x) = abs(v(x)-v(y));
        sum = sum + MatDist(y, x);
    end
end
distMed = sum/(N*N);
radius = distMed * 0.5;

% Operazione esplicita sui singoli elementi della matrice
% MatRic = zeros(N, N);
% for x = 1:N
%     for y = 1:N
%         if MatDist(y, x) <= radius
%             MatRic(y, x) = 1;
%         else
%             MatRic(y, x) = 0;
%         end
%     end
% end
% Operazione Matlab vettoriale equivalente alla precedente
MatRic = MatDist <= radius;

sumRic = 0;
for x = 1:N
    for y = 1:N        
        sumRic = sumRic + MatRic(y, x);
    end
end
RR = sumRic/(N*N);

figure(1);
imagesc(MatRic);
colormap(gray(2));
colorbar('Ticks', linspace(0, 1, 3), 'TickLabels',["0" "0.5" "1"]);
axis square;
set(gca,'YDir','normal');

% Per il calcolo del determinismo è necessario implementare un sistema per
% evitare il doppio conteggio di un elemento (il metodo verrà spiegato
% nelle versioni successive).
A = int8(MatRic);

% Matrice di Test
% dRmin = 2;
% N=5;
% A= [ [1   0   0   0   0]
%      [0   1   0   1   0]
%      [0   0   1   0   0]
%      [0   1   0   1   0]
%      [0   0   0   0   1]];

%
% Per il calcolo del determinismo si può escludere di controllare la diagonale
% principale (A(1,1) -> A(N,1)) e quelle con numero di elementi inferiore al 
% valore di diagonale-minima (dRmin) imposto.

% Tutte le diagonali di una matrice quadrata sono: 2*(N+(N-1))=4*N-2.
% le diagonali necessarie per il calcolo del determinismo sono: 
% ((N-dRmin+1)+(N-1-dRmin+1))*2-1=4*N-4*dRmin + 1
ndiags=4*N-4*dRmin + 1;
diags=cell(1,ndiags);

%
% Scorrimento perimetrale per A(1,1) -> A(N,1) con diagonali perpendicolari
% alla diagonale (A(1,1),A(N,N)) con escusione delle diagonali di lunghezza
% inferiore a dRmin.
d=1;
K=0;
for j = dRmin:N
    x=1;
    y=j;
    diag=zeros(1,j);
    fprintf('Scansione diagonale numero: %d\n', d);
    while (y>0)
        if A(y, x)==0
            fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
            diag(x)=A(y, x);
            x=x+1;
            y=y-1;        
        else
           i=0;
           k=0;
           while A(y-i, x+i) ~=0 && y-i>0 && x+i<=N
               fprintf('A(%d, %d) = %2d\n', x+i, y-i, A(y-i, x+i)); 
               if A(y-i, x+i) == 1
                   k=k+1;
               end
               A(y-i, x+i) = A(y-i, x+i) + 1;
               i=i+1;
               if y-i<=0 || x+i>N
                   break
               end
           end
           if k >= 1 && i >= dRmin
               K=K+k;
               fprintf('           ric(1) = %d\n', k);
           elseif i>0
               fprintf('     i: %d\n', i); 

               ii=0;               
               while ii<i
                   A(y-ii, x+ii) = A(y-ii, x+ii) - 1;                   
                   fprintf('     ix: %d  iy: %d\n', x+ii, y-ii);
                   ii=ii+1;
               end
           end
           x = x+i;         
           y = y-i;           
        end       
    end    
    diags(d) = {diag};
    d=d+1;
end
% Scorrimento perimetrale per A(N,2) -> A(N,N) con diagonali perpendicolari
% alla diagonale (A(1,1),A(N,N)) con escusione delle diagonali di lunghezza
% inferiore a dRmin.
for j = 2:N-dRmin+1
    x=j;
    y=N;
    diag=zeros(1,N-j+1);
    fprintf('Scansione diagonale numero: %d\n', d);
    idg=0;
    while (x<=N)
        if A(y, x)==0
            fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
            idg=idg+1;
            diag(idg)=A(y, x);
            x=x+1;
            y=y-1;        
        else
            i=0;
            k=0;
            while A(y-i, x+i) ~=0 && y-i>0 && x+i<=N
               fprintf('A(%d, %d) = %2d\n', x+i, y-i, A(y-i, x+i)); 
               if A(y-i, x+i) == 1
                   k=k+1;
               end
               A(y-i, x+i) = A(y-i, x+i) + 1;
               i=i+1;
               if y-i<=0 || x+i>N
                   break
               end
           end
           if k >= 1 && i >= dRmin
               K=K+k;
               fprintf('           ric(1) = %d\n', k);
           elseif i>0
               fprintf('     i: %d\n', i);
               ii=0;
               while ii<i
                   A(y-ii, x+ii) = A(y-ii, x+ii) - 1;
                   fprintf('     ix: %d  iy: %d\n', x+ii, y-ii);
                   ii=ii+1;
               end
           end
           x = x+i;
           y = y-i;           
        end
    end    
    diags(d) = {diag};
    d=d+1;
end
% % Scorrimento perimetrale per A(N,1) -> A(N,N) con diagonali perpendicolari
% % alla diagonale (A(1,N),A(N,1)) con escusione delle diagonali di lunghezza
% inferiore a dRmin, in questo ciclo può essere ignorata la diagonale
% principale.

fprintf('\n\nFine scansione prima fase.\n\n');
for j = dRmin:N-1
    x=j;
    y=N;
    diag=zeros(1,j);
    fprintf('Scansione diagonale numero: %d\n', d);
    idg=0;
    while (x>=1)
        if A(y, x)==0
            fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
            idg=idg+1;
            diag(idg)=A(y, x);
            x=x-1;
            y=y-1;
        else
            i=0;
            k=0;
            while A(y-i, x-i) ~=0 && y-i>0 && x-i>0
               fprintf('A(%d, %d) = %2d\n', x-i, y-i, A(y-i, x-i)); 
               if A(y-i, x-i) == 1
                   k=k+1;
               end
               A(y-i, x-i) = A(y-i, x-i) + 1;
               i=i+1;
               if y-i<=0 || x-i<=0
                   break
               end
           end
           if k >= 1 && i >= dRmin
               K=K+k;
               fprintf('           ric(1) = %d\n', k);
           elseif i>0
               fprintf('     i: %d\n', i);
               ii=0;
               while ii<i
                   A(y-ii, x-ii) = A(y-ii, x-ii) - 1;
                   fprintf('     ix: %d  iy: %d\n', x-ii, y-ii);
                   ii=ii+1;
               end
           end
           x = x-i;
           y = y-i;
        end
    end    
    diags(d) = {diag};
    d=d+1;
end
% % Scorrimento perimetrale per A(N-1,N) -> A(1,N) con diagonali perpendicolari
% % alla diagonale (A(1,N),A(N,1)) con escusione delle diagonali di lunghezza
% inferiore a dRmin.
for j = N-1:-1:dRmin
    x=N;
    y=j;
    diag=zeros(1,j);
    fprintf('Scansione diagonale numero: %d\n', d);
    idg=0;
    while (y>0)
        if A(y, x)==0
            fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
            idg=idg+1;
            diag(idg)=A(y, x);
            x=x-1;
            y=y-1;
        else
            i=0;
            k=0;
            while A(y-i, x-i) ~=0 && y-i>0 && x-i>0
               fprintf('A(%d, %d) = %2d\n', x-i, y-i, A(y-i, x-i)); 
               if A(y-i, x-i) == 1
                   k=k+1;
               end
               A(y-i, x-i) = A(y-i, x-i) + 1;
               i=i+1;
               if y-i<=0 || x-i<=0
                   break
               end
           end           
           if k >= 1 && i >= dRmin
               K=K+k;
               fprintf('           ric(1) = %d\n', k);
           elseif i>0
               fprintf('     i: %d\n', i);
               ii=0;
               while ii<i
                   A(y-ii, x-ii) = A(y-ii, x-ii) - 1;
                   fprintf('     ix: %d  iy: %d\n', x-ii, y-ii);
                   ii=ii+1;
               end
           end
           x = x-i;
           y = y-i;
        end
    end
    diags(d) = {diag};
    d=d+1;
end

Detso = K/sumRic;
fprintf(' Il recurrence rate della matrice delle ricorrenze è: %4.4f\n', RR);
fprintf(' Il determinismo della matrice delle ricorrenze è: %4.4f\n', Detso);


