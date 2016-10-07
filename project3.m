% EECS 490 Project 3: Edges
% author: Shaun Howard (smh150@case.edu)

%% 1.a. perform gradient operation on IMAGE1
% convert image to double for higher precision
IMAGE1 = im2double(imread('pics/IMAGE1.tif'));
img1_gradient = gradient(IMAGE1);

%% 1.b. apply laplacian operation to IMAGE1
H = fspecial('laplacian');
% apply laplacian filter. 
img1_laplace = imfilter(IMAGE1,H);

%% 1.c. locate the edges in both images using thresholding for (a) and
% zero-crossing detection for (b)

% thresholding for (a)
% binarize image using global image threshold with Otsu's method
img1_grad_thresh = imbinarize(img1_gradient, 'global');

% zero-crossing detection with laplacian for (b)
zx_thresh = .6;
img1_laplace_zeroxdetect = edge(IMAGE1,'zerocross',zx_thresh, H);

%% display results for parts 1 a. - c.
margins=[0 0];
figure('name', 'Gradient and Laplacian with Thresholding and Zero-Crossing');
subplot_tight(2,2,1,margins);
imshow(img1_gradient);
subplot_tight(2,2,2,margins);
imshow(img1_laplace);
subplot_tight(2,2,3,margins);
imshow(img1_grad_thresh);
subplot_tight(2,2,4,margins);
imshow(img1_laplace_zeroxdetect);

export_fig('output/figure1_1.bmp');

%% 1.d. Repeat (a) - (c), but apply Gaussian 3x3 filter to image before doing
% anything
img1_gauss = imgaussfilt(IMAGE1, 'FilterSize', [3 3]);
%% 1.d.a. perform gradient operation on Gauss filtered IMAGE1
img1_gauss_gradient = gradient(img1_gauss);
%% 1.d.b. apply laplacian operation to Gauss filtered IMAGE1
img1_gauss_laplace = imfilter(img1_gauss,H);

%% 1.d.c. locate the edges in both images using thresholding for (d.a) and
% zero-crossing detection for (d.b)

% thresholding for (d.a)
% binarize image using global image threshold with Otsu's method
img1_gauss_grad_thresh = imbinarize(img1_gauss_gradient, 'global');

% zero-crossing detection with Laplacian for (d.b)
zx_thresh = .3;
img1_gauss_laplace_zeroxdetect = edge(img1_gauss,'zerocross',zx_thresh, H);

%% display results for parts 1 d.a. - d.c.
margins=[0 0];
figure('name', 'Filtered Gradient and Laplacian with Thresholding and Zero-Crossing');
subplot_tight(2,2,1,margins);
imshow(img1_gauss_gradient);
subplot_tight(2,2,2,margins);
imshow(img1_gauss_laplace);
subplot_tight(2,2,3,margins);
imshow(img1_gauss_grad_thresh);
subplot_tight(2,2,4,margins);
imshow(img1_gauss_laplace_zeroxdetect);

export_fig('output/figure1_2.bmp');
 
%% 2. Process the Lena (IMAGE2) and Dart (IMAGE3) images using the following
% operators:
IMAGE2 = im2double(imread('pics/Lena.tif'));
IMAGE3 = im2double(imread('pics/IMAGE3.tif'));

% 2.a. |Gx| + |Gy|, the x- and y-directed gradient operations
[img2_grad_x,img2_grad_y] = gradient(IMAGE2);
% sum |x| and |y| gradients
img2_grad_sum = abs(img2_grad_x) + abs(img2_grad_y);
[img3_grad_x,img3_grad_y] = gradient(IMAGE3);
% sum x and y gradients
img3_grad_sum = img3_grad_x + img3_grad_y;

% 2.b. X and Y-directed Sobel
[img2_sobel_x,img2_sobel_y] = imgradientxy(IMAGE2);
[img3_sobel_x,img3_sobel_y] = imgradientxy(IMAGE3);

%% display results for parts 2. a. and b. for IMAGE2
margins=[0 0];
figure('name', 'Absolute Gradient Addition and X- and Y-direction Sobel');
subplot_tight(2,2,1,margins);
imshow(IMAGE2);
subplot_tight(2,2,2,margins);
imshow(img2_grad_sum);
subplot_tight(2,2,3,margins);
imshow(img2_sobel_x);
subplot_tight(2,2,4,margins);
imshow(img2_sobel_y);
export_fig('output/figure2_1.bmp');

