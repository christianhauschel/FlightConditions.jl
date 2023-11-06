using Revise
using FlightConditions

fc1 = FlightCondition(1e3)
println(fc1)

fc2 = FlightCondition(1e5, 300)
println(fc2)