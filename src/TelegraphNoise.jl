@doc raw"""
# Random Telegraph Noise (RTN)
RTN is a type of random signal with two states, on or off, up or down, _etc._ with a mean
_dwell time_ ``T_D`` which characterizes the amount of time the signal spends in each state 
before switching.

This module provides an easy framework to generate such signals, as they happen to have 
well known analytical properties. For example, the autocovariance of the signal (often 
called the _autocorrelation_ physics literature) goes as 
```math
\mathcal{A}(t, t_0; T_D) = \exp\left( -2\frac{\vert t - t_0 \vert}{T_D} \right). 
```
Therefore, the characteristic _autocorrelation time_ ``\tau = T_D/2``. Importantly, the 
expression above shows that these random signals are _stationary_ meaning that correlations
are time-translation invariant. This means a random telgraph signal is well-suited for testing
autocorrelations of random signals, for example those generated by Markov Chain Monte Carlo 
methods.
"""
module TelegraphNoise

using Random

export Telegraph, expd_τ, generate_telegraph, generate_telegraph!, poisson_rand

"""
    Telegraph(dwell_time, signal)

Wrapper that contains the relevant information for a given `Telegraph` signal. 
"""
struct Telegraph{T <: AbstractFloat}
    dwell_time::T
    signal::Vector{T}
end

"""
    expd_τ(tele::Telegraph{T}) → T

Return the expected autocorrelation time from a random telegraph signal.
"""
expd_τ(tele::Telegraph ) = convert(typeof(tele.dwell_time), 0.5) * tele.dwell_time


"""
    Telegraph([rng = GLOBAL_RNG], dwell_time, signal_length::Int)

Constructor that specifies the length of the signal rather than the signal itself.
"""
Telegraph(rng::AbstractRNG, dwell_time, signal_length::Int) = generate_telegraph(rng, dwell_time, signal_length)
Telegraph(dwell_time, signal_length::Int) = generate_telegraph(dwell_time, signal_length)

"""
    generate_telegraph([rng = GLOBAL_RNG], dwell_time, signal_length ) → Telegraph

Function that initializes a random [`Telegraph`](@ref) signal with a 
specified `dwell_time` and of a given length `signal_length`.
"""
function generate_telegraph(rng::AbstractRNG, dwell_time, signal_length )
    
    tele = Telegraph(dwell_time, zeros(typeof(dwell_time), signal_length))
    last_idx = 1
    tele.signal[last_idx] = ifelse( rand(rng) < 0.5, one(dwell_time), -one(dwell_time) )
    while last_idx < signal_length
        stepsize = poisson_rand(dwell_time)
        stepsize = ifelse( last_idx + 1 + stepsize > signal_length, signal_length - (last_idx + 1), stepsize )
        next_value = ifelse( tele.signal[last_idx] == one(dwell_time), -one(dwell_time), one(dwell_time) )
        tele.signal[last_idx + 1 : last_idx + 1 + stepsize] .= next_value
        last_idx = last_idx + 1 + stepsize
    end
    return tele

    # signal::Vector{Float64} = []
    # stepsize = poisson_rand(rng, dwell_time)
    # while stepsize < 1
    #     stepsize = poisson_rand(rng, dwell_time)
    # end
    # append!(signal, ones(stepsize))
    # while length(signal) < Int(signal_length)
    #     stepsize = poisson_rand(rng, dwell_time)
    #     if signal[end] == 1
    #         append!(signal, zeros(stepsize))
    #     else
    #         append!(signal, ones(stepsize))
    #     end
    # end
    # return Telegraph( dwell_time, signal[1:signal_length] )
end
generate_telegraph(dwell_time, signal_length::Int) = generate_telegraph(Random.default_rng(), dwell_time, signal_length)

@doc raw"""
    poisson_rand([rng = GLOBAL_RNG], ::Type{T}, dwell_time, []) → T

Generate a random number of steps in which to stay in the next state.

# Additional information
The probability that an RTN signal will _dwell_ in its current state for a time
``t \in [t_0, t_0 + {\rm d} t)`` is given by 
```math
{\rm Pr}\left( t \in [t_0, t_0 + {\rm d} t) \right) = {\rm e}^{-t/T_D} \cdot \frac{{\rm d}t}{T_D}.
```

One then samples from this probability distribution using the _inverse-CDF_ method and obtains
```math
t \approx {\rm floor} \left[ -T_D \ln \left( 1 - u \right)  \right],
```
with ``u \in (0, 1)`` being a uniform random `Float` generated by `rand()`. The approximation 
is necessary as ``t`` represents a discrete time in a time series. 
"""
poisson_rand(::Type{T}, dwell_time) where {T} = _poisson_floor(T, dwell_time)
poisson_rand(rng::AbstractRNG, ::Type{T}, dwell_time) where {T} = _poisson_floor(T, dwell_time, rng)
_poisson_func(dwell_time, rng::AbstractRNG = Random.default_rng()) = -dwell_time * log(1.0 - rand(rng))
_poisson_floor(::Type{T}, dwell_time, rng::AbstractRNG = Random.default_rng()) where {T} = floor(T, _poisson_func(dwell_time, rng))

"""
    poisson_rand([rng = GLOBAL_RNG], dwell_time) → Int

Default implementation of the [`poisson_rand`](@ref) is to return an `Int` for the size of the _dwell_.
"""
poisson_rand(dwell_time) = poisson_rand(Int, dwell_time)
poisson_rand(rng::AbstractRNG, dwell_time) = poisson_rand(rng, Int, dwell_time)


end
