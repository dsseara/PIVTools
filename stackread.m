function [im,info] = stackread(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program reads in a multiplaned TIFF file
% into a single variable
%
% 11/12/09 Patrick Oakes
% poakes@gmail.com
%
% Updated
% 5/26/16 - Ian Linsmeier
% - Changed function name
% - Compatible with 8,16, & 32-bit images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~exist('filename') || isempty(filename)
    filename = uigetfile({'*.tif';'*.png';'*.jpg';'*.pdf';'*.gif'});
end

info = imfinfo(filename);
dim = size(info);
if dim(1) > dim(2)
    num_planes = dim(1);
else
    num_planes = dim(2);
end
im = zeros(info(1).Height,info(1).Width,num_planes);

for i = 1:num_planes
    im(:,:,i) = imread(filename,i);
end
if double(info(1).BitDepth) == 8
    im=uint8(im);
elseif double(info(1).BitDepth) == 16
    im=uint16(im);
elseif double(info(1).BitDepth) == 32
    im=uint32(im);
end
end