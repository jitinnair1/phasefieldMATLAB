% This program plots an animated version of the diffusion profile for specified bpundary
% conditions. Use a combination of `hold on` and `plot` within the loop to see stepwise
% evolution of the profile. 

clear all;

%Parameters
N=100;
dx=0.5;
dt=0.1;
D=2;

% Setup the system
x=1:N;
alpha=D*dt/((dx)^2);

%Declarations
conc=ones(1, N);

%Boundary Conditions
conc(1)=1;
conc(N)=0;

%Plot initial profile
plot(x, conc, 'b'), xlabel('Distance'), ylabel('Composition');
title('1D Diffusion Profile');
%hold on

%Evolve
for k=1:100
    for j=1:5
        for i=2:N-1
            conc(i)=conc(i)*(1-2*alpha) + alpha*(conc(i-1)+conc(i+1));
        end
    end
    plot (x, conc);
    %hold on
    drawnow % creates an animation by refreshing plot data
end