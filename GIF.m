%% gif for 3D volume
figure;
h = volshow(Volc,'colormap',colormap,'BackgroundColor',[1 1 1]);

% check(1);
filename = 'Ground_truth.gif';
vec = linspace(0,2*pi,120)';
myPosition = [cos(vec) sin(vec) ones(size(vec))*0.7]*4;
for idx = 1:120
    % Update current view.
    h.CameraPosition = myPosition(idx,:);
    % Use getframe to capture image.
    I = getframe(gcf);
    [indI,cm] = rgb2ind(I.cdata,256);
    % Write frame to the GIF File.
    if idx == 1
        imwrite(indI, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
    else
        imwrite(indI, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
    end
end
%% gif for 3D plot
figure(2);
% h = scatter3(new_model(1,:),new_model(2,:),new_model(3,:),'filled','MarkerEdgeColor',[0 0 0],'SizeData',20);
h = scatter3(atom_pos(1,:),atom_pos(2,:),atom_pos(3,:),'filled','MarkerEdgeColor',[0 0 0],'SizeData',20);
% scatter3(new_model(:,1),new_model(:,2),new_model(:,3),'filled','MarkerEdgeColor',[0 0 0]);
% xlim([14 35]);
% ylim([14 35]);
% zlim([14 35]);
% check(1);
filename = 'Traced_coordinates_15.gif';
% GENFIRE.reconstruction
% vec = linspace(0,2*pi,120);
% vec = 0:360;
vec = linspace(0,360,120);
for idx = 1:length(vec)
    view(vec(1,idx),3)

    I = getframe(gcf);
    [indI,cm] = rgb2ind(I.cdata,256);
    % Write frame to the GIF File.

    if idx == 1
        imwrite(indI, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
    else
        imwrite(indI, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
    end

end
%% Gif for 2D image
figure(3);
filename = 'Particle tracing_ground_truth.gif';
for idx =1:size(curr_model,2)
    curr_pos = round(curr_model(:,idx));
    box_3x3 = RecVol_padded(curr_pos(1)-1:curr_pos(1)+1,curr_pos(2)-1:curr_pos(2)+1,curr_pos(3)-1:curr_pos(3)+1);
    imagesc(sum(box_3x3,3))
    title(sprintf("%.f th atom position",idx))
%     caxis([0 15])
    colorbar
    I = getframe(gcf);
    [indI,cm] = rgb2ind(I.cdata,256);

    % Write frame to the GIF File.
    if idx == 1
        imwrite(indI, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
    else
        imwrite(indI, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
    end
end

%% GIF for 2D Slicing [ V(:,:,:) -> V(:,:,↓) ]
figure(4);
filename = 'Volume_Slice_ground_truth.gif';
for idx = 1 : size(Reconstruction,3)
    imagesc(Reconstruction(:,:,idx))
    title(sprintf("%.f th slice",idx))
    caxis([0 500])
%     colorbar
    I = getframe(gcf);
    [indI,cm] = rgb2ind(I.cdata,256);

    % Write frame to the GIF File.
    if idx == 1
        imwrite(indI, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.2);
    else
        imwrite(indI, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2);
    end
end