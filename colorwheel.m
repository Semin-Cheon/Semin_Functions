%% Mapping script with magnitude and angle map
% 
% 2022/02/18 (Y/M/D)
% 
% 
% Author:  Semin Cheon. M.D/Ph.D integrated course. MDAIL(KAIST).
%           chsm0338@kaist.ac.kr
% Function:
%         [mapping] = colorwheel(Magnitude_map, Angle_map)
% 
% Input - Gmag: Magnitude map ( M x N Grid ). This grid give
%       radial displacement to the color wheel.
%       - Gdir: Angle map (Grid size must be equal to "Magnitue map").
%       This grid give information of angular direction to the color wheel.
% 
% Output - mapping: Mapped image which color is assigned corresponding to
% the magnitude and angle from the generated color wheel.
% 
% ※ For th color wheel, i use a matlab code from:
% https://kr.mathworks.com/matlabcentral/answers/442739-how-to-plot-a-smooth-color-wheel
% Author: "Image Analyst" 
%
% #######################################################################
function [mapping] = colorwheel(Gmag, Gdir)

[Nx,Ny] = size(Gmag);
Gmag = abs(Gmag);

%% 1. Parameter setting for Color wheel

outerRadius = ceil(Nx/2);    % outer radius of the colour ring

innerRadius = 0;	% inner radius of the colour ring
numberOfSectors = 256;  % number of colour segments
grayLevel = 20;     % Gray level outside the wheel.

% Get polar coordinates of each point in the domain
[x, y] = meshgrid(-outerRadius : outerRadius);
[theta, rho] = cart2pol(x, y); % theta is an image here.

% Set up color wheel in hsv space.
hueImage = (theta + pi) / (2 * pi);     % Hue is in the range 0 to 1.
hueImage = ceil(hueImage * numberOfSectors) / numberOfSectors;   % Quantize hue 
saturationImage = ones(size(hueImage));      % Saturation (chroma) = 1 to be fully vivid.

% Make it have the wheel shape.
% Make a mask 1 in the wheel, and 0 outside the wheel.
wheelMaskImage = rho >= innerRadius & rho <= outerRadius;
% Hue and Saturation must be zero outside the wheel to get gray.
hueImage(~wheelMaskImage) = 0;
saturationImage(~wheelMaskImage) = 0;
% Value image must be 1 inside the wheel, and the normalized gray level outside the wheel.
normalizedGrayLevel = grayLevel / 255;
valueImage = ones(size(hueImage)); % Initialize to all 1
valueImage(~wheelMaskImage) = normalizedGrayLevel;	% Outside the wheel = the normalized gray level.

hsvImage = cat(3, hueImage, saturationImage, valueImage);
rgb = hsv2rgb(hsvImage);
rgb = fliplr(rgb);

%% 1. Shadowing rgb using inverted Gaussian function
% This part is needed for shading effect of the color wheel.

sigma = (Nx/20)^2;

mu = outerRadius;

X = 0:outerRadius*2;
Y = X;

[mX, mY] = meshgrid(X,Y);
Z = 1 - exp( ( - (mX-mu).^2 -(mY-mu).^2 )/(2*sigma) )*1;
figure();
surf(Z)
view([1,0,0])
title("Shading factor")

rgb = rgb.*Z;
% Display the final color wheel.
figure();
imshow(rgb);
title("Color Wheel")
%% 3. Mapping
% Normalized and rescailing magnitude map to fit the color wheel

minimum_mag = min(Gmag(:));
maximum_mag = max(Gmag(:));

Normalized_magnitude_map = ( Gmag - minimum_mag )/( maximum_mag - minimum_mag );
Normalized_magnitude_map = Normalized_magnitude_map * ceil(Nx/2)*0.9; 

mapped = zeros(Nx,Ny,3);
for i = 1: Nx
    for j = 1: Ny
        xcoord = ceil(-Normalized_magnitude_map(i,j)*sind(Gdir(i,j)) + outerRadius);
        ycoord = ceil(-Normalized_magnitude_map(i,j)*cosd(Gdir(i,j)') + outerRadius);
        mapped(i,j,:) = rgb(ycoord,xcoord,:);
    end
    fprintf("\n Mapping Status: %d th column is done. \n",i)
end
fprintf("\n \n Mapping is done. \n \n")

mapping = mapped;

figure();
image( mapping )
title("Mapped result")
end