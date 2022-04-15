"""
    Demo script for BiaB functionality
"""

using NeutralLandscapes
using BiodiversityObservationNetworks
using SimpleSDMLayers
using Plots

ENV["SDMLAYERS_PATH"] = "/home/michael/data"

"""
    Layers 

"""

boundaries = (left=-76., right=-71., bottom=44., top =47.0)
landcovlayers = convert.(Float16, SimpleSDMPredictor(EarthEnv, SimpleSDMLayers.LandCover, 1:12; full=false, boundaries...))
landcov = mosaic(x -> last(findmax(x)), landcovlayers)

WATER_LAYER = 12.0
watercoords = findall(x->x==WATER_LAYER, landcov.grid)
masklayer = ones(size(landcov)) 
masklayer[watercoords] .= 0


climvelocity = mask(SimpleSDMPredictor(masklayer), SimpleSDMPredictor(rand(MidpointDisplacement(0.5), size(landcov)), boundingbox(landcov)...))
sdmuncertainty = mask(SimpleSDMPredictor(masklayer), SimpleSDMPredictor(rand(MidpointDisplacement(0.9), size(landcov)), boundingbox(landcov)...))

plot(heatmap(landcov, c=:Paired_12),heatmap(climvelocity), heatmap(sdmuncertainty))

"""
    Combine into Layers
"""

layers = [
    BiodiversityObservationNetworks.LandCover(landcov),
    ClimateVelocity(climvelocity),
    Uncertainty(sdmuncertainty)
]


scores = score(layers) 

pointfilter = scores |> 
    monitoringsites(BalancedAcceptance(500)) |> 
    monitoringsites(AdapativeSpatialSampling(50))


examplepoints = monitoringsites(pointfilter)
tradeoffcurve = validate(pointfilter, process, α = -1.0:0.05:1)
