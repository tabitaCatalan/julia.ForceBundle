# Compatibility measures 

Definitions and explanations on the defined compatibility measures can be found in (INSERT REF). Here are the details of the implementation.

## Angle compatibility 

## Visibility compatibility 

Further discussion on this can be found in [this Issue in python.ForceBundle](https://github.com/tabitaCatalan/python.ForceBundle/issues/3) 

<!--(TODO: INSERTAR DIAGRAMA) -->

The intersection between the _visibility band_ of the Edge `Q`
and the straight line given by the edge `P` is calculated with `proyectedEdge`. It calculates the direction perpendicular to `Q` using `perpendicular_slope`. After that, it calculates the `intersection_point` between the straight line defined by `P` and the lines that pass over `source(Q)` and `target(Q)` in that perpendicular direction.

```@docs
ForceBundle.intersection_point
```

```@docs
ForceBundle.perpendicular_slope
```

```@docs
ForceBundle.proyectedEdge
```
 