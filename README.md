# image-processor

https://github.com/cadensanders49/image-processor

Spatial Domain
-

- [x] Brightness
- [x] Contrast
- [x] 3x3 Lowpass
- [x] 5x5 Lowpass
- [x] 7x7 Lowpass
- [x] 9x9 Lowpass
- [x] Edge Detect Highpass
- [x] Highboost
- [x] Global Histogram Equalization
- [x] Adaptive Histogram Equalization


Frequency Domain
-

- [x] Lowpass - Ideal
- [x] Lowpass - Gaussian
- [x] Lowpass - Butterworth
- [x] Highpass - Ideal
- [x] Highpass - Gaussian
- [x] Highpass - Butterworth
- [ ] Highboost
- [x] Band Pass - Ideal
- [x] Band Pass - Gaussian
- [ ] Band Pass - Butterworth
- [x] Band Stop - Ideal
- [x] Band Stop - Gaussian
- [ ] Band Stop - Butterworth

Morphological Filters
- [x] Binary Mask - RGB
- [x] Binary Mask - HSV
- [x] Erosion
- [x] Dilation
- [x] Opening
- [x] Closing
- [x] Boundary (Beta)
- [x] Object Identification


HOW TO RUN THE PROGRAM

-IMPORTANT!
Please make sure that you have the following toolboxes installed
with your version of MatLab:
  -Image Processing Toolbox (https://www.mathworks.com/products/image.html)
Please make sure that you have the following files in the root folder for
the GitHub clone:
  -butterworth_high_center_f.m
  -butterworth_low_center_f.m
  -distance_from_center.m
  -ffilter.m
  -fft2_centered.m
  -gaussian_high_center_f.m
  -gaussian_low_center_f.m
  -homomorphic_gamma.m
  -ideal_bandpass_centered_freq.m
  -ideal_bandstop_centered_freq.m
  -ideal_highpass_centered_freq.m
  -ideal_lowpass_centered_freq.m
  -project2.mlapp

Option 1
-Run 'project2' in MatLab while in the root folder of the GitHub clone

Option 2
-Double click "Image Processor.mlappinstall"
-Open Image Processor from the Apps tab inside of Matlab

Special Thanks!
Dr. Bill Stapleton for providing some amazing MatLab code and guiding
the development efforts by teaching the image processing methods.
