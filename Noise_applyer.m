%% Load Tilt series

load('128X128_Projections_DFT.mat')
TiltAngles = importdata('128X128_Angles_DFT.mat');
Angles = zeros(length(TiltAngles),3);
Angles(:,2) = TiltAngles'; %Z % Y % X


%% check projections

figure(1);
for i=1:size(Projections,3)
    imagesc(Projections(:,:,i));axis image;colormap(gray);
    title('Noised');
    pause(0.1)
end

figure(2);
for i=1:size(Mproj,3)
    imagesc(Mproj(:,:,i));axis image;colormap(gray);
    title('Denoised');
    pause(0.1)
end

%% Poisson noise
alpha = 0.0001;
Projs = poissrnd(Projs*alpha);

Projs(isnan(Projs)) = 0;

Projs = Projs/alpha;
%% GIF for Poison noise
filename = sprintf('Poisson.gif');
for idx = 1:size(Projs,3)
    % Use getframe to capture image.
    imagesc(Projs(:,:,idx),[0 14000]);axis image;colormap(gray);
    title(sprintf('Poisson noise Angle %f',Angles(idx,2)));
    I = getframe(gcf);
    [indI,cm] = rgb2ind(I.cdata,256);
    % Write frame to the GIF File.
    if idx == 1
        imwrite(indI, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
    else
        imwrite(indI, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
    end
end
save('128X128_Projections_Poisson_1.mat','Projs');
%% Gaussian noise
[s1, s2, s3] = size(Projs);
sigma = 200;
mean = 400;
GN = normrnd(mean,sigma,s1,s2,s3); % Gaussian noise

Projs = Projs + GN;

%% GIF for gaussian noise
load('128X128_Angles_DFT.mat')
filename = sprintf('Test.gif');
for idx = 1:size(Angles,2)
    % Use getframe to capture image.
    imagesc(Projs(:,:,idx));axis image;colormap(gray)
    title(sprintf('Poisson Noise 0.00005 ,Angle %f',Angles(1,idx)));
    
    I = getframe(gcf);
    [indI,cm] = rgb2ind(I.cdata,256);
    % Write frame to the GIF File.
    if idx == 1
        imwrite(indI, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
    else
        imwrite(indI, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
    end
end
%%
save('128X128_Projections_Poisson_0.0001.mat','Projs')