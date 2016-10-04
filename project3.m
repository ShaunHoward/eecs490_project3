% EECS 490 Project 3: Edges
% author: Shaun Howard (smh150@case.edu)

%% 1.a. perform gradient operation on IMAGE1
IMAGE1 = imread('pics/IMAGE1.tif');
img1_gradient = gradient(IMAGE1);

%% 1.b. apply laplacian operation to IMAGE1
H = fspecial('laplacian');
% apply laplacian filter. 
img1_laplace = imfilter(IMAGE1,H);

%% 1.c. locate the edges in both images using thresholding for (a) and
% zero-crossing detection for (b)

% thresholding for (a)
% graythresh	Global image threshold using Otsu's method
img1_grad_thresh = graythresh(img1_gradient);

% zero-crossing detection for (b)
zx_thresh = 0.5;
img1_laplace_zeroxdetect = edge(img1_laplace,'zerocross',zx_thresh);

%% display results for parts 1 a. - c.
margins=[0 0];
figure('name', 'Gradiant and Laplacian with Thresholding and Zero-Crossing');
subplot_tight(2,2,1,margins);
imshow(img1_gradient);
subplot_tight(2,2,2,margins);
imshow(img1_laplace);
subplot_tight(2,2,3,margins);
imshow(img1_grad_thresh);
subplot_tight(2,2,4,margins);
imshow(img1_laplace_zeroxdetect);

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
img1_gauss_grad_thresh = graythresh(img1_gauss_gradient);

% zero-crossing detection for (d.b)
zx_thresh = 0.5;
img1_gauss_laplace_zeroxdetect = edge(img1_guass_laplace,'zerocross',zx_thresh);

%% display results for parts 1 d.a. - d.c.
margins=[0 0];
figure('name', 'Gradiant and Laplacian with Thresholding and Zero-Crossing on Filtered Images');
subplot_tight(2,2,1,margins);
imshow(img1_gauss_gradient);
subplot_tight(2,2,2,margins);
imshow(img1_gauss_laplace);
subplot_tight(2,2,3,margins);
imshow(img1_gauss_grad_thresh);
subplot_tight(2,2,4,margins);
imshow(img1_gauss_laplace_zeroxdetect);

%% 2. Process the Lena (IMAGE2) and Dart (IMAGE3) images using the following
% operators:
IMAGE2 = imread('pics/Lena.tif');
IMAGE3 = imread('pics/IMAGE3.tif');

% 2.a. |Gx| + |Gy|, the x- and y-directed gradient operations
[img2_grad_x,img2_grad_y] = gradient(IMAGE2);
[img3_grad_x,img3_grad_y] = gradient(IMAGE3);

% 2.b. X and Y-directed Sobel
[img2_sobel_x,img2_sobel_y] = imgradientxy(IMAGE2);
[img3_sobel_x,img3_sobel_y] = imgradientxy(IMAGE3);

%% 3. Use the Canny edge operator to locate the edges in the connecting rod
% image, IMAGE4.
IMAGE4 = imread('pics/IMAGE4.tif');
img4_edges = edge(IMAGE4,'Canny');
figure;
imshow(img4_edges);

%% 4. Using global thresholding segment the objects in the wrench image, 
% IMAGE1, and the letters image, IMAGE5.
img1_thresh = graythresh(IMAGE1);

% convert intensity image to binary image with im2bw
img1_thresh = im2bw(img1_thresh);

% display figure comparison
figure('name', 'Wrenches segmented');
subplot_tight(2,2,1,margins);
imshow(IMAGE1);
subplot_tight(2,2,2,margins);
imshow(img1_thresh);

% read image 5 and threshold
IMAGE5 = imread('pics/IMAGE5.tif');
img5_thresh = graythresh(IMAGE5);

% convert intensity image to binary image with im2bw
img5_thresh = im2bw(img5_thresh);

% display figure comparison
figure('name', 'Characters segmented');
subplot_tight(2,2,1,margins);
imshow(IMAGE5);
subplot_tight(2,2,2,margins);
imshow(img5_thresh);

%% 5. Determine the edges of the cup in image IMAGE7 using any method you 
% wish.  Describe your algorithm.
IMAGE7 = imread('pics/IMAGE7.tif');

% detect edges of cup using Prewitt method
img7_edges = edge(IMAGE7,'Prewitt');
figure('Cup Edges');
imshow(img7_edges);

%% 6. Attempt to duplicate as well as you can the results shown in Figure 
% 10.25 of the textbook.
% load figure 10.25
fig1025 = imread('pics/Fig1025 original.tif');
% 6.a. scale original image to range [0,1]
fig1025_scaled = (Im - min(fig1025(:))) / (max(fig1025(:)) - min(fig1025(:)));

% 6.b. Smooth image
fig1025_gauss = imgaussfilt(fig1025, 'FilterSize', [3 3]);
% perform gradient operation on Gauss filtered image
fig1025_gauss_gradient = gradient(fig1025_gauss);
% threshold gradient of smoothed image
fig1025_gauss_grad_thresh = graythresh(fig1025_gauss_gradient);

% 6.c Apply Marr-Hildreth algorithm
% detect edges using the Laplacian of Gaussian ('log') method
fig1025_edges = edge(fig1025,'log');

% 6.d. Apply Canny algorithm with Tl=0.04, TH=0.1, sigma=4, mask=25x25
fig1025_canny_edges = edge(fig1025,'Canny',[0.04 0.1],4);

%% display fig1025 results
figure('Figure 10.25 Replication');
subplot_tight(2,2,1,margins);
imshow(fig1025_scaled);
subplot_tight(2,2,2,margins);
imshow(fig1025_gauss_grad_thresh);
subplot_tight(2,2,3,margins);
imshow(fig1025_edges);
subplot_tight(2,2,4,margins);
imshow(fig1025_canny_edges);

