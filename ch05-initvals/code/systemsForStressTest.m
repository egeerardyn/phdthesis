function G0s = systemsForStressTest()
    order = 10;        % [] degree of the filter
    Qp    =  3;        % [dB] peak-to-peak ripple in pass-band
    Qs    = 60;        % [dB] attenuation in stop-band
    wPass =  0.5;      % [pi rad/sample] cross-over frequency
    wBand = [0.4 0.6]; % [pi rad/sample] edges of the pass/stop band
    G0s   = {DTFilter(@() cheby1(order, Qp,     wPass, 'low'      ))
             DTFilter(@() cheby1(order, Qp,     wBand, 'bandpass' ))
             DTFilter(@() cheby1(order, Qp,     wPass, 'high'     ))
             DTFilter(@() cheby1(order, Qp,     wBand, 'stop'     ))
             DTFilter(@() cheby2(order, Qp,     wPass, 'low'      ))
             DTFilter(@() cheby2(order, Qp,     wBand, 'bandpass' ))
             DTFilter(@() cheby2(order, Qp,     wPass, 'high'     ))
             DTFilter(@() cheby2(order, Qp,     wBand, 'stop'     ))
             DTFilter(@()  ellip(order, Qp, Qs, wPass, 'low'      ))
             DTFilter(@()  ellip(order, Qp, Qs, wBand, 'bandpass' ))
             DTFilter(@()  ellip(order, Qp, Qs, wPass, 'high'     ))
             DTFilter(@()  ellip(order, Qp, Qs, wBand, 'stop'     ))
             DTFilter(@() butter(order,         wPass, 'low'      ))
             DTFilter(@() butter(order,         wBand, 'bandpass' ))
             DTFilter(@() butter(order,         wPass, 'high'     ))
             DTFilter(@() butter(order,         wBand, 'stop'     ))};
function G = DTFilter(func)
     [B, A] = feval(func);
     G      = tf(B, A, 1);   % transfer function B/A and Ts = 1 [s]
     G      = G/norm(G, 2);  % enforces norm(G,2) == 1 
