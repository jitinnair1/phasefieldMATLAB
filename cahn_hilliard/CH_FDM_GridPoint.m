% Input is system size(N), number of wavelets(m), and dx

function CH_FDM_GridPoint(N, m, dx, dt)
istep=8000;
A=1.0;
kappa=1.0;
beta1=dt/(dx*dx);
beta2=2*kappa*beta1/(dx*dx);

% Declarations
conc=zeros(N,1);
conc_old=zeros(N,1);

% Initial profile
for i=1:N
    conc_old(i)=0.5*(1+sin(2*pi*m*i/N));
end

%plot(conc_old, 'r-')
hold on

% Evolve the profile
for k=1:istep
    
    % Define g
    g=2*A*conc_old.*(1-conc_old).*(1-2*conc_old);
    
    for i=1:N
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
plot(conc);
