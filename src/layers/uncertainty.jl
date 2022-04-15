struct Uncertainty <: Layer 
    raster
end 


score(cellvalue::T, ::Uncertainty, ::Type{CurrentStateDetection}) where {T<:AbstractFloat} = cellvalue
score(cellvalue::T, ::Uncertainty, ::Type{TemporalChangeDetection}) where {T<:AbstractFloat} = 1.0 - cellvalue 

