# Egon Geerardyn Private PhD-Defense 2016-06-16
Notes obtained from Tomas McKelvey and converted using `pandoc`. 
Page numbers are from commit `946aebc` (i.e. private defense version).

## Chapter 1: Introduction

1.  What class of systems has been the target of the research of the
    Thesis?

    a.  LTI vs LTV vs non-linear TI vs LPV

    b.  What is the core motivation to base all simulated examples in
        the thesis

    c.  What is the main benefit to want a final low order rational
        model of the system. (Variance reduction and ease of
        simulation/control design). The trade off is possible model
        errors added.

2.  Page 2: Does all systems we want to model explicitly have designated
    inputs and outputs. C.f. work by Jan Willems on behavioral modeling.

    a.  We cannot decide on the excitation but only observe the behavior
        through measurements.

    b.  Consequences for the work of the thesis

3.  Page 3: Gray box modeling: “some parameters are related to physical
    phenomena” -> rather is the equations related to the phenomena.

4.  Page 4: “most parametric” -> most non-parametric

5.  Page 5 the grouping of users: Novice and well seasoned. Are there
    others groups of users for which these methods would be
    user-non-friendly?

## Chapter 2: Robust excitation signals

1.  Page 12: The assumption that second order system is suitable. OK if
    resonances are well apart. What about systems with closely spaced
    resonances?

2.  Page 13: e(t) is assumption on zero-mean Gaussian distribution
    necessary for the analysis. What other assumption are not mentioned
    here? Uncorrelated in time (whiteness) uncorrelated with the input.

3.  Page 14: Minizing the Variance -&gt; is only good if the bias is
    also small. You should adda comment on this to clarify for
    the reader.

4.  Bottom page 16: Explain why it is desirable to have equal variance
    for for the estimate given that the damping is the same. A system
    might have mixed type of resonanses

5.  Is it more correct to think in bode diagrams (logarithmic
    frequency scale) rather than in linear frequency scale or is this
    depending on the use of the model?

6.  What common issue to we have between robust input design and tuning
    of music instruments? Frequency quotient is 12-square root of (1/2).
    Straight tuning -&gt;”the chromatic scale” leads to dissonant
    behavior of the harmonics of the base-tones for certain keys played.
    Tempered tuning is an alternative (but is key dependent)

7.  Logarithmic Multisines are brought forward as a good choice but has
    the problem from before (not harmonically related). Could there be
    other good periodic signals with the same/similar behavior. E.g.
    Constant modulous since excitation with an exponential phase
    progression, eg periodic-chirp.

8.  In practice could it be a problem to excite the system at the
    resonance frequency.

    a.  -&gt; High amplitudes could incur non-linear behavior

    b.  -&gt; Signal must be sampled and quantized. -&gt; High dynamic
        range of signal -&gt; require many bits in the ADC to capture
        also weak parts of the system.

9.  Page 45: Figure 12: What to change in the experimental setting in
    order to make the variance similar for all resonances? (perhaps
    Increase the measurement time )

## Chapter 3: Non-Parametric Modeling

1.  LRM fits a rational model to the FRF-data -&gt; possibility to
    obtain sharp peaks -&gt; good class for resonant systems

    a.  What about LTI systems encountered e.g. in communication

        i.  Multipath case is characterized by an impulse response with
            a few large impulse response coefficients and the remaining
            close to zero

            1.  What does the frequency response look like in this case

                a.  What method could be superior in this case?

2.  Page 51: Early references are missing. Should be added to give a
    better background to the problem at hand.

3.  Page 52: Equation (3.1) infinite-data length. Strange wording …

4.  Page 52: “Measurements introduces transients” ????. Perhaps a better
    background description should be given. In state-space form ….

5.  Page 53: “It is *well known* that Transient terms are smooth”. You
    should provide a derivation of this statement.

6.  Page 57: Remark 3.3 Is this related to LRIC model only?

7.  On the numerical examples I am missing a comparison between the
    analytical bias and the numerically determined bias as a comparison.

8.  How is the LRIC method initialized? What is reason for the failure
    of the LRIC. Trapped in local minima?

9.  Page 69: SNR 10 dB what would happen for LRM(14,2,2,2)?

10. FIR truncation smoothing: What about cases when mixture of two
    resonant systems. Envelop of impulse response non-monotonic

11. Discuss global smoothing vs local smoothing. Pros and cons. Also
    realted to page 156 computational time.

12. Page 165: Ask about what the parameters of the local model can say
    about the global model? If global is second order and we locally fit
    a 2^nd^ order model we are done (if no noise exists)

**Chapter: 5 Initialization of Parametric Estimates**

1.  IS RFIR method overall well performing for all kinds of LTI systems?

    a.  Stable systems

        i.  BIBI Stable systems -&gt; impulse response absolute
            integrable -&gt; very large class of systems. DC-kernel
            enforces exponential stability

    b.  Unstable systems (do they exist as core elements in nature?)

        i.  What about the marginally stable case when the system has
            integral action. -&gt;

        ii. Is the DC-kernel suitable for these systems? What to do
            about it?

        iii. Would ETFE/LPM/LRM work better.

2.  Very local reference list for introducing parametric sysid.

3.  Page 120: You mention some initialization schemes. Are there
    others? (i.e. subspace methods)

4.  Page 123: Algorithm. What is n and n\_\\theta in
    algorithm? (dim(theta)) perhaps.

5.  Why was not LRM included in the study? Expand on Remark 5.4

6.  The empirical Bayes problem to be solved for the hyperparameters.
    What character does it have convec/non-convex.

7.  The explanantion of what Figure 5.6 is illustrating
    needs improvement. What is $\Delta RMSE(G)$

8.  Page 154: multi-tasking environments (such as computer) ????

9.  Page 154 should the time not be taken as the minimum rather than the
    median?

10. Page 154: Is it for free to use parallel computaions?

## Chapter 6: Conclusions

1.  “Optimal” choice of \\alpha. Optimal is strong. Explain.

2.  Discussion on (6.2)-(6.3). 6.3 is regularly used by others
    with success.

3.  Page 163 (FS-Esprit) is an example also based on the leakage
    compensation

4.  P 163: LRM extension to LPV systems. How to handle the notion of
    Frequency domain?

## Notational issues:

1.  N\_bw is missing in List of Symbols

2.  General comment. Many graphs have to small line width and are only
    color coded. Bad for color blind people.

3.  Page 59: Typo in equation (3.40)

4.  Page 74: “note one should also $n_w$”

5.  Page 95-96: N is never defined (only implicitly)

6.  Page 98: $\Delta_{Local(\omega)}$ is never defined

7.  Page 100: engineering community(\$)

8.  Page 163: TheLRM


