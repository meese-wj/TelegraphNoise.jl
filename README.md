# TelegraphNoise

<!-- [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://meese-wj.github.io/TelegraphNoise.jl/stable) -->
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://meese-wj.github.io/TelegraphNoise.jl/dev)
[![Build Status](https://github.com/meese-wj/TelegraphNoise.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/meese-wj/TelegraphNoise.jl/actions/workflows/CI.yml?query=branch%3Amain)

A Julia package for generating random telegraph noise (RTN). 

RTN, also known as [_burst noise_](https://en.wikipedia.org/wiki/Burst_noise?oldformat=true) or a _random telegraph signal_, have a set of useful analytical properties which can make them ideal for testing the statistical analyses of time series. For example, in the simplest cases, RTNs have two equally probable states and are characterized by a single time scale, known as the _dwell time_ $T_D$, which represents the average time spent in either state before switching. The probability of the signal inhabiting either state for a time $t \in (t_0, t_0 + {\rm d}t)$ is given by 
$$
{\rm Pr}\left( t \in (t_0, t_0 + {\rm d} t) \right) = {\rm e}^{-t/T_D} \cdot \frac{{\rm d}t}{T_D}.
$$
One can then [show](https://dsp.stackexchange.com/questions/16596/autocorrelation-of-a-telegraph-process-constant-signal) that the autocovariance $\mathcal{A}$ (autocorrelation for de-meaned signals) goes as 
$$
\mathcal{A}(t, t_0; T_D) = \exp\left( -2\,\frac{\vert t - t_0 \vert}{T_D} \right),
$$
showing the stationarity of these processes. Furthermore, the _autocorrelation time_ $\tau$ of such a signal then follows exactly as $\tau = T_D /2$.
