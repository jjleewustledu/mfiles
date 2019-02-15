function nilio_writeRec(theRec, fqfn)

fid = fopen(fqfn, 'wt');
fprintf(fid, theRec);
fclose(fid);
