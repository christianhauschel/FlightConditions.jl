module FlightConditions

using PyFormattedStrings
using ISAData

const γ = 1.4
const R = 287.058

export FlightCondition, update!, γ, R


"""
Flight condition struct

T: temperature (K)
p: pressure (Pa)
ρ: density (kg/m³)
μ: dynamic viscosity (Pa·s)
ν: kinematic viscosity (m²/s)
c: speed of sound (m/s)
"""
mutable struct FlightCondition
    T::Float64
    p::Float64
    ρ::Float64
    μ::Float64
    ν::Float64
    c::Float64
end

"""
    FlightCondition(altitude)

Constructor for FlightCondition given the altitude using the standard atmosphere.
"""
function FlightCondition(altitude::Number)
    ρ, p, T, μ = ISAdata(altitude)
    ν = μ / ρ
    c = sqrt(γ * R * T)
    return FlightCondition(T, p, ρ, μ, ν, c)
end

"""
    update!(fc, altitude)

Update the FlightCondition given the altitude, using the standard atmosphere.
"""
function update!(fc::FlightCondition, altitude::Number)
    fc.ρ, fc.p, fc.T, fc.μ = ISAdata(altitude)
    
    fc.ν = μ / ρ
    fc.c = sqrt(γ * R * T)
end

"""
    FlightCondition(p, T)

Constructor for FlightCondition given the pressure and temperature.
"""
function FlightCondition(p::Number, T::Number)
    ρ = p / (R * T)
    μ = sutherland(T)
    ν = μ / ρ
    c = sqrt(γ * R * T)
    return FlightCondition(T, p, ρ, μ, ν, c)
end

"""
Update the FlightCondition given the pressure and temperature.
"""
function update!(fc::FlightCondition, p::Number, T::Number)
    fc.ρ = p / (R * T)
    fc.μ = sutherland(T)
    
    fc.ν = μ / ρ
    fc.c = sqrt(γ * R * T)
end

"""
Sutherland's law for dynamic viscosity of air.

# References
1. https://doc.comsol.com/5.5/doc/com.comsol.help.cfd/cfd_ug_fluidflow_high_mach.08.27.html
"""
function sutherland(T; μ_ref = 1.716e-5, T_ref = 273, S = 111)
    return μ_ref * (T / T_ref)^(3/2) * (T_ref + S) / (T + S)
end


function Base.show(io::IO, fc::FlightCondition)
    print(io, "─── Flight Condition ───\n")
    print(io, f"  T = {fc.T:10.2f} K     (temperature)\n")
    print(io, f"  p = {fc.p:10.1f} Pa    (pressure)\n")
    print(io, f"  ρ = {fc.ρ:10.4f} kg/m³ (density)\n")
    print(io, f"  μ = {fc.μ:10.3e} Pa·s  (kinematic viscosity)\n")
    print(io, f"  ν = {fc.ν:10.3e} m²/s  (dynamic viscosity)\n")
    print(io, f"  c = {fc.c:10.2f} m/s   (speed of sound)")
end

end # module FlightCondition

