function [output]=butterworth_high_center_f(input,radius,order)
%[output]=butterworth_high_center_f(input,radius,order)
%input and output are fourier frequency components which have been centered for display
height=size(input,1);
width=size(input,2);
distance=distance_from_center(height,width);

distance2=distance + eps*(distance==0);
filter=1./(1+(radius./distance).^(2*order));
output=input.*filter;



