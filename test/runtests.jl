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
        tele = Telegraph(stable_rng, 2.0, 10)
        ( tele.dwell_time == 2.0 && length(tele.signal) == 10 )
    end

    # 3) Test whether the only unique values are tele.amplitude and -tele.amplitude
    @test let 
        tele = Telegraph(500., 1e8)
        unique_vals = sort(unique(tele.signal))
        unique_vals == [-tele.amplitude, tele.amplitude]
    end
    
    # 4) Test whether the only unique values are tele.amplitude and -tele.amplitude
    @test let 
        tele = Telegraph(42., 500., 1e8)
        unique_vals = sort(unique(tele.signal))
        unique_vals == [-tele.amplitude, tele.amplitude]
    end

    # 5) Test the populations the one state to see if its about 50%
    @test let 
        tele = Telegraph(500., 1e8)
        isapprox( count(x -> x == tele.amplitude,  tele.signal) / length(tele), 0.5, atol = 0.03 )
    end
    
    # 6) Test the populations the one state to see if its about 50%
    #    This test changes the amplitude as well from the default to 25.
    @test let 
        tele = Telegraph(25, 500., 1e8)
        isapprox( count(x -> x == tele.amplitude,  tele.signal) / length(tele), 0.5, atol = 0.03 )
    end

    # 7) Test the poisson_rand functionality for integers
    @test let 
        poisson_rand(stable_rng, 50.) == 10 && poisson_rand(stable_rng, Int32, 5000) == 17725
    end

    # 8) Test that the amplitude is positive
    @test_throws ArgumentError let 
        Telegraph(-25, 500, 1000) 
    end
    
    # 9) Test that the dwell time is positive
    @test_throws ArgumentError let 
        Telegraph(25, -500, 1000) 
    end

    # 10) Test that the amplitude is positive without generate_telegraph
    @test_throws ArgumentError let 
        Telegraph(-25, 500., zeros(1000))
    end
    
    # 11) Test that the dwell time is positive without generate_telegraph
    @test_throws ArgumentError let 
        Telegraph(25, -500., zeros(1000))
    end

end
