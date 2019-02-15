% makeProps generates a prototype of the props property used by the ScatterPublisher class.
%
% Usage: [props] = makeProps(yLbl, ttl, filestm, lgdLbls)
%
%         yLbl:     string for y-axis label
%         ttl:      string for plot title
%         filestm:  string for filename-stem of postscript and diary files
%         lgdLbls:  cell array of strings for labels for the plot legend
%         props:    a prototype of the props property
%
% Examples:
%         aScatterPublisher = mlpublish.ScatterPublisher(...);
%         [props] = aScatterPublisher.makeProps()
%
% Created by John Lee on 2008-06-30.

function [props] = makeProps(yLbl, ttl, filestm, lgdLbls)

YLBL    = 'MR LAIF CBF / Arbitrary';
TTL     = '';
FILESTM = 'proto_mlpublish_ScatterPublisher_props';
LGDLBLS = { 'tissue' 'arteries' 'csf' };
MRKCLRS = { [0 0 0] [.2 0.2 0.2] [0 0.333 1] };
switch (nargin)
    case 0
        yLbl    = YLBL;
        ttl     = TTL;
        filestm = FILESTM;
        lgdLbls = LGDLBLS;
    case 1
        ttl     = TTL;
        filestm = FILESTM;
        lgdLbls = LGDLBLS;
    case 2
        filestm = FILESTM;
        lgdLbls = LGDLBLS;
    case 3
        lgdLbls = LGDLBLS;
    case 4
    otherwise
        error('NIL:mlpublish:ScatterPublisher:makeProps:PassedParamsErr:numberOfParamsUnsupported', ...
            help('mlpublish.ScatterPublisher.makeProps'));
end
assert(ischar(yLbl), ...
    'NIL:mlpublish.ScatterPublisher.makeProps:TypeErr:unrecognizedType', ...
    ['type of yLbl was unexpected: ' class(yLbl)]);
assert(ischar(ttl), ...
    'NIL:mlpublish.ScatterPublisher.makeProps:TypeErr:unrecognizedType', ...
    ['type of ttl was unexpected: ' class(ttl)]);
assert(ischar(filestm), ...
    'NIL:mlpublish.ScatterPublisher.makeProps:TypeErr:unrecognizedType', ...
    ['type of filestm was unexpected: ' class(filestm)]);
assert(iscell(lgdLbls), ...
    'NIL:mlpublish.ScatterPublisher.makeProps:TypeErr:unrecognizedType', ...
    ['type of lgdLbls was unexpected: ' class(lgdLbls)]);
props.pixelSize          = 600;
props.regressLines       = { 'k -' 'k -' 'k -' };
props.confidenceLines    = { 'k--' 'k--' 'k--' };
props.regressionRequests = { 1 0 0 };
props.markers            = {'o' 'o' 'o'};
props.markerArea         = 1;
props.markerColors       = MRKCLRS;
props.lineStyles         = { '-' '-' '-' };
props.lineWidths         = { 1.0 1.0 1.0 };
props.lineColors         = { 'Black' 'Black' 'Black' };
props.anXLabel           = 'Permeability-Corrected H_2[^{15}O] PET CBF / (mL/min/100 g)';
props.aYLabel            = yLbl;
props.gcaFontName        = 'Helvetica';
props.gcaFontSize        = 12;
props.labelFontSize      = props.gcaFontSize;
props.axesFontName       = 'AvantGarde';
props.axesFontSize       = 12;
props.titleFontName      = 'AvantGarde';
props.titleFontSize      = 12;

%  Optional  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

props.dpi                = 1200; % Magn. Res. Med. publication guidelines
props.aTitle             = ttl;
props.filenameStemEps    = filestm;
props.tickLength         = 0.02;
props.axesColor          = [0.05 0.05 0.05];
props.confidenceInterval = 0.95;
if (length(lgdLbls) > 1)
    props.legendLabels  = lgdLbls;
end
props.legendLocation     = 'NorthWest';
props.legendFontSize     = 10;
props.tissLine1          = '-';
props.tissLine2          = '--';
props.printEps           = 1;

end