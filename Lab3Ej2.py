# -*- coding: utf-8 -*-
"""
Laboratorio 3 Ejercicio 2

@authors:   David Alvarez - 201911318 
            Juan José Ochoa - 201913552
"""

from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory


Ejercicio2 = ConcreteModel()

# Sets and Parameters
songs = 8

N = RangeSet(1, songs)

length = {1:4, 2:5, 3:3, 4:2, 5:4, 6:3, 7:5, 8:4}

# Variables
Ejercicio2.x = Var(N, domain = Binary)

# Objective Function
Ejercicio2.obj = Objective(expr = sum(Ejercicio2.x[i] for i in N))

# Constraints
Ejercicio2.startTime = Constraint(expr = sum(Ejercicio2.x[i] * length[i] for i in N) >= 14)
Ejercicio2.endTime = Constraint(expr = sum(Ejercicio2.x[i] * length[i] for i in N) <= 16)
Ejercicio2.bluesSongs = Constraint(expr = Ejercicio2.x[1] + Ejercicio2.x[3] + Ejercicio2.x[5] + Ejercicio2.x[8] == 2)
Ejercicio2.rockSongs = Constraint(expr = Ejercicio2.x[2] + Ejercicio2.x[4] + Ejercicio2.x[6] + Ejercicio2.x[8] >= 3)
Ejercicio2.xSong = Constraint(expr =  1 - Ejercicio2.x[5] >= Ejercicio2.x[1])
Ejercicio2.ySong = Constraint(expr = Ejercicio2.x[2] + Ejercicio2.x[4] <= 2 - Ejercicio2.x[1])
    
# Applying the solver
SolverFactory('glpk').solve(Ejercicio2)

Ejercicio2.display()