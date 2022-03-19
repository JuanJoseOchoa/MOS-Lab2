*************************************************************************
***              Laboratorio 2 - Ejercicio 3                          ***
***                                                                   ***
***      Autores: Juan José Ochoa - 201913552                         ***
***               David Alvarez - 201911318                           ***
*************************************************************************


Sets
  i      Antenas de WiFi /N1*N12/

alias (j,i);

Table c(i,j) grilla de conectividad
     N1   N2   N3   N4   N5   N6   N7   N8   N9   N10   N11   N12
N1    1    1    1   0    1    0    0    0    0    0     0     0
N2    1    1    0   0    1    0    0    0    0    0     0     0
N3    1    0    1   1    1    1    1    1    0    0     0     0
N4    0    0    1   1    1    1    0    0    0    0     1     0
N5    1    1    1   1    1    0    0    0    0    1     1     0
N6    0    0    1   1    0    1    0    1    0    0     1     0
N7    0    0    1   0    0    0    1    1    0    0     0     1
N8    0    0    1   0    0    1    1    1    1    0     1     1
N9    0    0    0   0    0    0    0    1    1    1     1     1
N10   0    0    0   0    1    0    0    0    1    1     1     0
N11   0    0    0   1    1    1    0    1    1    1     1     0
N12   0    0    0   0    0    0    1    1    1    0     0     1


Variables
x(i)                       Zona Elegida
z                          Objective Function
;

Binary Variable x;

Equations
objectiveFunction                          Objective Function
covertura(i)                                     Zona con Covertura;

objectiveFunction                  ..      z =e= sum((i), x(i));

covertura(i)                       ..      sum((j), x(j)*c(i,j) ) =g= 1;

Model Lab2Ej3 /all/ ;

option mip=SCIP;
Solve Lab2Ej3 using mip minimizing z;

Display c;
Display x.l;
Display z.l;
