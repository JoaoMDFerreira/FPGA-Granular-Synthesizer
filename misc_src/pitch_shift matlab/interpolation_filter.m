

function y = interpolation_filter(input,fs)
    persistent out;
    if( isempty(out) )
        out = 0;
    end
end