%% display results for parts 2. a. and b. for IMAGE3
margins=[0 0];
figure('name', 'Absolute Gradient Addition and X- and Y-direction Sobel');
subplot_tight(2,2,1,margins);
imshow(IMAGE3);
subplot_tight(2,2,2,margins);
imshow(img3_grad_sum);
subplot_tight(2,2,3,margins);
imshow(img3_sobel_x);
subplot_tight(2,2,4,margins);
imshow(img3_sobel_y);

export_fig('output/figure2_2.bmp');

%% 3. Use the Canny edge operator to locate the edges in the connecting rod
% image, IMAGE4.
IMAGE4 = imread('pics/IMAGE4.tif');
zx_thresh = [0.25 0.4];
img4_edges = edge(IMAGE4,'Canny', zx_thresh);
figure;
imshow(img4_edges);
export_fig('output/figure3.bmp');

%% 4. Using global thresholding, segment the objects in the wrench image, 
% IMAGE1, and the letters image, IMAGE5.

% binarize image using global image threshold with Otsu's method
img1_thresh = imbinarize(IMAGE1, 'global');

% display figure comparison
figure('name', 'Wrenches segmented');
subplot_tight(2,2,1,margins);
imshow(IMAGE1);
subplot_tight(2,2,2,margins);
imshow(img1_thresh);

export_fig('output/figure4_1.bmp');

% read image 5 and threshold
IMAGE5 = imread('pics/IMAGE5.tif');

% binarize image using global image threshold with Otsu's method
img5_thresh = imbinarize(IMAGE5, 'global');

% display figure comparison
figure('name', 'Characters segmented');
subplot_tight(2,2,1,margins);
imshow(IMAGE5);
subplot_tight(2,2,2,margins);
imshow(img5_thresh);
export_fig('output/figure4_2.bmp');
 

%% 5. Determine the edges of the cup in image IMAGE7 using any method you 
% wish.  Describe your algorithm.
IMAGE7 = imread('pics/IMAGE7.tif');
img7_edges = edge(IMAGE7, 'Canny', [0.18 0.5], 2);

% display cup edges
figure('name', 'Cup Edges');
subplot_tight(2,2,1,margins);
imshow(IMAGE7);
subplot_tight(2,2,2,margins);
imshow(img7_edges);

export_fig('output/figure5.bmp');


%% 6. Attempt to duplicate as well as you can the results shown in Figure 
% 10.25 of the textbook.
% load figure 10.25
fig1025 = im2double(imread('pics/Fig1025 original.tif'));
% 6.a. scale original image to range [0,1]
fig1025_scaled = (fig1025 - min(fig1025(:))) / (max(fig1025(:)) - min(fig1025(:)));

% 6.b. Smooth image
H=fspecial('gauss', 10, 5);
fig1025_gauss = imfilter(fig1025, H);
% perform gradient and threshold operation on Gauss filtered image
fig1025_gauss_grad_thresh = imbinarize(imgradient(fig1025_gauss), 'global');

% 6.c Apply Marr-Hildreth algorithm
% detect edges using the Laplacian of Gaussian ('log') method
% use default values: kernel size = 5x5 and sigma = 0.5
H=fspecial('log', 14, .46);
fig1025_edges = imbinarize(imfilter(fig1025, H));

% 6.d. Apply Canny algorithm, book says Tl=0.04, TH=0.1, sigma=4, mask=25x25
% In matlab, filterLength = 8*ceil(sigma);
% mask with sigma = 4 will be ~24x24, very close to 25x25
fig1025_canny_edges = edge(fig1025,'Canny',[0.07 0.1],4);

%% display fig1025 results
figure('name', 'Figure 10.25 Replication');
subplot_tight(2,2,1,margins);
imshow(fig1025_scaled);
subplot_tight(2,2,2,margins);
imshow(fig1025_gauss_grad_thresh);
subplot_tight(2,2,3,margins);
imshow(fig1025_edges);
subplot_tight(2,2,4,margins);
imshow(fig1025_canny_edges);

export_fig('output/figure6.bmp');
