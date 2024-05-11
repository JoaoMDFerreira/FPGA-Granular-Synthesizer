%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                          %
%          Generated by MATLAB 9.10 and Fixed-Point Designer 7.2           %
%                                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = window_v4_wrapper_fixpt(CC_attack,CC_release,current,size,in)
    fm = get_fimath();
    CC_attack_in = fi( CC_attack, 0, 7, 0, fm );
    CC_release_in = fi( CC_release, 0, 7, 0, fm );
    current_in = fi( current, 0, 13, 0, fm );
    size_in = fi( size, 0, 13, 0, fm );
    in_in = fi( in, 1, 16, 0, fm );
    [out_out] = window_v4_fixpt( CC_attack_in, CC_release_in, current_in, size_in, in_in );
    out = double( out_out );
end

function fm = get_fimath()
	fm = fimath('RoundingMethod', 'Floor',...
	     'OverflowAction', 'Wrap',...
	     'ProductMode','FullPrecision',...
	     'MaxProductWordLength', 128,...
	     'SumMode','FullPrecision',...
	     'MaxSumWordLength', 128);
end
