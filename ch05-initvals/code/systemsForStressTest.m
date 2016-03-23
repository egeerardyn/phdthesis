function G0s = systemsForStressTest()
    order = 10;        % [] degree of the filter
    Qp    =  3;        % [dB] peak-to-peak ripple in pass-band
    Qs    = 60;        % [dB] attenuation in stop-band
    wPass =  0.5;      % [pi rad/sample] cross-over frequency
    wBand = [0.4 0.6]; % [pi rad/sample] edges of the pass/stop band
    G0s   = {normFilterDT(@() cheby1(order, Qp,     wPass, 'low'      ))
             normFilterDT(@() cheby1(order, Qp,     wBand, 'bandpass' ))
             normFilterDT(@() cheby1(order, Qp,     wPass, 'high'     ))
             normFilterDT(@() cheby1(order, Qp,     wBand, 'stop'     ))
             normFilterDT(@() cheby2(order, Qp,     wPass, 'low'      ))
             normFilterDT(@() cheby2(order, Qp,     wBand, 'bandpass' ))
             normFilterDT(@() cheby2(order, Qp,     wPass, 'high'     ))
             normFilterDT(@() cheby2(order, Qp,     wBand, 'stop'     ))
             normFilterDT(@()  ellip(order, Qp, Qs, wPass, 'low'      ))
             normFilterDT(@()  ellip(order, Qp, Qs, wBand, 'bandpass' ))
             normFilterDT(@()  ellip(order, Qp, Qs, wPass, 'high'     ))
             normFilterDT(@()  ellip(order, Qp, Qs, wBand, 'stop'     ))
             normFilterDT(@() butter(order,         wPass, 'low'      ))
             normFilterDT(@() butter(order,         wBand, 'bandpass' ))
             normFilterDT(@() butter(order,         wPass, 'high'     ))
             normFilterDT(@() butter(order,         wBand, 'stop'     ))};
function G = normFilterDT(func)
     [B, A] = feval(func);
     G      = tf(B, A, 1);   % transfer function B/A and Ts = 1 [s]
     G      = G/norm(G, 2);  % enforces norm(G,2) == 1 
