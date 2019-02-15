function p = imcast(p, typ)
    %% IMCAST forwards behaviors to mlcaster.CasterContext.
    %  See also:  mlcaster.CasterContext.imcast, mlcaster.CasterContext.
    
    if (~isa(p, typ))
        p = mlcaster.CasterContext.imcast(p, typ); end
    
end
