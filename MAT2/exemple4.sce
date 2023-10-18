function[f]=bdh(t,u)
    f(1)=-0.01*(u(1)-u(2))
	f(2)=0.02*(u(1)-u(2))
endfunction	
//
t0=0; dt=0.1; tmax=250;
u0=[30 ; 300];
t=t0:dt:tmax;
[u]=ode(u0,t0,t,bdh);
clf;
plot2d(t,u(1,:)',2);
plot2d(t,u(2,:)',5);
xset('window',1);
plot2d(u(1,:)',u(2,:)',5);

