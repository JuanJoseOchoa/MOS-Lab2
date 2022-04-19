# -*- coding: utf-8 -*-
"""
Laboratorio 3 Ejercicio 1

@authors:   David Alvarez - 201911318
            Juan José Ochoa - 201913552
"""

from __future__ import division
import math
from pyomo.environ import *

from pyomo.opt import SolverFactory


Ejercicio1 = ConcreteModel()

# Sets and Parameters
nodes = 7

N = RangeSet(1, nodes)

Ejercicio1.matrix = {(1, 1): 20, (1, 2): 6,
                     (2, 1): 22, (2, 2): 1,
                     (3, 1): 9, (3, 2): 2,
                     (4, 1): 3, (4, 2): 25,
                     (5, 1): 21, (5, 2): 10,
                     (6, 1): 29, (6, 2): 2,
                     (7, 1): 14, (7, 2): 12}

Ejercicio1.cost = Param(N, N, mutable = True)

Ejercicio1.edge = 20

for i in N:
    
    for j in N:
        
        costB = math.sqrt((Ejercicio1.matrix[i, 1] - Ejercicio1.matrix[j, 1]) ** 2 + (
            Ejercicio1.matrix[i, 2] - Ejercicio1.matrix[j, 2]) ** 2)
        if costB <= Ejercicio1.edge and costB != 0:
            Ejercicio1.cost[i, j] = costB
        else:
            Ejercicio1.cost[i, j] = 999

# Variables
Ejercicio1.x = Var(N, N, domain = Binary)

# Objective Function
Ejercicio1.obj = Objective(
    expr=sum(Ejercicio1.x[i, j] * Ejercicio1.cost[i, j] for i in N for j in N))

# Constraints


def source_rule(Ejercicio1, i):
    
    if i == 4:
        return sum(Ejercicio1.x[i, j] for j in N) == 1
    else:
        return Constraint.Skip


def destination_rule(Ejercicio1, j):
    
    if j == 6:
        return sum(Ejercicio1.x[i, j] for i in N) == 1
    else:
        return Constraint.Skip


def intermediate_rule(Ejercicio1, i):
    
    if i != 4 and i != 6:
        return sum(Ejercicio1.x[i, j] for j in N) - sum(Ejercicio1.x[j, i] for j in N) == 0
    else:
        return Constraint.Skip


Ejercicio1.source = Constraint(N, rule = source_rule)
Ejercicio1.destination = Constraint(N, rule = destination_rule)
Ejercicio1.intermediate = Constraint(N, rule = intermediate_rule)

# Applying the solver
SolverFactory('glpk').solve(Ejercicio1)

Ejercicio1.display()
Ejercicio1.x