function construct_Ks_patrick(varargin)
%% runs simulated annealing on voxels of FDG from single subject, single session
%  @param optional subject ID, e.g., 'sub-S57920'
%  @param optional session ID, e.g., 'ses-E247428'

ip = inputParser;
addOptional(ip, 'sub', 'sub-S57920', @ischar)
addOptional(ip, 'ses', 'ses-E247428', @ischar)
parse(ip, varargin{:})
ipr = ip.Results;

assert(isunix)
home0 = getenv('HOME');
setenv('HOME', '/home/usr/jjlee')
setenv('SINGULARITY_HOME', '/data/nil-bluearc/raichle/PPGdata/jjlee/Singularity')
setenv('PROJECTS_DIR', getenv('SINGULARITY_HOME'))
setenv('SUBJECTS_DIR', fullfile(getenv('SINGULARITY_HOME'), 'subjects'))
registry = MatlabRegistry.instance(); %#ok<NASGU>

construct_Ks(['subjects' filesep ipr.sub], 1, 'sessionsExpr', ipr.ses, 'useParfor', true, 'assemble', true)

setenv('HOME', home0)
