function c = myparcluster(varargin)
%% MYPARCLUSTER
%  @param named memUsage is char.
%  @param named wallTime is char.
%  @param named useGpu
%  @param named gpusPerNode

%% Version $Revision$ was created $Date$ by $Author$,  
%% last modified $LastChangedDate$ and checked into repository $URL$,  
%% developed on Matlab 9.3.0.713579 (R2017b).  Copyright 2018 John Joowon Lee. 

ip = inputParser;
addOptional( ip, 'cluster', 'chpc_remote_r2016b', @ischar);
addParameter(ip, 'memUsage', '16000', @ischar);
addParameter(ip, 'wallTime', '47:59:59', @ischar);
addParameter(ip, 'useGpu', false, @islogical);
addParameter(ip, 'gpusPerNode', 0, @isinteger);
parse(ip, varargin{:});

if (hostnameMatch('ophthalmic') || ...
    hostnameMatch('william') || ...
    hostnameMatch('mahler') || ...
    hostnameMatch('pascal'))

    c = parcluster(ip.Results.cluster);    
    ClusterInfo.setEmailAddress(getenv('EMAIL_PRIVATE'));
    ClusterInfo.setMemUsage(   ip.Results.memUsage);
    ClusterInfo.setWallTime(   ip.Results.wallTime);
    ClusterInfo.setUseGpu(     ip.Results.useGpu);
    ClusterInfo.setGpusPerNode(ip.Results.gpusPerNode);
    ClusterInfo.setPrivateKeyFile(fullfile(getenv('HOME'), '.ssh/id_rsa'));
    ClusterInfo.setProcsPerNode(16);
    %  See also http://mgt2.chpc.wustl.edu/wiki119/index.php/MATLAB
else
    error('mfiles:unsupportedHost', 'myparcluster.hostname->%s', hostname);
end

% Created with NEWFCN.m by Frank Gonzalez-Morphy (frank.gonzalez-morphy@mathworks.de) 
% ===== EOF ====== [/Users/jjlee/MATLAB-Drive/mfiles/myparcluster.m] ======  
