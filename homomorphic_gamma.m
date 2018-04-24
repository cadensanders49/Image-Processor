function [output]=homomorphic(input,radius,gammal,gammah)
image=im2double(input);
spectrum=fft2_centered(image);
[height width]=size(image);
filter=zeros([height width]);
center_height=fix(height/2+.5);
center_width=fix(width/2+.5);
gaussian=ones(height,width);
for x=1:height
   for y=1:width
      D= sqrt((x-center_height).^2+(y-center_width).^2) ;
      gaussian(x,y)=1-exp(-1*(D.^2)/(2*(radius.^2)));
   end
end
filter=((gammah-gammal)*gaussian)+gammal;
%filter=gaussian;
spectrum2=filter.*spectrum;
image2=abs(ifft2(spectrum2));
if max(max(image2))>1.0
    image2=image2/max(max(image2));
end
output=image2;
