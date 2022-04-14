# the MCD.jl processes

abstract type AbstractMeasurement end 
struct Occurrence <: AbstractMeasurement end 
struct Occupancy <: AbstractMeasurement end 
struct Abundance <: AbstractMeasurement end 


# effectively this is a BON.jl wrapper around the NL temporal change generator type 
struct Scenario{U,N} where {U<:NeutralLandscapeUpdater,N}
    temporalchange::U
    niche::N 
end

