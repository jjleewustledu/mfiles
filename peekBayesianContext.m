%PEEKBAYESIANCONTEXT
%
% Usage:  theImg = peekBayesianContext('vc4103', 'F', 'mean', datapaths, lens, imgFormat)
%

function theImg = peekBayesianContext(p, metric, pdfMetric, datapaths, lens, imgFormat)

	if ~isnumeric(p), p = pidList(p); end
	if nargin < 6, imgFormat = 'double'; end
	blankImg     = newim(lens(1),lens(2),lens(3),lens(4));
	existsSlice1 = 1;
	existsSlice2 = 1;
	if strcmp('CBV', metric)
	    metric_Int = char([metric '_Int']);
	    metric_INT = char([metric '_INT']);
	end

	theImg = blankImg;

	if strcmp('CBV', metric),
	    metric = metric_Int; end
	fname1 = [datapaths{1} '/' metric '.0001.' pdfMetric '.Ascii'];
	try    
	    bayesSlice1 = read4d(fname1,'ascii','single',lens(1),lens(2),1,1,0,0,0);
	    disp(['peekBayesianContext found ' fname1 ' for slice1(' num2str(p) ')']);
	catch
	    warning(char(['peekBayesianContext could not find ' fname1 ' for slice1(' num2str(p) ')']));
	    existsSlice1 = 0;
	end

	if strcmp('CBV', metric),
	    metric = metric_INT; end
	fname2 = [datapaths{2} '/' metric '.0001.' pdfMetric '.4dfp.img'];
	try
	    bayesSlice2 = read4d(fname2,'ieee-be','single',lens(1),lens(2),1,1,0,0,0);
	    if (p ~= 6) bayesSlice2 = flipx4d(bayesSlice2); end
	    disp(['peekBayesianContext found ' fname2 ' for slice2(' num2str(p) '), but needed to flip the orientation of x']);
	catch
	    disp(['peekBayesianContext could not find ' fname2 ' for slice2(' num2str(p) ')']);
	    existsSlice2 = 0;
	end

	if existsSlice1, theImg(:,:,slice1(p),0) = squeeze(bayesSlice1); end
	if existsSlice2, theImg(:,:,slice2(p),0) = squeeze(bayesSlice2); end

	switch (char(imgFormat))
	    case 'dip'
	    otherwise
	        theImg = double(theImg);
	end
