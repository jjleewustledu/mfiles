function pth = impath(imobj)
%% IMPATH returns the path to any image-object supported by imcast;
%  if imobj is a string, then pth is the path returned by filepartsx( , NIfTId.FILETYPE_EXT);
%  if imobj is a string with any wildcard location, e.g., 'location*', then pth is the truncated path without wildcards

pth = '';
try
    if (~ischar(imobj))
        imobj = imcast(imobj, 'fqfilename'); end
    imobj = strtok(imobj, '*');
    pth = filepartsx(imobj, mlfourd.NIfTId.FILETYPE_EXT);
catch ME
    handexcept(ME);
end

end

