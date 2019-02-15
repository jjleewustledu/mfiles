%% QOEF
%  Usage:  qstruct = qoef(pnum, useFilter)
%          ^              ^    ^
%          data      string    boolean, default true
%          struct
% ___________________________________________
% From: Xiang He [mailto:xiang@mri.wustl.edu]
% Sent: Wednesday, April 15, 2009 4:33 PM
% To: Lee, John
% Subject: Re: MoyaMoya patient OEF qBOLD result
% 
% Hi, John,
% 
% After read in the Matlab data, the OEF map can be created by:
% 
% for i=1:5 for j=1:5 filter(i,j)=exp(-((i-3)^2+(j-3)^2)/4); end; end
% filter=filter/sum(filter(:));
% for s=1:32 oef(:,:,s)= conv2(map_delta_w(:,:,s)*7.4*40,filter,'same'); end
% 
% t2 weighted GESSE image is:
% 
% t2_w=abs(data(:,:,24*12+(1:24)));
% 
% DBV map (deoxygenated CBV) can be created by:
% for i=1:5 for j=1:5 filter(i,j)=exp(-((i-3)^2+(j-3)^2)/4); end; end
% filter=filter/sum(filter(:));
% for s=1:32 dbv(:,:,s)= conv2(map_cs(:,:,s)*100,filter,'same'); end
% 
% Let me know if you find something unexpected.
% 
% Xiang

function qstruct = qoef(pnum, useFilter)
	
	FILTER_BAND = 5;
	MAGIC12     = 12;
	MAGIC74     = 7.4*40;
	MAGIC100    = 100;
    
    if (nargin < 2); useFilter = true; end
	db      = mlfsl.ImagingComponent(pnum);
	qstruct = load([db.npnumPath '/qBOLD_reprocessed/' pnum '_OEF_long.mat']);
	nslices = size(qstruct.map_delta_w, 3);
	
    % define filter
	qstruct.filter = ones(FILTER_BAND, FILTER_BAND);
    if (useFilter)
        mid = ceil(FILTER_BAND/2);
        for i = 1:FILTER_BAND
            for j = 1:FILTER_BAND 
                qstruct.filter(i,j) = exp(-((i-mid)^2+(j-mid)^2)/4); 
            end
        end
        qstruct.filter = qstruct.filter/sum(qstruct.filter(:));
    end
	
    % make oef	
    if (useFilter)
        qstruct.oef = zeros(size(qstruct.map_delta_w));
        for s = 1:nslices
            qstruct.oef(:,:,s) = conv2(qstruct.map_delta_w(:,:,s)*MAGIC74, ...
                                       qstruct.filter, 'same'); 
        end
    else
        qstruct.oef = qstruct.map_delta_w*MAGIC74;
    end
	 
	qstruct.t2_w = abs(qstruct.data_han(:,:,nslices*MAGIC12+(1:nslices)));
	
    % make dbv 
    if (useFilter)
        qstruct.dbv = zeros(size(qstruct.map_cs));
        for s = 1:nslices 
            qstruct.dbv(:,:,s) = conv2(qstruct.map_cs(:,:,s)*MAGIC100, ...
                                       qstruct.filter, 'same'); 
        end
    else
        qstruct.dbv = qstruct.map_cs*MAGIC100;
    end
	
end % function qoef