function im = scrubNaNs(im, ~)

if (~isnumeric(im))
    error('mfiles:unspecifiedError', ...
          ['oops...  scrubNaNs could not recognized class of inimage -> ' class(im)]);
end
im(isnan(im)) = 0;
