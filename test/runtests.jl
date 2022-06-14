using TelegraphNoise
using Test
using Random
using StableRNGs # for testing

# For tesing purposes. 
# The order of the tests cannot be changed without changing the output.
stable_rng = StableRNG(42)

@testset "TelegraphNoise.jl" begin
    # Test the expected autocorrelation time
    @test let 
        tele = Telegraph(50.0, [0.])
        expd_τ(tele) == 25.0
    end

    # Test the (dwell_time, signal_length) constructor
    @test let 
        @show tele = Telegraph(stable_rng, 2.0, 10)
        ( tele.dwell_time == 2.0 &&
          tele.signal == [-1.0, 1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0] )
    end

    # Test the poisson_rand functionality for integers
    @test let 
        (@show poisson_rand(stable_rng, 50.)) == 10 && (@show poisson_rand(stable_rng, Int32, 5000)) == 17725
    end
end
