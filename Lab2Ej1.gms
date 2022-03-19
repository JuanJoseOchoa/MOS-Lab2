*************************************************************************
***              Laboratorio 2 - Ejercicio 1                          ***
***                                                                   ***
***      Autores: Juan José Ochoa - 201913552                         ***
***               David Alvarez - 201911318                           ***
*************************************************************************

Sets
         i Procesadores Origen /1PO*3PO/
         j Procesadores Destino /1PD*2PD/

Table  c(i,j)   costo
         1PD    2PD
1PO       300   500
2PO       200   300
3PO       600   300

Parameter
KO(i) Modo Kernel Origen Cantidad / 1PO 60, 2PO 80, 3PO 50 /
UO(i) Modo Usuario Origen Cantidad / 1PO 80, 2PO 50, 3PO 50 /
KD(j) Modo Kernel Destino Cantidad /1PD 100, 2PD 90 /
UD(j) Modo Usuario Destino Cantidad /1PD 60, 2PD 120 /;


Variables
  U(i,j)      Modo Usuario i-j
  K(i,j)      Modo Kernel i-j
  z           Objective function;

Positive Variable U;
Positive Variable K;

Equations
funcionObj               Funcion Objetivo

usuarioOrigenRes          Usuario Origen
kernelOrigenRes           Kernel Origen
usuarioDestinoRes         Usuario Destino
kernelDestinoRes          Kernel Destino;


funcionObj                       ..  z =e= sum((i,j), c(i,j) * (K(i,j) + K(i,j)));

usuarioOrigenRes(i)              ..  sum(j, U(i,j)) =e= UO(i);
kernelOrigenRes(i)               ..  sum(j, K(i,j)) =e= KO(i);
usuarioDestinoRes(j)             ..  sum(i, U(i,j)) =e= UD(j);
kernelDestinoRes(j)              ..  sum(i, K(i,j)) =e= KD(j);


Model Lab2Ej1 /all/ ;
option mip=CPLEX
Solve Lab2Ej1 using mip minimazing z;

Display c;
Display z.l;
Display U.l;
Display K.l;
