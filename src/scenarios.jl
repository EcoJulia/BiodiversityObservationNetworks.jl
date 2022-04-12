# effectively this is a BON.jl wrapper around the NL temporal change generator type 
# and the MCD.jl processes

abstract type AbstractMeasurement end 
struct Occurrence <: AbstractMeasurement end 
struct Occupancy <: AbstractMeasurement end 
struct Abundance <: AbstractMeasurement end 

abstract type AbstractNiche{T} where T<:AbstractMeasurement end 

struct GaussianNiche
    
end 



struct Scenario{U,N} where {U<:NeutralLandscapeUpdater,N<:AbstractNiche}
    temporalchange::U
    relationship::N 
end

