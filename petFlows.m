
%
% Usage:  function [AFlow, BFlow] = petFlows(petpid)
%

function [AFlow, BFlow] = petFlows(petpid)

switch (petpid)

    case 'p5626'
        AFlow = 1.581765E-06;
        BFlow = 2.018616E-02;

    case 'p5696'
        AFlow = 3.408272E-07;
        BFlow = 9.628240E-03;

    case 'p5723'
        AFlow = 1.190157E-06;
        BFlow = 1.957842E-02;

    case 'p5740'
        AFlow = 1.641523E-06;
        BFlow = 2.095705E-02;

    case {'p5743', 'p5761'}
        AFlow = 5.765198E-07;
        BFlow = 1.259033E-02;

    case 'p5760'
        AFlow = 1.240486E-06;
        BFlow = 2.039842E-02;

    case 'p5761'
        AFlow = 5.765198E-07;
        BFlow = 1.259033E-02;

    case 'p5771'
        AFlow = 2.174228E-07;
        BFlow = 7.098846E-03;

    case 'p5772'
        AFlow = 8.044958E-07;
        BFlow = 1.456356E-02;

    case 'p5774'
        AFlow = 3.801791E-06;
        BFlow = 3.010154E-02;

    case 'p5777'
        AFlow = 6.373480E-07;
        BFlow = 1.327811E-02;

    case 'p5780'
        AFlow = 8.724937E-07;
        BFlow = 1.579887E-02;

    case 'p5781'
        AFlow = 3.884892E-07;
        BFlow = 1.078306E-02;

    case 'p5784'
        AFlow = 6.479179E-07;
        BFlow = 1.464291E-02;

    case 'p5792'
        AFlow = 1.067071E-06;
        BFlow = 1.687201E-02;

    case 'p5807'
        AFlow = 5.905364E-07;
        BFlow = 1.381557E-02;

    case 'p5842'
        AFlow = 4.796231E-06;
        BFlow = 4.060857E-02;

    case 'p5846'
        AFlow = 9.957485E-07;
        BFlow = 1.561266E-02;

    case 'p5850'
        AFlow = 1.32748E-06;
        BFlow = 1.221511E-02;

    case 'p5856'
        AFlow = 1.195124E-06;
        BFlow = 1.681921E-02;

%     case 'p7153'
%         AFlow = 2.316138E-06;
%         BFlow = 2.224848E-02;
% 
%     case 'p7189'
%         AFlow = 5.775078E-07;
%         BFlow = 1.133556E-02;
% 
%     case 'p7191'
%         AFlow = 1.517983E-06;
%         BFlow = 1.741314E-02;
% 
%     case 'p7194'
%         AFlow = 2.846088E-06;
%         BFlow = 2.630014E-02;

    otherwise
        try
            [AFlow BFlow] = modelFlows(petpid);
        catch ME
            disp(ME);
            warning(['petFlows could not recognize petpid -> ' petpid ';' ...
                     ' returning 0.0']);
            AFlow = 0;
            BFlow = 0;
        end
end

