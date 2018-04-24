function [output]=gaussian_low_center_f(input,radius)
%[output]=gaussian_low_center_f(input,radius)
%input and output are fourier frequency components which have been centered for display
height=size(input,1);
width=size(input,2);
distance=distance_from_center(height,width);

filter=exp(-1*(distance.^2)/(2*(radius.^2)));
output=input.*filter;


