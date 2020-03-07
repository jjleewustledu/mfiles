function [tbl,s] = t0_and_dt(tmax, varargin)
    %% is intended for determining constant SNR timings for [15O] TACs
    %  @param tmax is scan duration / sec
    %  @param xi   is duration of first frame; default := 2 sec
    %  @param hl   is the tracer halflife; default = 122.24 sec for [15O]
    %                                                60*109.771(20) sec for [18F]
    %  @param mult multiplies lambda; default := 1
    %  @return tbl is table:  t0, dt
    %  @return s   is string for dt

    ip = inputParser;
    addParameter(ip, 'xi', 2);
    addParameter(ip, 'hl', 122.24);
    addParameter(ip, 'mult', 1);
    addParameter(ip, 'nudge', 0)
    parse(ip, varargin{:});
    ipr = ip.Results;
    
    tbl_t0 = [];
    tbl_dt = [];
    t0 = 0;
    nudge = 0;
    while t0 < tmax
        tbl_t0 = [tbl_t0; t0]; %#ok<*AGROW>
        tbl_dt = [tbl_dt; ceil(t0_to_deltat(t0, ipr.xi, ipr.hl, ipr.mult) + nudge)];
        t0 = t0 + tbl_dt(end);
        nudge = nudge + ipr.nudge;
    end
    if sum(tbl_dt) > tmax
        tbl_dt(end) = tmax - sum(tbl_dt(1:end-1));
    end
    tbl = table(tbl_t0, tbl_dt, 'VariableNames', {'t0' 'dt'});

    s = '[';
    for idx = 1:length(tbl.dt)
        s = sprintf('%s%i,', s, tbl.dt(idx));
    end
    s = [s(1:end-1) ']'];


    
    %% INNER

    function dt = t0_to_deltat(t0, xi, hl, mult)
        lam = log(2)/hl;
        dt  = ceil(xi*exp(mult*lam*t0));
        %dt = (2/lam)*(1 - exp(lam*t0));
    end

    function t0 = deltat_to_t0(dt) %#ok<*DEFNU>
        lam = log(2)/122.24;
        t0  = (1/lam) * log(1 - 0.5*lam*dt);
        %t0  = (1/lam)*log( (1 - exp(-lam*dt))./(lam*dt) );
    end

end