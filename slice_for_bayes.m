
function b = slice_for_bayes(theSlice)

root      = [peekDrive() '\perfusion\vc\'];
vcs       = [ 'vc1535'; 'vc1563'; 'vc4103'; 'vc4153'; 'vc4336'; 'vc4354'; 'vc4405'; 'vc4420'; 'vc4426'; 'vc4437'; 'vc4497'; 'vc4500'; 'vc4520'; 'vc4634'; 'vc4903'; 'vc5591'; 'vc5625'; 'vc5647'; 'vc5821' ];
vcs_cells = cellstr(vcs);
disp(['number of vcs = ' num2str(length(vcs_cells))]);

fil2 = '';
for i = 1:length(vcs_cells)
    try
        fil2 = strcat([root, char(vcs_cells(i)), '\data\perfusionVenous_xr3d.4dfp.img']);
        fil3 = strcat([root, 'perfusion_bayes\', char(vcs_cells(i)), '_slice', num2str(theSlice), '.4dfp.img']);
        b = slice_perfusion_data(fil2, fil3, theSlice);
    catch
        try
            fil2 = strcat([root, char(vcs_cells(i)), '\data\', 'perfusionVenousXr3d.4dfp.img']);
            fil3 = strcat([root, 'perfusion_bayes\', char(vcs_cells(i)), '_slice', num2str(theSlice), '.4dfp.img']);
            b = slice_perfusion_data(fil2, fil3, theSlice)
        catch
            try
                fil2 = strcat([root, char(vcs_cells(i)), '\data\perfusion_venous_xr3d.4dfp.img']);
                fil3 = strcat([root, 'perfusion_bayes\', char(vcs_cells(i)), '_slice', num2str(theSlice), '.4dfp.img']);                
                b = slice_perfusion_data(fil2, fil3, theSlice);
            catch
                error(['could not recognize ', fil2, ' nor ', ...
                       root, 'perfusion_bayes\', char(vcs_cells(i)), '_slice', num2str(theSlice), '.4dfp.img nor ', ...
                       num2str(theSlice)]);
            end
        end
    end
end



function c = slice_perfusion_data(filIn, filOut, theSlice)

disp(['filIn   -> ' filIn]); 
disp(['filOut  -> ' filOut]); 
disp(['theSlice -> ' num2str(theSlice)]);

c = read4d(filIn,'ieee-be','single',256,256,8,50,theSlice,1,0)
write4d(c,'single','ieee-be',filOut)

