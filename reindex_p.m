function p1 = reindex_p(pids, p)

p1 = p;
for k = 1:length(pids)
    p1.(pids{k}).sliceidx = p.(pids{k}).sliceidx + 1;
    sidx                  = p1.(pids{k}).sliceidx;
    slicefield            = ['slice' num2str(sidx)];
    p1.(pids{k}).(slicefield).qcbf = p.(pids{k}).qcbf_101010.img(:,:,sidx);
    p1.(pids{k}).(slicefield).pcbf = p.(pids{k}).pcbf_101010.img(:,:,sidx);
    p1.(pids{k}).(slicefield).pcbv = p.(pids{k}).pcbv_101010.img(:,:,sidx);
    p1.(pids{k}).(slicefield).qcbv = p.(pids{k}).qcbv_101010.img(:,:,sidx);
end
