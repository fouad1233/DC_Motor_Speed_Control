Ra=11.4;
La=0.1214;
Jm=0.02215;
Bm=0.002953;
Kt=1.28;
Ke=0.0045;


ch_eq=@(s) s.^2+(Ra.*Jm+Bm.*La)./(La.*Jm).*s+(Kt.*Ke+Ra.*Bm)./(La*Jm);

ch_eq_coefs=[1,(Ra.*Jm+Bm.*La)./(La.*Jm), (Kt.*Ke+Ra.*Bm)./(La*Jm) ];

poles=roots(ch_eq_coefs)
T=1./max(poles)
ts_2=4*T
ts_5=3*T

plot(real(poles), imag(poles), "x", LineWidth=2.5, MarkerSize=20)
grid on