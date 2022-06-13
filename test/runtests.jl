using TelegraphNoise
using Test
using Random

# For tesing purposes. 
# The order of the tests cannot be changed without changing the output.
Random.seed!(42) 

@testset "TelegraphNoise.jl" begin
    # Test the expected autocorrelation time
    @test let 
        tele = Telegraph(50.0, [0.])
        expd_τ(tele) == 25.0
    end

    # Test the (dwell_time, signal_length) constructor
    @test let 
        tele = Telegraph(2.0, 10)
        ( tele.dwell_time == 2.0 &&
          tele.signal == [1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0] )
    end

    # Test the poisson_rand functionality for integers
    @test let 
        poisson_rand(50.) == 30 && poisson_rand(Int32, 5000) == 1778
    end
end
