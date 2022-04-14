struct Uncertainty <: Layer 
    raster
end 


score(cellvalue::T, ::Uncertainty) where {T<:AbstractFloat} = cellvalue
score(cellvalue::T, ::Uncertainty) where {T<:AbstractFloat} = 1.0 - cellvalue 

