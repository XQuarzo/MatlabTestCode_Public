%
% Ideatore e sviluppatore Antonio Lisotti
%
% Elaborazione di calcoli matriciali a scopo didattico.
% Per permettere una chiara interpretazione gli algoritmi non sono stati 
% volutamente ottimizzati.


% Generazione di una matrice NxN ordinata con ogni elemento unico (ogni 
% elemento è diverso da tutti gli altri elementi). Ho scelto questa 
% configurazione per aggevolare la verifica dei risultati durante la fase 
% di controllo. 
N = 9;
A = (reshape(1:1:N*N,[N,N])).';


% % Verifica correttezza indici
% for y = 1:N
%     for x = 1:N
% %         disp(A(y, x))
%         fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
%     end
% end
%
% Nota: In Matlab gli indici dele matrici 2D sono (righe, colonne) (x,y)!
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Test Scorrimento Perimetrale
% %
% % Scorrimento perimetrale per A(1,1) -> A(N,1) con diagonali perpendicolari
% % alla diagonale (A(1,1),A(N,N))
% for j = 1:N
%     x=1;
%     y=j;
%     fprintf('Scansione diagonale numero: %d\n', j);
%     while (y>0)
%         fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
%         x=x+1;
%         y=y-1;
%     end    
% end
% % Scorrimento perimetrale per A(N,1) -> A(N,N) con diagonali perpendicolari
% % alla diagonale (A(1,1),A(N,N))
% for i = 1:N
%     x=i;
%     y=N;
%     fprintf('Scansione diagonale numero: %d\n', N+i);
%     while (x<=N)
%         fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
%         x=x+1;
%         y=y-1;
%     end    
% end
% % Scorrimento perimetrale per A(N,1) -> A(N,N) con diagonali perpendicolari
% % alla diagonale (A(1,N),A(N,1))
% for i = 1:N
%     x=i;
%     y=N;
%     fprintf('Scansione diagonale numero: %d\n', 2*N+i);
%     while (x>=1)
%         fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
%         x=x-1;
%         y=y-1;
%     end    
% end
% % Scorrimento perimetrale per A(N,N) -> A(1,N) con diagonali perpendicolari
% % alla diagonale (A(1,N),A(N,1))
% for j = N:-1:1
%     x=N;
%     y=j;
%     fprintf('Scansione diagonale numero: %d\n', 4*N-j+1);
%     while (y>0)
%         fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
%         x=x-1;
%         y=y-1;
%     end    
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Estrazione vettori delle diagonali:
%
%
% Tutte le diagonali di una matrice quadrata sono 2*(N+(N-1))=4*N-2
%
% diags={};
diags=cell(1,4*N-2);
% Scorrimento perimetrale per A(1,1) -> A(N,1) con diagonali perpendicolari
% alla diagonale (A(1,1),A(N,N))
d=1;
for j = 1:N
    x=1;
    y=j;
    diag=zeros(1,j);
    fprintf('Scansione diagonale numero: %d\n', d);
    while (y>0)
        fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
        diag(x)=A(y, x);
        x=x+1;
        y=y-1;
    end    
    diags(d) = {diag};
    d=d+1;
end
% Scorrimento perimetrale per A(N,2) -> A(N,N) con diagonali perpendicolari
% alla diagonale (A(1,1),A(N,N))
for i = 2:N
    x=i;
    y=N;
    diag=zeros(1,N-i+1);
    fprintf('Scansione diagonale numero: %d\n', d);
    k=0;
    while (x<=N)
        fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
        k=k+1;
        diag(k)=A(y, x);
        x=x+1;
        y=y-1;
    end    
    diags(d) = {diag};
    d=d+1;
end
% % Scorrimento perimetrale per A(N,1) -> A(N,N) con diagonali perpendicolari
% % alla diagonale (A(1,N),A(N,1))
for i = 1:N
    x=i;
    y=N;
    diag=zeros(1,i);
    fprintf('Scansione diagonale numero: %d\n', d);
    k=0;
    while (x>=1)
        fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
        k=k+1;
        diag(k)=A(y, x);
        x=x-1;
        y=y-1;
    end    
    diags(d) = {diag};
    d=d+1;
end

% % Scorrimento perimetrale per A(N-1,N) -> A(1,N) con diagonali perpendicolari
% % alla diagonale (A(1,N),A(N,1))
for j = N-1:-1:1
    x=N;
    y=j;
    diag=zeros(1,j);
    fprintf('Scansione diagonale numero: %d\n', d);
    k=0;
    while (y>0)
        fprintf('A(%d, %d) = %2d\n', x, y, A(y, x));
        k=k+1;
        diag(k)=A(y, x);
        x=x-1;
        y=y-1;
    end
    diags(d) = {diag};
    d=d+1;
end

