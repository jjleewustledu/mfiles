%% SWITCHNUMTYPE
%  Usage: arr1 = switchNumType(arr, cls)
%                                 ^ target numeric type
%         ^                    ^ single, double, dip_image; NB dip_image changes xy-ordering
%                              ^ NIfTI, NiiBrowser classes supported by in-situ type switching
function  arr1 = switchNumType(arr, cls)

    switch(cls)
        case 'single'
            arr1 = single(arr);
        case 'double'
            arr1 = double(arr);
        case 'dip_image'
            arr1 = dip_image(arr);
        case 'struct'
            assert(mlfourd.NIfTI.isNIfTI(arr), 'mlfourd:AssertDataClass', ...
                'switchNumType:  passed param arr was a struct but not NIfTI')
            arr1     = arr;            
            arr1.img = switchNumType(arr.img, cls);
        case 'NiiBrowser'
            arr1 = arr;
            arr1.img = switchNumType(arr.img, cls);
        otherwise
            ME = MException('mlfourd:ParamValueNotSupported', ['switchClass:  could not recognize ' cls]);
            throw(ME);
    end
end
