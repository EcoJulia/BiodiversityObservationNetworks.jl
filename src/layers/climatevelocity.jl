struct ClimateVelocity <: Layer 
    raster
end 


score(cellvalue::T, 
    ::ClimateVelocity, 
    ::Type{TemporalChangeDetection}) where {T<:AbstractFloat} = cellvalue


score(cellvalue::T, 
    ::ClimateVelocity, 
    ::Type{CurrentStateDetection}) where {T<:AbstractFloat} = 1.0 - cellvalue 


    