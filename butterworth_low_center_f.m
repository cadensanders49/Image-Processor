function [output]=butterworth_low_center_f(input,radius,order)
%[output]=butterworth_low_center_f(input,radius,order)
%input and output are fourier frequency components which have been centered for display

height=size(input,1);
width=size(input,2);
distance=distance_from_center(height,width);

filter=1./(1+((distance./radius).^(2*order)));
output=input.*filter;



