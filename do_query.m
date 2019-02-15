function do_query(ich, fp_tp1, label_tp1, fp_tp2, label_tp2, label_delta, c)

%% DO_QUERY
%  Usage:  do_query(ich, fp_tp1, label_tp1, fp_tp2, label_tp2, label_delta)
import mlfourd.*;
query = NIfTI.load(fp_tp1); query.label = label_tp1
query2 = NIfTI.load(fp_tp2); query2.label = label_tp2
dquery = query2 - query; dquery.label = label_delta
if (exist('c', 'var'))
    c(query.label) = ich.make_mnr(query)
    c(query2.label) = ich.make_mnr(query2)
    c(dquery.label) = ich.make_mnr(dquery) %#ok<*NOPRT>
else
    ich.make_mnr(query)
    ich.make_mnr(query2)
    ich.make_mnr(dquery)
end

