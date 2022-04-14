module BiodiversityObservationNetworks
    using SimpleSDMLayers
    using Distributions
    using NeutralLandscapes 
    using Random
    using HaltonSequences
    using StatsBase
    using Base: @kwdef

    include("types.jl")
    export SpatialSampler

    include(joinpath("layers", "layers.jl"))
    include(joinpath("optimizationaxes.jl"))
    export TemporalChangeDetection, CurrentStateDetection
    export Layer, score
    include(joinpath("layers", "landcover.jl"))
    include(joinpath("layers", "uncertainty.jl"))
    include(joinpath("layers", "climatevelocity.jl"))
    export ClimateVelocity, Uncertainty, LandCover

    include("sampler.jl")
    export rand, rand!

    include("balancedacceptance.jl")
    export BalancedAcceptance

    include("_helpers.jl")
    export makesdm, makeoccurrence, makebon, makeenv

end

# makebon(makesdm())

