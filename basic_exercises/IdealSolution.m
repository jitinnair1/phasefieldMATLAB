x=0.01:0.01:0.99;
G=x.*log(x)+(1.-x).*log(1.-x);
DG300=G*8.314*300;
DG600=G*8.314*600;
plot(x,DG300,x,DG600)
