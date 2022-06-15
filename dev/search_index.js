var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = TelegraphNoise","category":"page"},{"location":"#TelegraphNoise","page":"Home","title":"TelegraphNoise","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for TelegraphNoise.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [TelegraphNoise]","category":"page"},{"location":"#TelegraphNoise.TelegraphNoise","page":"Home","title":"TelegraphNoise.TelegraphNoise","text":"Random Telegraph Noise (RTN)\n\nRTN is a type of random signal with two states, on or off, up or down, etc. with a mean dwell time T_D which characterizes the amount of time the signal spends in each state  before switching.\n\nThis module provides an easy framework to generate such signals, as they happen to have  well known analytical properties. For example, the autocovariance of the signal (often  called the autocorrelation in physics literature) goes as \n\nmathcalA(t t_0 T_D) = expleft( -2fracvert t - t_0 vertT_D right) \n\nTherefore, the characteristic autocorrelation time tau = T_D2. Importantly, the  expression above shows that these random signals are stationary meaning that correlations are time-translation invariant. This means a random telgraph signal is well-suited for testing autocorrelations of random signals, for example those generated by Markov Chain Monte Carlo  methods.\n\n\n\n\n\n","category":"module"},{"location":"#TelegraphNoise.Telegraph","page":"Home","title":"TelegraphNoise.Telegraph","text":"Telegraph{T}([amplitude = one(T)], dwell_time, signal)\n\nWrapper that contains the relevant information for a given Telegraph signal. \n\n\n\n\n\n","category":"type"},{"location":"#TelegraphNoise.Telegraph-Tuple{Random.AbstractRNG, Real, Real, Real}","page":"Home","title":"TelegraphNoise.Telegraph","text":"Telegraph{T}([rng = default_rng()], [amplitude = one(T)], dwell_time, signal_length::Int)\n\nConstructor that specifies the length of the signal rather than the signal itself.\n\n\n\n\n\n","category":"method"},{"location":"#Base.eltype-Tuple{Telegraph}","page":"Home","title":"Base.eltype","text":"eltype(tele::Telegraph) → Type\n\nDispatch Base.eltype for the Telegraph object.\n\nAdditional information\n\nWrapper around Base.eltype(tele.signal).\n\n\n\n\n\n","category":"method"},{"location":"#Base.length-Tuple{Telegraph}","page":"Home","title":"Base.length","text":"length(tele::Telegraph) → Int\n\nDispatch Base.length for the Telegraph object. \n\nAdditional information\n\nWrapper around length(tele.signal).\n\n\n\n\n\n","category":"method"},{"location":"#TelegraphNoise.expd_τ-Tuple{Telegraph}","page":"Home","title":"TelegraphNoise.expd_τ","text":"expd_τ(tele::Telegraph{T}) → T\n\nReturn the expected autocorrelation time from a random telegraph signal.\n\n\n\n\n\n","category":"method"},{"location":"#TelegraphNoise.generate_telegraph-Tuple{Random.AbstractRNG, Real, Any}","page":"Home","title":"TelegraphNoise.generate_telegraph","text":"generate_telegraph([rng = default_rng()], dwell_time, signal_length; amplitude = one(T) ) → Telegraph\n\nFunction that initializes a random Telegraph signal with a  specified dwell_time and of a given length signal_length.\n\n\n\n\n\n","category":"method"},{"location":"#TelegraphNoise.poisson_rand-Tuple{Any}","page":"Home","title":"TelegraphNoise.poisson_rand","text":"poisson_rand([rng = default_rng()], dwell_time) → Int\n\nDefault implementation of the poisson_rand is to return an Int for the size of the dwell.\n\n\n\n\n\n","category":"method"},{"location":"#TelegraphNoise.poisson_rand-Union{Tuple{T}, Tuple{Type{T}, Any}} where T","page":"Home","title":"TelegraphNoise.poisson_rand","text":"poisson_rand([rng = default_rng()], ::Type{T}, dwell_time, []) → T\n\nGenerate a random number of steps in which to stay in the next state.\n\nAdditional information\n\nThe probability that an RTN signal will dwell in its current state for a time t in (t_0 t_0 + rm d t) is given by \n\nrm Prleft( t in (t_0 t_0 + rm d t) right) = rm e^-tT_D cdot fracrm dtT_D\n\nOne then samples from this probability distribution using the inverse-CDF method and obtains\n\nt approx rm floor left -T_D ln left( 1 - u right)  right\n\nwith u in (0 1) being a uniform random Float generated by rand(). The approximation  is necessary as t represents a discrete time in a time series. \n\n\n\n\n\n","category":"method"}]
}
