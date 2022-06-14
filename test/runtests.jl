using TelegraphNoise
using Test
using Random
using StableRNGs # for testing

# For tesing purposes. 
# The order of the tests cannot be changed without changing the output.
stable_rng = StableRNG(42)

@testset "TelegraphNoise.jl" begin
    # 1) Test the expected autocorrelation time
    @test let 
        tele = Telegraph(50.0, [0.])
        expd_τ(tele) == 25.0
    end

    # 2) Test the (dwell_time, signal_length) constructor
    @test let 
        @show tele = Telegraph(stable_rng, 2.0, 10)
        ( tele.dwell_time == 2.0 && length(tele.signal) == 10 )
    end

    # 3) Test whether the only unique values are one and -one
    @test let 
        tele = Telegraph(500., Int(1e8))
        unique_vals = sort(unique(tele.signal))
        unique_vals == [-one(eltype(tele)), one(eltype(tele))]
    end

    # 4) Test the populations the one state to see if its about 50%
    @test let 
        tele = Telegraph(500., Int(1e8))
        isapprox( count(x -> x == one(eltype(tele)),  tele.signal) / length(tele), 0.5, atol = 0.03 )
    end

    # 5) Test the poisson_rand functionality for integers
    @test let 
        (@show poisson_rand(stable_rng, 50.)) == 10 && (@show poisson_rand(stable_rng, Int32, 5000)) == 17725
    end
end
