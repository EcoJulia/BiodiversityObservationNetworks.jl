
abstract type Layer end 

function score(layers::Vector{T}, 
    currentstate_weights = [0.1, 0.4, 0.5],
    temporalchange_weights = [0.1, 0.4, 0.5]) where {T<:Layer}
    
    currentstate_score = zeros(size(layers[begin]))
    temporalchange_score  = zeros(size(layers[begin]))
    for (i,layer) in enumerate(layers)
        score(layer, TemporalChangeDetection, )
    end
end