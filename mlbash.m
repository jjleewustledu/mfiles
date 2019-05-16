function [s,r] = mlbash(cmdline, varargin)
    %% MLBASH wraps the bash command line
    %  @param cmdline, required, is the command-line string
    %  @param diaryFilename is char and invokes mlbashDiary
    %  @param logger is an mlpipeline.ILogger, which is a handle and invokes mlbashLogger
    %  @param echo is logical
    %  @return s is the system status
    %  @return r is the system result
    %  @throws 'mfiles:ChildProcessError'
    %  See also:  system
    
    %  Version $Revision$ was created 2010 by jjlee  
    %  and checked into git repository MATLAB-Drive/mfiles.
    %  Developed on Matlab 7.10.0.499 (R2010a) 
    
    ip = inputParser; 
    addRequired( ip, 'cmdline',           @ischar);
    addParameter(ip, 'diaryFilename', '', @ischar);
    addParameter(ip, 'logger', [],        @(x) isa(x, 'mlpipeline.ILogger'));
    addParameter(ip, 'echo', false,       @islogical);     
    parse(ip, cmdline, varargin{:});    
    s = 0; r = '';
    
    try
        if (~isempty(ip.Results.diaryFilename))
            [s,r] = mlbashDiary(cmdline, ip.Results.diaryFilename);
            return
        end
        if (~isempty(ip.Results.logger))
            [s,r] = mlbashLogger(cmdline, ip.Results.logger);
            return
        end
        
        if (~ip.Results.echo)
            [s,r] = system(cmdline);
        else
            [s,r] = system(cmdline, '-echo');
        end
        if (s ~= 0)
            throw(MException('mfiles:ChildProcessError', 'mlbash:\n%s\nreturned s->%i\n%s', cmdline, s, r));
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
