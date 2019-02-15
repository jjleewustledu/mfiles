% CONVERTF
%
% Usage:    Fout = convertF2(Fin, intag, outtag, cfun)
%
%           Fin:      double matlab column vector, not compacted;
%                     only internal least-squares calculations are compacted
%           intag:   'laifF' default, 'mlemF', 'mlemRefCbf', 'butCbf'
%           outtag:  'laifF', 'mlemF', 'mlemRefCbf', 'butCbf' default,
%                    'original', 'compact'
%           cfun:     when present, will override any internal cfit objects
%           petCbf:   Butanol-corrected PET CBF to use the gold-standard
%           extraTag: boolean matlab column vector of vector elements from
%                     Fin, petCbf to keep for processing
%           matfil:   mat-file with absolute path
%
%           [cfun, gof, fitout] <- fit is used to make conversions from 
%           Fin to Fout.
%__________________________________________________________________________

function Fout = convertF2(Fin, intag, outtag, cfun, petCbf, extraTag, matfil)

HOME  = '/home/jjlee/';
Ecfun = 1;

switch (nargin)
    case 1 
        intag    = 'original';
        outtag   = 'original';
        Ecfun    =  0;
        petCbf   =  0;
        extraTag =  0;
        matfil   = [HOME '2007dec10.mat'];
    case 2
        outtag   = 'butCbf';
        Ecfun    =  0;
        petCbf   =  0;
        extraTag =  0;
        matfil   = [HOME '2007dec10.mat'];
    case 3
        Ecfun    =  0;
        petCbf   =  0;
        extraTag =  0;
        matfil   = [HOME '2007dec10.mat'];
    case 4
        petCbf   =  0;
        extraTag =  0;
        matfil   = [HOME '2007dec10.mat'];
    case 5
        extraTag = 0;
        matfil   = [HOME '2007dec10.mat'];
    case 6
        matfil   = [HOME '2007dec10.mat'];
    case 7
    otherwise
        error(help('convertF'));        
end

if (~petCbf)   
    load(matfil)     %%% /home/jjlee/2007oct22 worked previously
    petCbf = butCbf; %%% typical
end 

if (~extraTag)
    load([HOME 'extra_tag.mat'])
    extraTag = extra_tag; %%% typical
end

info  = peekInfo('allrois', 'ho1', 'both', 1, 0);
disp(['convertF:  size(info)      -> ' num2str(size(info))]);
disp(['convertF:  numel(petCbf)   -> ' num2str(numel(petCbf))]);
disp(['convertF:  numel(extraTag) -> ' num2str(numel(extraTag))]);
all   = petCbf > eps & extraTag; % most selective filter for all imaging data, typically 'ho1'
disp(['convertF:  numel(all)      -> ' num2str(numel(all))]);
disp(['convertF:  numel(Fin)      -> ' num2str(numel(Fin))]);
x_all = compactArray(petCbf, all);
y_all = compactArray(Fin,    all);
disp(['convertF:  numel(x_all)    -> ' num2str(numel(x_all))]);
disp(['convertF:  numel(y_all)    -> ' num2str(numel(y_all))]);

if (~Ecfun)
    [cfun, gof, fitout] = fit(x_all, y_all, 'poly1'); 
end

switch (intag)
    case {'Fin', 'bayesF', 'laifF'}
    case 'mlemF'
    case 'mlemRefCbf'
    case {'butCbf', 'petCbf'}
    case 'original'
        Fout = Fin;
        return;
    case 'compact'
        Fout = y_all;
        return;
    otherwise
        error(['convertF:  unrecognizable intag -> ' intag]);
end

switch (outtag)
    case {'Fin', 'laifF', 'bayesF'}
        error('not yet implemented');
    case 'mlemF'
        error('not yet implemented');
    case 'mlemRefCbf'
        error('not yet implemented');
    case {'butCbf', 'petCbf'};
    case 'original'
    otherwise
        error(['convertF:  unrecognizable outtag -> ' outtag]);
end

%%%%%%%%%%%%% USE LINEAR LEAST SQUARES FIT FOR CONVERSIONS %%%%%%%%%%%%%

Fout = (Fin - cfun.p2*ones(size(Fin,1),1))./cfun.p1;
return;



