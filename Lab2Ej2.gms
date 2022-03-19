*************************************************************************
***              Laboratorio 2 - Ejercicio 2                          ***
***                                                                   ***
***      Autores: Juan José Ochoa - 201913552                         ***
***               David Alvarez - 201911318                           ***
*************************************************************************

Sets
         i              Nodos /N1*N7/
         int(i)         Nodos intermedios /N2, N3, N4, N5/
         f              Tipos de flujos /F1, F2/
         s(i)           Nodos fuente /N1, N2/
         e(i)           Nodos destino /N6, N7/;

         alias(j, i);


Parameter fuentes(s) conjunto de valores;

          fuentes(s) = s.uel;


*destinatarios guarda ubicaciones de los nodos destino del resto
Parameter destinatarios(e) conjunto de valores;

          destinatarios(e) = e.uel;


Parameter
                 cc(i, j) Capacidad de la coneccion;

                 cc(i, j)=0;


Parameter
                 ct(i, j) Costo de coneccion;

                 ct(i, j) = 800;

*Grafo dirigido (costs)

         ct('N1', 'N3') = 1;
         ct('N1', 'N4') = 1;
         ct('N2', 'N3') = 1;
         ct('N2', 'N4') = 1;
         ct('N3', 'N4') = 1;
         ct('N3', 'N5') = 1;
         ct('N3', 'N6') = 1;
         ct('N4', 'N5') = 1;
         ct('N4', 'N7') = 1;
         ct('N5', 'N6') = 1;
         ct('N5', 'N7') = 1;

*Grafo no dirigido (costs)

         loop((i, j),

             if (ct(i, j) < 800,

                 ct(j, i) = ct(i,j);

                 cc(i, j) = 512;

                 cc(j, i) = 512;
             );
         );


Parameter  BWD(f)   Bandwith demand
           /F1   256
            F2   256  /;

Variables
         x(i, j, f, s, e)                 Muestra si el arco entre i y j está seleccionado
         z                                Funcion Objetivo;


Binary Variable
         x;

Equations
         objectiveFunction               Funcion Objetivo


         nodoFuente(i, f, s, e)                          Nodo fuente
         nodosDestino(j, f, s, e)                        Nodos destino
         nodoIntermedio(int, f, s, e)                    Nodo intermedio
         capacidad(i, j)                                 Capacidad
         conexionesNoRepetidas(i, j, f, s, e)            Conexiones no repetidas;


         objectiveFunction                                               .. z =e= sum((i, j, f, s, e), ct(i, j) * x(i, j, f, s, e));
         nodoFuente(i, f, s, e)$(ord(i) = fuentes(s))                    .. sum((j), x(i, j, f, s, e)) =e= 1;
         nodosDestino(j, f, s, e)$(ord(j) = destinatarios(e))            .. sum((i), x(i, j, f, s, e)) =e= 1;
         nodoIntermedio(int, f, s, e)                                    .. sum((j), x(int, j, f, s, e)) - sum((j), x(j, int, f, s, e)) =e= 0;
         capacidad(i, j)                                                 .. sum((f, s, e), BWD(f) * x(i, j, f, s, e)) =l= cc(i, j);
         conexionesNoRepetidas(i, j, f, s, e)                            .. x(i, j, f, s, e) + x(j, i, f, s, e) =l= 1;


Model
         Lab2Ej2 /all/;

Option MIP = SCIP;

Solve
         Lab2Ej2 using MIP minimizing z;

Display  ct;
Display  cc;
Display  x.l;
