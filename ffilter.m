function [varargout]=ffilter(varargin)
%[varargout]=ffilter(varargin)
%Frequency Domain Image Filtering
%call ffilter() with no arguments to see a complete list of options
%

if nargin < 4
    disp('Usage: [varargout]=ffilter(varargin)');
    disp(' ');
    disp('There will be from 4-6 input arguments.');
    disp('The input arguments are as follows:');
    disp('The first argument is the image to be filtered.');
    disp('The second argument is the class of filter.');
    disp('    Acceptable filter classes are: ');
    disp('    ''Lowpass'', ''Highpass'', ''Bandpass'', ''Bandstop''');
    disp('The third argument is the type of filter.');
    disp('    Acceptable types are: ');
    disp('    ''Ideal'', ''Butterworth'', ''Gaussian''');
    disp('The fourth argument is the cutoff frequency (radius)');
    disp('of the filter for Lowpass and Highpass.');
    disp('For Bandpass and Bandstop, the fourth and fifth arguments');
    disp('are the lower and upper cutoff frequencies.');
    disp('For Butterworth filters, the final (fifth or sixth) argument,');
    disp('specified after the cutoff frequencies, is the order of the filter.');
    disp(' ');
    disp('There will be from 1-2 output arguments.');
    disp('The output arguments will be as follows:');
    disp('The first output argument will be the filtered image.');
    disp('The returned image will be cast to the same type as the input image.');
    disp('If a second argument is specified, the filter will be returned.');
    disp('The filter will always be of type ''double''.');
    return;
end

if size(varargin{1},3)==1
    original_image=varargin{1};
elseif size(varargin{1},3)==3
    disp('Warning, current filters are only defined for grayscale images.');
    disp('Converting to grayscale');
    original_image=rgb2gray(varargin{1});
elseif ischar(varargin{1})
    disp('Attempting to open ',varargin{1},' as image file');
    original_image=open_image(varargin{1});
else
    disp('Do not know how to handle ',varargin{1},' as image');
    return
end
working_image=im2double(original_image);
working_spectrum=fft2_centered(working_image);


filter_class=varargin{2};
if ~ischar(filter_class)
    disp('The second argument must be a string specifying the filter class');
    return
end
if ~strcmpi(filter_class,'Lowpass') & ~strcmpi(filter_class,'Highpass') & ~strcmpi(filter_class,'Bandpass') & ~strcmpi(filter_class,'Bandstop')
    disp('Filter class must be specified using one of the following:');
    disp('''Lowpass'', ''Highpass'', ''Bandpass'', ''Bandstop''');
    return
end

filter_type=varargin{3};
if ~ischar(filter_type)
    disp('The third argument must be a string specifying the filter type');
    return
end
if ~strcmpi(filter_type,'Ideal') & ~strcmpi(filter_type,'Butterworth') & ~strcmpi(filter_type,'Gaussian') 
    disp('Filter type must be specified using one of the following:');
    disp('''Ideal'', ''Butterworth'', ''Gaussian''');
    return
end

radius1=varargin{4};
if ~isa(radius1,'numeric');
    disp('The fourth argument must be a numeric specifying the filter radius');
    return
end

if strcmpi(filter_class,'Bandpass') | strcmpi(filter_class,'Bandstop')
    if nargin >=5
        radius2=varargin{5};
    else
        disp('For filters of class ',filter_class, 'a fifth argument must be specified.');
        return
    end
    if ~isa(radius2,'numeric');
        disp('The fifth argument must be a numeric specifying the filter radius');
        return
    end
    inner_radius=min(radius1,radius2);
    outer_radius=max(radius1,radius2);
end

