% Series maker

% 2021.09.01 (Y.M.D)
% Author: Semin Cheon. Student. MDAIL(KAIST). chsm0338@kaist.ac.kr

% Input: 
%       Target - 2D image with 3D double structure.
%             (1st dim & 2nd dim : image contrast
%                3rd dim : series )   
%       vel : speed of the change of the animation
%       test : trigger whether you plot image histogram or not

% Output: 2D image animation along the 3rd dim of the input data with vel

function Show_2D_Series(Target, vel, trigger, Title)
regulator = 0.8; % 0 ~ 1 for control the contrast of image ( closer to zero, more Contrast)

if exist('title')

if ~exist('vel')
    vel = 0.5;
    if trigger == 0
        
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('%s',Title))
    pause(vel)   
    end
    
    else
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    subplot(1,2,1)
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('%s',Title))
    subplot(1,2,2)
    histogram(Target(:,:,i))
    title('<- intensity histogram of')
    pause(vel)
    end
    
    end
    
else
    
    if trigger == 0
        
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('%s',Title))
    pause(vel)
    end
        
    else
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    subplot(1,2,1)
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('%s',Title))
    subplot(1,2,2)
    histogram(Target(:,:,i))
    title('<- intensity histogram of')
    pause(vel)
    end
    end
end

else
    if ~exist('vel')
    vel = 0.5;
    if trigger == 0
        
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('# = %d',i))
    pause(vel)   
    end
    
    else
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    subplot(1,2,1)
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('# = %d',i))
    subplot(1,2,2)
    histogram(Target(:,:,i))
    title('<- intensity histogram of')
    pause(vel)
    end
    
    end
    
else
    
    if trigger == 0
        
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('# = %d',i))
    pause(vel)
    end
        
    else
    for i = 1:size(Target,3)
    Max = max( max( Target( :, :, i) ) );
    Min = min( min( Target( :, :, i) ) );
    subplot(1,2,1)
    imagesc( Target( :, :, i ) ,[Min*regulator Max*regulator]); colormap(gray)
    title(sprintf('# = %d',i))
    subplot(1,2,2)
    histogram(Target(:,:,i))
    title('<- intensity histogram of')
    pause(vel)
    end
    end
end
    
end

end