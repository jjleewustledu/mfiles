%PLOTREGRESSION 
%
%________________________________________________________________________
function plotRegression(polynomOrder, coeffVector, span)


if (1 == polynomOrder)
    hold on
    incr = 1;
    x0   = span(1):incr:span(2);
    y0   = coeffVector(1) + coeffVector(2)*x0;
    plot(x0, y0, '-k', 'LineWidth', 1)
    hold off
    disp(['plotRegression plotted f(x) = ' num2str(coeffVector(1)) ' + ' num2str(coeffVector(2)) ' x']);
end
    

    

