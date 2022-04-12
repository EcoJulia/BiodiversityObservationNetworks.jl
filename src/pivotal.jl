@kwdef struct Pivotal{IT<:Integer,FT<:AbstractFloat} <: SpatialSampler 
    expectedsample::IT = 50
    padding::FT = 0.1
end

function _neighbor(index, bounds)
    newindex = CartesianIndex(bounds .+ (1,1))
    while newindex[1] < 1 || newindex[2] < 1 || newindex[1] > bounds[1] || newindex[2] > bounds[2]
        newindex = index + sample(CartesianIndex(-1,-1):CartesianIndex(1,1))
    end
    return newindex
end

function _generate!(piv::Pivotal, uncertainty::M) where {M<:AbstractMatrix}
    normalizeduncertainty = uncertainty ./ sum(uncertainty)
    inclusionprob = piv.expectedsample .* normalizeduncertainty

    allindecies = [CartesianIndex((1,1)):CartesianIndex(size(uncertainty))...]
    while length(allindecies) > 0
        thisindex = rand(eachindex(allindecies))
        i, j = allindecies[thisindex], _neighbor(allindecies[thisindex], size(uncertainty))
        πᵢ,πⱼ = inclusionprob[i], inclusionprob[j]

        if πᵢ + πⱼ < 1
            bump, lower = rand() > (πⱼ / (πᵢ + πⱼ)) ? (i,j) : (j,i) 
            inclusionprob[bump] = πᵢ + πⱼ
            inclusionprob[lower] = 0
            splice!(allindecies, findall(x->x==lower, allindecies))
        else
            bump, lower = rand() > ((1-πⱼ) / (2 - πᵢ - πⱼ)) ? (i,j) : (j,i) 
            inclusionprob[bump] = 1
            inclusionprob[lower] = πᵢ+πⱼ - 1
            splice!(allindecies, findall(x->x==bump, allindecies))
        end
    end

    nonzero = CartesianIndex.(findall(x-> x > 0, inclusionprob))
    @show nonzero
    return filter!(x -> rand() < inclusionprob[x], nonzero)
end


#uncertainty = rand(MidpointDisplacement(0.8),100,100)
#heatmap(uncertainty)
#rand(Pivotal(expectedsample=500), uncertainty)