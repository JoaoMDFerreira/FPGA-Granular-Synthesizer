

function [window] = window_gen(type,length)
    window = zeros(length);
    
    x = linspace(-1,1,length);
    
    switch type
        case 0 %trapezoidal
            window = min(abs(abs(x)*2-2),1);
        otherwise
            window = min(abs(abs(x)*2-2),1);
    end
end

