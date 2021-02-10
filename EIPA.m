% Jay Maini 101037537
%EIPA
set(0, 'DefaultFigureWindowStyle','docked')
clear all
close all


%unequal array size
nx = 25;
ny = 50;
V = zeros(nx,ny);
G = sparse(nx*ny, nx*ny);

Inclusion = 0;

for i = 1:nx
    for j = 1:ny
        m = j+(i-1)*ny;
        
        %Edge cases (BC's nodes)
        if (i == 1) || (i == nx) || (j == 1) || (j == ny)
            G(m,m) = 1;
        else
            %Inner region (set by FD equation)
            %set back to -4 for default
            G(m,m) = -2;
            
            %Define next/previous on the x and y axes
            npx = j+1 + (i-1)*ny;
            nmx = j-1 + (i-1)*ny;
            npy = j + (i-1+1)*ny;
            nmy = j + (i-1-1)*ny;
            
            G(m,npx) = 1; 
            G(m,nmx) = 1;
            G(m,npy) = 1;
            G(m,nmy) = 1;
        end
    end
end

figure('name', 'Matrix')
spy(G)

nmodes = 9;
[E,D] = eigs(G,nmodes,'SM');
%where E is matrix of vectors
%D is diagonal to eigenvalues

for k = 1:nmodes
    E_temp = reshape(E(:,k),nx,ny);
    figure(k+1)
    surf(E_temp)
end

