struct LandCover <: Layer 
    raster
end 

_landcover_labels() = Dict(
    :evergreen_deciduous => 1, 
    :evergreen => 2, 
    :deciduous => 3, 
    :mixedtrees => 4, 
    :shrubs => 5, 
    :herbvegetation => 6, 
    :cultivatedvegetation => 7, 
    :floodedvegetation => 8, 
    :urban => 9, 
    :snowice => 10,
    :barren => 11,
    :water => 12)


function score(
    cellvalue::T, 
    ::LandCover, 
    ::Type{CurrentStateDetection}; 
    scores =  Dict(
        :evergreen_deciduous => 0.1, 
        :evergreen => 0.1, 
        :deciduous => 0.1, 
        :mixedtrees => 0.1, 
        :shrubs => 0.1, 
        :herbvegetation => 0.1, 
        :cultivatedvegetation => 0.05, 
        :floodedvegetation => 0.1, 
        :urban => 0.05, 
        :barren => 0.05,
        :water => 0)) where {T<:AbstractFloat}

    labels = _landcover_labels()

    key = findall(x->x==cellvalue, labels)
    return scores[key...] 
end

function score(
    cellvalue::T, 
    ::LandCover, 
    ::Type{TemporalChangeDetection}; 
    scores =  Dict(
        :evergreen_deciduous => 0.1, 
        :evergreen => 0.1, 
        :deciduous => 0.1, 
        :mixedtrees => 0.1, 
        :shrubs => 0.1, 
        :herbvegetation => 0.1, 
        :cultivatedvegetation => 0.05, 
        :floodedvegetation => 0.1, 
        :urban => 0.05, 
        :barren => 0.05,
        :water => 0)
    ) where {T<:AbstractFloat}
    
    labels = _landcover_labels()
    key = findall(x->x==cellvalue, labels)
    return scores[key...] 
end