if strcmpi(filter_type,'Butterworth')
    if strcmpi(filter_class,'Lowpass') | strcmpi(filter_class,'Highpass')
        if nargin >=5
            filter_order=varargin{5};
        else
            disp('For filters of type ',filter_type, 'a fifth argument must be specified.');
            return
        end
        if ~isa(filter_order,'numeric');
            disp('The fifth argument must be a numeric specifying the filter order');
            return
        end
    end
    if strcmpi(filter_class,'Bandpass') | strcmpi(filter_class,'Bandstop')
        if nargin >=6
            filter_order=varargin{6};
        else
            disp('For filters of type ',filter_type, 'a sixth argument must be specified.');
            return
        end
        if ~isa(filter_order,'numeric');
            disp('The sixth argument must be a numeric specifying the filter order');
            return
        end
    end
end

[height width]=size(working_spectrum);
filter=ones([height width]); %creates filter template
lowpass_filter=filter;
highpass_filter=filter;
bandpass_filter=filter;
bandstop_filter=filter;

center_height=fix(height/2+.5);
center_width=fix(width/2+.5);

if strcmpi(filter_type,'Ideal') 
    if strcmpi(filter_class,'Lowpass') | strcmpi(filter_class,'Highpass')
        for x=1:height
            for y=1:width
                if D(x,y,center_height,center_width) <= radius1
                    lowpass_filter(x,y)=1;    
                else
                    lowpass_filter(x,y)=0;
                end
            end
        end
    else
        for x=1:height
            for y=1:width
                if D(x,y,center_height,center_width) >= inner_radius & D(x,y,center_height,center_width) <= outer_radius
                    bandpass_filter(x,y)=1;  
                else
                    bandpass_filter(x,y)=0;
                end
            end
        end
    end
end

if strcmpi(filter_type,'Gaussian') 
    if strcmpi(filter_class,'Lowpass') | strcmpi(filter_class,'Highpass')
        for x=1:height
            for y=1:width
                lowpass_filter(x,y)=exp(-1*(D(x,y,center_height,center_width).^2)/(2*(radius1.^2)));
            end
        end
    else
        for x=1:height
            for y=1:width
                    bandpass_filter(x,y)=(1-exp(-1*(D(x,y,center_height,center_width).^2)/(2*(inner_radius.^2))))*exp(-1*(D(x,y,center_height,center_width).^2)/(2*(outer_radius.^2)));
            end
        end
    end
end

if strcmpi(filter_type,'Butterworth') 
    if strcmpi(filter_class,'Lowpass') | strcmpi(filter_class,'Highpass')
        for x=1:height
            for y=1:width
                lowpass_filter(x,y)=1/((1+D(x,y,center_height,center_width)/radius1).^(2*filter_order));
            end
        end
    else
        for x=1:height
            for y=1:width
                if D(x,y,center_height,center_width) > 0
                    bandpass_filter(x,y)=(1/((1+inner_radius/D(x,y,center_height,center_width)).^(2*filter_order))).*(1/((1+D(x,y,center_height,center_width)/outer_radius).^(2*filter_order)));
                else
                    bandpass_filter(x,y)=0;
                end
            end
        end
    end
end

if strcmpi(filter_class,'Lowpass')
    filter=lowpass_filter;
elseif strcmpi(filter_class,'Highpass')
    filter=1-lowpass_filter;
elseif strcmpi(filter_class,'Bandpass')
    filter=bandpass_filter;
elseif strcmpi(filter_class,'Bandstop')
    filter=1-bandpass_filter;
else
    disp('Invalid Filter Class ',filter_class);
end

filtered_spectrum=working_spectrum.*filter;
filtered_image=abs(ifft2(filtered_spectrum));
if isa(original_image,'double')
    filtered_image=im2double(filtered_image);
elseif isa(original_image,'uint8')
    filtered_image=im2uint8(filtered_image);
else
    disp('Original image data does not appear to be either double or uint8, returning double');
    filtered_image=im2double(filtered_image);
end

varargout{1}=filtered_image;
if nargout >= 2
    varargout{2}=filter;
end
if nargout > 2
    for x=3:nargout
        varargout{x}=[];
    end
end
%end of function ffilter()

function [distance] = D(x1,y1,x2,y2)
distance=sqrt((x1-x2).^2 + (y1-y2).^2);
return
%end of function D()