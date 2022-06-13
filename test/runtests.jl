using TelegraphNoise
using Test
using Random

Random.seed!(42) # For tesing purposes.

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
end
