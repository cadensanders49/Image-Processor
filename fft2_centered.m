function [spectrum]=fft2_centered(picture)
[height width]=size(picture);
picture2=zeros(height,width);
for x=1:height
   for y=1:width
      picture2(x,y)=picture(x,y)*((-1)^(x+y));
   end
end
spectrum=fft2(picture2);
