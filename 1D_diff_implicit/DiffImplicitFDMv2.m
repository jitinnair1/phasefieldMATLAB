clear all;
%Parameters
N=100;
dx=0.5;
dt=0.1;
D=1;
alpha=D*dt/((dx)^2);

%Declarations
conc=zeros(N, 1);
conc_old=zeros(N, 1);
A=zeros(N, N);

%Boundary Conditions: Left end - Diricilet
conc(1)=1;
A(1,1)=1;
A(N, N-1)=-2*alpha;

for j=1:N
    conc_old(j, 1)=conc(j, 1);
end

%Plot initial profile
plot(conc, 'b'), xlabel('Distance'), ylabel('Composition');
title('1D Diffusion Profile');
hold on

%Putting together the matrix

%Diagonal
for j=2:N
    A(j,j)=1+2*alpha;
end

%Lower Diagonal
for j=2:N-1
    A(j,j-1)= -alpha;
end

%Upper Diagonal
for j=3:N
    A(j-1,j)= -alpha;
end

%Evolving the profile

%Loop for plotting
for k=1:20
    
    %Loop for time steps
    for i=1:500
        conc=A \ conc_old;
        
        %Loop for reassigning new c matrix as old
        for j=1:N
            conc_old(j)=conc(j);
        end
    end
    plot (conc)
end

