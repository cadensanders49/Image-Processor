function [output]=ideal_bandpass_centered_freq(input,radius1,radius2)
%[output]=ideal_highpass_centered_frequency(input,radius)
%input and output are fourier frequency components which have been centered for display
height=size(input,1);
width=size(input,2);
distance=distance_from_center(height,width);

inner=min([radius1 radius2]);
outer=max([radius1 radius2]);

filter= (distance >= inner) & (distance <= outer);
output=input.*filter;
