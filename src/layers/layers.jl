
abstract type Layer end 

#size(l::T) where T<:Layer = size(l.raster)

abstract type OptimizationAxis end

struct TemporalChangeDetection <: OptimizationAxis end 
struct CurrentStateDetection <: OptimizationAxis end 



score(::Nothing, ::T, ::Type{A}) where {T<:Layer,A<:OptimizationAxis} = nothing

function score(layers::Vector{T};
    currentstate_weights = [0.1, 0.4, 0.5],
    temporalchange_weights = [0.1, 0.4, 0.5]) where {T<:Layer}
    
    currentstate_score = zeros(size(layers[begin].raster.grid))
    temporalchange_score  = zeros(size(layers[begin].raster.grid))
    for (i,layer) in enumerate(layers)
        @show broadcast(x->score(x, layer, TemporalChangeDetection), layer.raster.grid)
        #temporalchange_score[i] = broadcast(x->score(x, layer, TemporalChangeDetection), layer.raster.grid)
        #currentstate_score[i] = broadcast(x->score(x, layer, CurrentStateDetection), layer.raster.grid)
    end
end




