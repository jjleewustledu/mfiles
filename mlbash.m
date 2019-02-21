function [s,r] = mlbash(cmdline, varargin)
    %% MLBASH wraps the bash command line
    %  @param cmdline is the command-line string
    %  @param [param-name, param-value[,...]] may be:
    %          diaryFilename - char
    %          echo - bool
    %          logger - mlpipeline.Logger, which is a handle class
    %  @param echo is logical
    %  @return s is the unix status
    %  @return r is the unix result
    %  @throws 'mfiles:unixException'
    %  See also:  unix, system
    
    %% Version $Revision$ was created $Date$ by $Author$  
    %% and checked into svn repository $URL$ 
    %% Developed on Matlab 7.10.0.499 (R2010a) 
    %% $Id$ 
    
    ip = inputParser; 
    addRequired( ip, 'cmdline',           @ischar);
    addParameter(ip, 'diaryFilename', '', @ischar);
    addParameter(ip, 'logger', [],        @(x) isa(x, 'mlpipeline.Logger'));
    addParameter(ip, 'echo', false,       @islogical);     
    parse(ip, cmdline, varargin{:});    
    s = 0; r = '';
    
    try
        if (~isempty(ip.Results.diaryFilename))
            [s,r] = mlbashDiary(cmdline, ip.Results.diaryFilename);
            if (s ~= 0)
                error('mfiles:ChildProcessError', 'mlbash:\n%s\nreturned s->%i\n%s', cmdline, s, r);
            end
            return
        end
        if (~isempty(ip.Results.logger))
            [s,r] = mlbashLogger(cmdline, ip.Results.logger);
            if (s ~= 0)
                error('mfiles:ChildProcessError', 'mlbash:\n%s\nreturned s->%i\n%s', cmdline, s, r);
            end
            return
        end
        
        if (~ip.Results.echo)
            [s,r] = system(cmdline);
        else
            [s,r] = system(cmdline, '-echo');
        end
        if (s ~= 0)
            error('mfiles:ChildProcessError', 'mlbash:\n%s\nreturned s->%i\n%s', cmdline, s, r);
        end        
        if (mlpipeline.PipelineRegistry.instance.verbose)
            fprintf('mlbash:\n%s\nreturned s->%i\n%s', cmdline, s, r);
        end
    catch ME
        dispexcept(ME, 'mfiles:ChildProcessError', 'mlbash:\n%s\nreturned s->%i\n%s', cmdline, s, r);
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mfiles/mlbash.m] ======  
