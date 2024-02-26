# `FlightConditions`

Small package to calculate atmospheric conditions using the standard atmosphere or given a (pressure, temperature) pair.

## Example

```julia
using FlightConditions

fc1 = FlightCondition(1e3)
println(fc1)

fc2 = FlightCondition(1e5, 300)
println(fc2)
```

### Output

```julia
─── Flight Condition ───
  T =     281.68 K     (temperature)
  p =    89902.6 Pa    (pressure)
  ρ =     1.1118 kg/m³ (density)
  μ =  1.758e-05 Pa·s  (kinematic viscosity)
  ν =  1.581e-05 m²/s  (dynamic viscosity)
  c =     336.46 m/s   (speed of sound)

─── Flight Condition ───
  T =     300.00 K     (temperature)
  p =   100000.0 Pa    (pressure)
  ρ =     1.1612 kg/m³ (density)
  μ =  1.847e-05 Pa·s  (kinematic viscosity)
  ν =  1.591e-05 m²/s  (dynamic viscosity)
  c =     347.22 m/s   (speed of sound)
```

## License

This code is licensed under MIT.
