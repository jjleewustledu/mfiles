% NIL_MAGIC is a singleton that generates a struct of magic numbers/values
%
% USAGE:  magic = nil_magic without arguments
%
%         magic is a structure that contains various magic
%         numbers/parameters
% 
% SEE ALSO:  aif_select.m
%
% $Author$
% $Date$
% $Revision$
% $Source$

function magic = sonata_magic
  
  magic.aifmean     = 0;
  %%%magic.NumRawBytes = 137216;
  magic.PixelBytes  = 2;
  magic.NumHdrBytes = 0;
  magic.Dim         = 128; % synonym for Dim1
  magic.Dim1        = 128;
  magic.Dim2        = 128;  
  magic.StructImg   = [128,128];
  magic.SliceOffset = 0;
  magic.NumSlices   = 14;
  magic.MaxSlices   = 14;
  magic.TimeOffset  = 0;
  magic.NumTimes    = 50;
  magic.MaxTimes    = 50;
  magic.blTime0     = 1;
  magic.blTimeF     = 4;
  magic.Timestep    = 1;
  magic.RowsMont    = 3;
  magic.ColsMont    = 5;
  magic.DirSep      = '\';
  magic.UnixDirSep  = '/';
  magic.EndianKind  = 'ieee-le';
  magic.HeaderKind  = 'uchar';
  magic.PixelKind   = 'uint16';
  magic.SMALL       = 1.0e-3;
  magic.TINY        = 1.0e-6;
  magic.EPS         = 1.0e-12;
  
  