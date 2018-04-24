function [output]=ideal_lowpass_centered_freq(input,radius)
%[output]=ideal_lowpass_centered_frequency(input,radius)
%input and output are fourier frequency components which have been centered for display
height=size(input,1);
width=size(input,2);
distance=distance_from_center(height,width);

filter=distance <= radius;
output=input.*filter;