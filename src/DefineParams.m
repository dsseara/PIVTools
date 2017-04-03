clear 
close all

%% Experiment Parameters
[FileName,PathName] = uigetfile('*.tif');

disp('Reading stack...')
stack = stackread([PathName filesep FileName]);
disp('Done.')

stackdim = size(stack);
if length(stackdim) == 2, stackdim(3) = 1; end

exp.path = PathName;
exp.filename = FileName;
exp.dscl = 0.108;
exp.tscl = 5;
exp.timeind = linspace(0,stackdim(3)-1,stackdim(3));
exp.time = exp.timeind.*exp.tscl;
exp.lastim = 0;
exp.stackdim = stackdim;
exp.cp = [nan,nan];
exp.maxr = (min([stackdim(1),stackdim(2)])-200).*exp.dscl; %um

%% PIV parameters
pivspec.imdist = 1;
pivspec.lastim = exp.lastim;
pivspec.winsize = 32;
pivspec.overlap = 0.5;
pivspec.method = 'single';

% PIV filter specifications
filtspec.snr = 1.01;
filtspec.globfiltstd = 5;
filtspec.locfiltstd = 2.5;
filtspec.kernal = 3;
filtspec.locfiltmeth = 'median';

%% FFT Alignment Parameters
alignspec.winsize = (pivspec.winsize)+1; %default
alignspec.overlap = ((pivspec.winsize)*pivspec.overlap)/alignspec.winsize;
alignspec.st = 2; % default
alignspec.checkpoint = 0; %default
alignspec.mask_method = 1; %Global (val = 1) uses a circle for every window. Local (val = 2) uses a local threshold for each subwindow. (Default = 1)
alignspec.figures = 1; 

%%
save('ExpParams2.mat','exp','pivspec','filtspec','alignspec');