clear all;
Nx=128;
Ny=128;
dx=1.0;
dy=1.0;
L=1.0;
dt=0.1;
A=1.0;
kappa=1.0;

more off

%Declarartions
phi=zeros(Nx, Ny);

%Initial Profile
for i=1:Nx
    for j=1:Ny
        phi(i,j) = 0.5 - 0.1*(0.5-rand());
    end
end

write_vtk_grid(Nx,Ny,1,1,0,phi);

%Periodic Boundary
halfNx=Nx/2;
halfNy=Ny/2;
delkx=2*pi/Nx;
delky=2*pi/Ny;

for iprint=1:10
    for istep=1:25
        
        %Define g
        g=A*phi.*(1-phi).*(1-2*phi);
        
        %FFT
        phi_hat=fft2(phi);
        g_hat=fft2(g);
        
        for i=1:Nx
            for j=1:Ny
                  
                %Periodic Boundary
                if (i-1)<halfNx
                    kx=(i-1)*delkx;
                end
                
                if (i-1)>=halfNx
                    kx=(i-1-Nx)*delkx;
                end
                
                if (j-1)<halfNy
                    ky=(j-1)*delky;
                end
                
                if (j-1)>=halfNy
                    ky=(j-1-Ny)*delky;
                end
                
                k2=kx*kx+ky*ky;
                
                phi_hat(i,j)=(phi_hat(i,j)-L*dt*g_hat(i,j))/(1+2*kappa*L*dt*k2);      
                
            end
        end
        phi=real(ifft2(phi_hat));
        
    end
    
    write_vtk_grid(Nx,Ny,1,1,iprint*istep,phi);
end