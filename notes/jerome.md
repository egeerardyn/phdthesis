# Transcript of notes of Jérôme Antoni

Page numbers are as from the printed version of commit `946aebc` (i.e. the version before the private defense).

## Chapter 2

> The robustness of the 1/f input has been noted

* page 16: Please define the meaning of "robust"

>  G(s, \theta) = \sum \frac{1}{s^2/\omega_{n}^2 + 2\xi\omega_{n}^2 s + 1}

* page 17: Very limited model. Comment.

> In this example, the $\xi$ is set tp be the same in both sub-systems.

* page 19: !!

> Therefore a signal with an equidistant frequency grid is undesirable for our situatio as it wastes signal power at high frequencies at the cost of an increase variance in the lower side of the frequency band.

* Page 25: ??? Not clear why at this stage

> To return to the FRF, in Section 2.6 we will show that for a dense logarithmic frequency grid, any second order system with damping $\xi$ and resonance within the bulk of the frequency grid, will receive the same number of frequency lines in its 3dB bandwidth regardless of the actual value of the resonance frequency.
> As most information of such systems is obtained from the measurements at frequencies inside the 3 dB bandwidth, one expects and equal variance for each system as will be shown in Section 2.6.5.

* Page 26: base on a specific model!

> `unique(round(fLog/df))*df`

* Page 28: `unique` ?

> band-liited 1/f noise is a reasonable, albeit not optimal, robust excitation signal.

* Page 29: "reasonable", "robust"?

> $C_X = ... \qquad \text{(2.62)}$

* Page It seems that $\sigma_E^2(\omega) = \sigma_E^2$ later on. Should be stated clearly.

> When only the limited prior knowledge that the system resonances lie in a certain (possibly very wide) frequency band, a suitable class of excitation signals can be constructed such that the relative uncertainty of the estimated resonance is independent of the resonance frequency.
We showed that such a signal should have a power spectrum that is distributed in $1/f$.

* Page 50: I don't agree. Conclusion only valid under the class of analyzes systems ($\xi$ constant, weak modal overlap) = ideal.

## Chapter 3

> $V$ is a vector consisting of i.i.d. complex normally distributed variables

* Page 56: $V = A \cdot H \cdot E$ ?

> $\mathrm{PRESS} = \frac{E^{H} W^{-1} E}{2N_W + 1} \qquad \text{(3.86)}$

* Page 73: See Ref. Golub

> §3.6.4.2 Truncation via Exponential Fitting

* Page 82: Works only for 1 DOF systems in general ...

> $\ln |g(t)| \approx \ln A + at \text{...} \qquad \text{(3.104)}$
> 
> This is a quadratic problem in the parameters

* Page 83: Eq (3.104) is linear in the parameters. Is the problem linear or quadratic?

> Figure 3.12 (Truncation of impulse response via the fit of an exponential)

* Page 84: Use a time filter instead of brute truncation.

## Chapter 4

> $\overline{\sigma}(\tilde{\Delta}_{k_L(\omega)}(\omega)) \stackrel{\Delta}{=} \ldots$

* page 98: Very confusing notation: $\tilde{\Delta}$ is twice a function of $\omega$?? 
* The notation is actually not explained

## Chapter 5

> $\eta_{\bullet} = P(\hat{G}_{\bullet} = \hat{G}_{\circ})$

* page 129: is always zero!


