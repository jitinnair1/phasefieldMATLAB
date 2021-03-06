D=1.0;
dx=1;
dt=0.01;
N=128;
kappa=1.0;
A=1.0; 
beta1=dt/(dx*dx);
beta2=2*kappa*beta1/(dx*dx);
nstep=5000;
col_labels={'bulk';'gradient';'total'}; 

% Declarations
conc=zeros(N,1);
conc_old=zeros(N,1);
c_prime=zeros(N,1);

% Initial profile
for i=1:N
    if (i>N/4 && i<3*N/4)
        conc_old(i)=1;
    end
end

plot(conc_old, 'r')
hold on

% Define g
g=zeros(N,1);

% Evolve the profile


for k=1:nstep
    
    for i=1:N
        
        % Define g
        g=2*A*conc_old.*(1-conc_old).*(1-2*conc_old);
       
        w=i-1;
        ww=i-2;
        e=i+1;
        ee=i+2;
        
        if (ww<1)
            ww=ww+N;
        end
        if (w<1)
            w=w+N;
        end
        if (ee>N)
            ee=ee-N;
        end
        if(e>N)
            e=e-N;
        end
        
        % ellipsis are for text wrap in MATLAB editor window
        
        conc(i)=conc_old(i) + beta1*(g(w)-2*g(i)+g(e))...
            - beta2*(conc_old(ww)-4*conc_old(w)+6*conc_old(i)...
            -4*conc_old(e) + conc_old(ee));
        
        conc_old(i)=conc(i);
        
    end
    
end
plot(conc_old);



% Calculation of Interfacial energy
energy1=0;
energy2=0;


% Integral of A.c^2.(1-c)^2
for i=1:N
    energy1=energy1 + A*conc_old(i)*conc_old(i)*(1-conc_old(i))*(1-conc_old(i));
end

% Interfacial For FDM
for i=1:N
    w=i-1;
    e=i+1;
    if (w<1)
        w=w+N;
    end
    if (e>N)
        e=e-N;
    end
    c_prime(i)=(conc_old(e)-conc_old(w))/(2*dx);
    energy2 = energy2 + kappa*c_prime(i)*c_prime(i);
end


E1F=0.5*energy1;
E2F=0.5*energy2;
E3F=0.5*(energy1 + energy2);
EnergyFDM=[E1F; E2F; E3F];
table(col_labels, EnergyFDM)


