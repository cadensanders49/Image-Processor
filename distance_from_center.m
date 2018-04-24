function [distance]=distance_from_center(max_rows,max_columns)
%[distance]=distance_from_center(max_rows,max_columns)
%creates a 2-dimensional array of size max_rows by max_columns 
%whose elements are the euclidean distances from the center coordinates.
distance=zeros(max_rows,max_columns);
center_row=fix(max_rows/2+.5);
center_column=fix(max_columns/2+.5);

for row=1:max_rows
   for column=1:max_columns
      distance(row,column)=sqrt((row-center_row).^2+(column-center_column).^2);
   end
end
