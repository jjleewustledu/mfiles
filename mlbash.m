function [s,r] = mlbash(cmdline, varargin)
    %% MLBASH wraps the bash command line
    %  @param required cmdline is the command-line string
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
        if ~isempty(ip.Results.diaryFilename)
            [s,r] = mlbashDiary(cmdline, ip.Results.diaryFilename);
            return
        end
        if ~isempty(ip.Results.logger)
            [s,r] = mlbashLogger(cmdline, ip.Results.logger);
            return
        end    
        if ip.Results.echo || mlpipeline.PipelineRegistry.instance.verbose
            [s,r] = system(cmdline, '-echo');
        else
            [s,r] = system(cmdline);
        end
        
        if s ~= 0
            fprintf('====================== mlbash failed ======================\n');
            fprintf('cmdline: %s\n', cmdline);
            fprintf('s->%i; r->%s\n', s, r);
        end
    catch ME
        fprintf('====================== mlbash exception ======================\n');
        disp(ME);
        disp(struct2str(ME.stack));
    end
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/Local/src/mfiles/mlbash.m] ======  
