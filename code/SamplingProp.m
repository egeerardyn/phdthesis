classdef SamplingProp < handle & Describable & WithUserData & Codegeneratable
    %SAMPLINGPROP Properties of equidistant time sampling
    %
    % This object tracks basic properties for equidistant time/frequency
    % sampling. All scalar properties can be set by the user, the other
    % properties will be adapted accordingly. The vector properties
    % can also be set, but are coerced into a format that is compatible
    % with the internal storage. I.e. when t is set, a number of samples N
    % and mean time step dt are extracted, but the exact time instance are
    % not enforced. For non-equidistant sampling, this can result in
    % significant errors (for which a heuristic warning will be shown).
    %
    % The properties are based on two fundamental properties: 
    %   - the sampling time    : Ts_ (stored in Ts__) 
    %   - the number of samples: N_ (stored in N__)
    % 
    % The relationships that are enforced by this object are:
    %  Tm = N * Ts
    %  fs = 1 / Ts
    %  dt = Ts
    %  df = 1 / Tm = 1 / ( N * Ts )
    %  t  = n * Ts
    %  w  = 2 * pi * f
    %  k  = 0:N-1 (frequency index)
    %  n  = 0:N-1 (time index)
    %  wn = 2*pi*k/N
    %
    % Some of these properties (e.g. the measurement time Tm) depend on
    % both Ts_ and N_. When such properties are set, either N_ or Ts_ has
    % to be adapted to fulfill all relations. This is done by keeping track
    % of which basic property has been set the last (stored in
    % lastProperty_). The last set property is considered fixed for the
    % calculation. So when N has been set, and Tm is set afterwards, this
    % will be done by changing Ts.
    
    %% Dependent properties
    properties(Dependent)
        % resolution
        dt % [s] sampling time
        df % [Hz] frequency resolution
        dw % [rad/s] pulsation resolution
        % range
        fs % [Hz] sampling frequency
        ws % [rad/s] sampling pulsation
        N  % [] number of samples
        Tm % [s] measurement time
        % time axis
        n  % [] time index
        t  % [s] physical time
        % frequency axis
        k  % [] frequency index
        w  % [rad/s] pulsation
        wn % [rad] normalized pulsation
        f  % [Hz] frequency
        w_pos % [rad/s] negative frequency axis
        f_pos % [Hz] positive frequency axis
        sel_pos % [] logical array indicating positive frequency spectrum
        %TODO: sel_DC, sel_Nyquist, sel_DCNyquist
    end
    %% Conveniance aliasses
    properties(Hidden,Dependent)
        lastProperty; % last set property
        Ts;    % [s] sampling time
        Tmeas; % [s] measurement time
    end
    %% Actual Data Storage
    properties(Hidden,Dependent)
        N_;
        Ts_;
    end
    properties(Access=protected)
        N__  = 1; % [] number of samples
        Ts__ = 1; % [s] sampling time
        lastProperty_ = 'N';
    end
    %% constructor
    methods
        function obj = SamplingProp(varargin)
            % SamplingProp constructor
            %
            % Usage:
            %
            %   SP = SamplingProp()
            %   SP = SamplingProp(N)
            %   SP = SamplingProp(old)
            %   SP = SamplingProp(key,value, key,value, ...)
            %
            % With:
            %   N: number of samples (default:1)
            %   old: SamplingProp object -> clones the (handle) object
            %   key: name of a property (case sensitive!)
            %   value: value for the property
            %
            % With the key-value pair syntax, each assignment is performed in
            % the order of the arguments. I.e. the last pair is the most
            % important with respect to setting either of the basic
            % properties N_ and Ts_.
            %
            if nargin == 1
                if isa(varargin{1},'SamplingProp')
                    % perform deep copy
                    old = varargin{1};
                    obj = old.clone();
                else
                    obj.N_ = varargin{1};
                end
            elseif nargin > 1
                keys = varargin(1:2:end);
                vals = varargin(2:2:end);
                for iKV = 1:min(numel(keys),numel(vals));
                    key = keys{iKV};
                    val = vals{iKV};
                    if isprop(obj,key)
                        obj.(key) = val;
                    else
                        error('SamplingProp:UnknownProperty',...
                              'SamplingProp has no property "%s"',key);
                    end
                end
            end            
        end
        function new = clone(old)
            new = SamplingProp();
            new.N__           = old.N__;
            new.Ts__          = old.Ts__;
            new.lastProperty_ = old.lastProperty_;
        end
    end
    
    %% public getters & setters
    methods
        % getters
        function value = get.dt(obj)
            value = obj.Ts_;
        end
        function value = get.df(obj)
           value = obj.fs ./ obj.N_;
        end
        function value = get.dw(obj)
           value = 2*pi .* obj.df;
        end
        function value = get.fs(obj)
            value = 1./obj.Ts_;
        end
        function value = get.ws(obj)
            value = 2*pi * obj.fs;
        end
        function value = get.N(obj)
            value = obj.N_;
        end
        function value = get.Tm(obj)
            value = obj.N_ .* obj.Ts_;
        end
        
        % axes properties (only getters)
        function value = get.n(obj)
            value = 0:(obj.N_-1);
        end
        function value = get.t(obj)
            value = obj.n .* obj.Ts_;
        end
        function value = get.k(obj)
            value = 0:(obj.N_-1);
        end
        function value = get.f(obj)
            if obj.N_ > 1
                value = obj.alias(obj.k ./ (obj.N_) .* obj.fs);
            else
                value = obj.k;
            end
        end
        function value = get.w(obj)
            value = 2*pi*obj.f;
        end
        function value = get.wn(obj)
            value = obj.k ./ obj.N * 2 * pi;
        end
        function value = get.sel_pos(obj)
            f = obj.f;
            value = f>0 & f<=obj.fs/2;
        end
        function value = get.f_pos(obj)
            value = obj.f(obj.sel_pos);
        end
        function value = get.w_pos(obj)
            value = obj.w(obj.sel_pos);
        end
        
        % setters
        function set.dt(obj,value)
            obj.Ts_ = value;
        end
        function set.df(obj,value)
            switch obj.lastProperty_
                case 'N'
                    obj.Ts_ = 1./(obj.N_ .* value);
                case 'Ts'
                    obj.N_ = 1./(obj.Ts_ .* value);
            end
        end
        function set.dw(obj,value)
            obj.df = value / (2*pi);
        end
        function set.fs(obj,value)
            obj.Ts_ = 1./value;
        end
        function set.ws(obj,value)
            obj.fs = value /(2*pi);
        end
        function set.N(obj,value)
            obj.N_ = value;
        end
        function set.Tm(obj,value)
            switch obj.lastProperty_
                case 'N'
                    obj.Ts_ = value./obj.N_;
                case 'Ts'
                    obj.N_ = value./obj.Ts_;
            end
        end
        
        % vector setters (approximate)
        function set.n(obj,value)
            obj.N_ = numel(value);
        end
        function set.k(obj,value)
            obj.N_ = numel(value);
        end
        function set.wn(obj,value)
            obj.N_ = numel(value);
        end
        function set.t(obj,value)
            dtt = diff(value);
            dt = mean(dtt);
            if any(abs(dtt-dt)>eps(dt)*1000)
                warning('SamplingProp:TimeVectorSetInaccurate',...
                        'Setting the time vector may be inaccurate');
            end
            obj.N_ = numel(value); % N can be estimated very accurately => force
            obj.dt = dt; % df might be less accurate
        end
        function set.f(obj,value)
            dff = diff(value);
            df = mean(dff);
            if any(abs(dff-df)>eps(df)*1000)
                warning('SamplingProp:FrequencyVectorSetInaccurate',...
                        'Setting the frequency vector may be inaccurate');
            end
            obj.N_ = numel(value); % N can be estimated very accurately => force
            obj.df = df; % df might be less accurate
        end
        function set.w(obj,value)
            obj.f = value*2*pi;
        end
        
        % convenience aliased properties
        function value = get.Ts(obj)
            value = obj.dt;
        end
        function value = get.Tmeas(obj)
            value = obj.Tm;
        end

        function set.Ts(obj,value)
            obj.dt = value;
        end
        function set.Tmeas(obj,value)
            obj.Tm = value;
        end
    end
    
    %% basic getters/ setters
    methods
        function set.Ts_(obj,val)
            assert(val>=0||~isfinite(val),'SamplingProp:NegativeSamplingTime','Ts=%g cannot be negative',val);
            obj.lastProperty_ = 'Ts';
            obj.Ts__ = val;
        end
        function set.N_(obj,val)
            intTolerance = 1e-3;
            if any(abs(round(val)-val)>eps(val)./intTolerance)
                roundVal = round(val);
                warning('SamplingProp:SetNToNonInteger',...
                        'Rounding N=%g to %d',val,roundVal);
                val = roundVal;
            end
            assert(val>=0||~isfinite(val),'SamplingProp:NegativeNumberOfSamples','N=%g must be a positive integer',val);
            obj.lastProperty_ = 'N'; 
            obj.N__ = val;
        end
        
        function value = get.Ts_(obj)
            value = obj.Ts__;
        end
        function value = get.N_(obj)
            value = obj.N__;
        end
        function value = get.lastProperty(obj)
            value = obj.lastProperty_;
        end
    end
    %% code generatable
    methods
        function [str, sts] = gencode_rvalue(obj)
            sts = true;
            switch obj.lastProperty
                case 'N'
                    vals = {'Ts', obj.Ts, 'N', obj.N};
                case 'Ts'
                    vals = {'N', obj.N, 'Ts', obj.Ts};
                otherwise
                    sts = false;
                    str = {''};
                    return
            end
            format = '%s(''%s'', %d, ''%s'', %g)';
            str = {sprintf(format, class(obj), vals{:})};
        end
    end
    %% protected methods
    methods(Access=protected)
        function str = describe_(obj)
            ts = time(obj.dt);
            fs = bw(obj.fs);
            Tmeas = time(obj.Tm);
            BW = bw(obj.fs/2);
            df = bw(obj.df);
            str = sprintf(['%s\n'...
                           ' - N  = %d samples\n'....
                           ' - Tm = %s measurement time\n'...
                           ' - dt = %s time step\n'...
                           ' - fs = %s sampling frequency\n'...
                           ' - df = %s frequency resolution\n'...
                           ' - bw = %s bandwidth\n'],...
                          class(obj), obj.N_, Tmeas, ts, fs, df, BW);
            function str=time(val)
                str = sprintf('%g s',val);
            end
            function str=bw(val)
                str = sprintf('%g Hz',val);
            end
        end
    end
    
    %% private methods
    methods
        function f = alias(obj,f,fNyquist)
            if ~exist('fNyquist','var') || isempty(fNyquist)
                fNyquist = obj.fs/2;
            end
            if ~exist('f','var')
                f = obj.f;
            end
            f = mod(f+fNyquist, 2*fNyquist) - fNyquist;
        end
    end
end
