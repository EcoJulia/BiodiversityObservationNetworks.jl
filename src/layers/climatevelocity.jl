struct ClimateVelocity <: Layer 
    raster
end 


score(cellvalue::T, 
    ::Type{ClimateVelocity}, 
    ::TemporalChangeDetection) where {T<:AbstractFloat} = cellvalue


score(cellvalue::T, 
    ::Type{ClimateVelocity}, 
    ::CurrentStateDetection) where {T<:AbstractFloat} = 1.0 - cellvalue 
