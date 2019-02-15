%PERFUSIONVENOUSFILENAME
%
%  USAGE:  [aFilename] = perfusionVenousFilename(idx)
%
%          idx is an integer index
%          idx in range returns a string for the PID
%          idx < 1 returns a cell array of strings in a row for all the PIDs
%          idx > length of PIDs returns the last PID from 
%                the internal cell array
%          idx may also be a string constant, e.g., 'vc1535', for which
%                pidList returns an integer index
%
%  SYNOPSIS:
%
%  SEE ALSO:  'strings', 'Cell Arrays of Strings' & 'strings, cells arrays of' in Matlab help.
%
%  N.B.:
%
%  S = [S1 S2 ...] concatenates character arrays
%  S = strcat(S1, S2, ...) concatenates strings or cell arrays of strings
%  You can convert between character array and cell array of strings using char and cellstr.   
%  ischar(S) tells if S is a string variable. iscellstr(S) tells if S is a
%  cell array of strings.
%
%  $Id$
%________________________________________________________________________
function aFilename = perfusionVenousFilename(idx)

    filenames = 	{
            'perfusionVenous_xr3d'  ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'ep2d_perf_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusion_venous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusion_venous_xr3d' ...
            'perfusion_venous_xr3d' ...
            'perfusion_venous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusionVenous_xr3d' ...
            'perfusion_venous_xr3d' ...
            'perfusionVenous_xr3d'
        }; % cell array of strings in a row
    switch (nargin)
        case 1
            [pid idx] = ensurePid(idx, 'np287');
        otherwise
            error('NIL:perfusionVenousFilename:FunctionArgErr:tooManyArgs', ...
                help('perfusionVenousFilename'));
    end

    len = size(filenames, 2);
    if (idx < 1)
        aFilename = filenames;          
    elseif (idx > len)    
        aFilename = [filenames{len} '.4dfp.img'];
    else
        aFilename = [filenames{idx} '.4dfp.img'];
    end



