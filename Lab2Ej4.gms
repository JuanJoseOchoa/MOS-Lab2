*************************************************************************
***              Laboratorio 2 - Ejercicio 4                          ***
***                                                                   ***
***      Autores: Juan José Ochoa - 201913552                         ***
***               David Alvarez - 201911318                           ***
*************************************************************************

Sets
         i               Nodes /N1*N7/
         int(i)          Intermediate nodes /N1, N2, N5, N7/
         e(i)            Ending /N6/
         d               Dimensions /D1, D2/

         alias(i, j, k);

Table c(i,d)         Coordinate nodes
                  D1              D2
         N1       20              6
         N2       22              1
         N3       9               2
         N4       3               25
         N5       21              10
         N6       29              2
         N7       14              12;

Parameter
         distance(i, j)          Distance between 2 nodes
         conexion                Minimum distance to make connection
         hayConexion(i, j)       Determine a possible connection between 2 nodes
         edge(i, j)              Edge between 2 nodes if there is connection
         intermediate(int)       Saves the intermediate nodes positions
         destinations(e)         Saves ending node position;

         intermediate(int) = int.uel;

         destinations(e) = e.uel;

         edge(i, j) = 800;

         conexion = 20;

loop((i),
     loop((j),
          distance(i, j) = sqrt(sqr(c(i, 'D1')
                           - c(j, 'D1'))
                           + sqr(c(i, 'D2')
                           - c(j, 'D2')));


          if (distance(i, j) <= conexion, hayConexion(i,j) = 1);

          if (distance(i, j) > conexion,  hayConexion(i,j) = 0);

          if (hayConexion(i, j) = 1, edge(i, j) = distance(i, j));
     );
);

display
         edge;

Variables
         x(i, j, e)        Anuncia el arco que fue seleccionado para la ruta
         z                 Objective function;

Binary Variable
         x;

Equations
         funcionObj                       Funcion Objetivo


         nodoFuente(i)                    Nodo fuente
         nodosDestino                     Nodos destino
         nodoIntermedio(int, e)           Nodo intermedio
         conexionesNoRepetidas(i, j, e)   Conexiones no repetidas;


         funcionObj                              .. z =e= sum((i, j, e), edge(i, j) * x(i, j, e));
         nodoFuente(i)$(ord(i) = 4)              .. 1 =e= sum((j, e), x(i, j, e));
         nodosDestino                            .. 1 =e= sum((i, j, e)$(destinations(e) = ord(j)), x(i, j, e));
         nodoIntermedio(int, e)                  .. 0 =e= sum((j), x(int, j, e)) - sum((j), x(j, int, e));
         conexionesNoRepetidas(i, j, e)          .. 1 =g= x(i, j, e) + x(j, i, e);

Model
         Lab2Ej4 /all/;

solve
         Lab2Ej4 using MIP minimizing z;

Display x.l;
Display z.l;
