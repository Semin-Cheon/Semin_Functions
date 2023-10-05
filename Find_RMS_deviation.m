% Find RMS deviation
% 
% load('classified_atom_types.mat')
% load('classified_atom_coordinates.mat')
% 
% load('semin_standard_coordinates.mat')
% load('semin_standard_angle.mat')
% 
% K_type = new_atomtype;

semin_coord = Ground_truth_Coordinates(:,1:3)';

new_model = atom_pos;
semin_coord = atomcoordinates;
new_model = Modified_atom_coordinates;
% xcm = sum(new_model(1,:))/size(new_model,2);
% ycm = sum(new_model(2,:))/size(new_model,2);
% zcm = sum(new_model(3,:))/size(new_model,2);
% 
% CM = [xcm;ycm;zcm];
% new_model = new_model - CM; % moves particle's center to origin 

new_model = new_model/24;
K = new_model;

figure(1);
h = scatter3(semin_coord(1,:),semin_coord(2,:),semin_coord(3,:),'filled','MarkerEdgeColor',[0 0 0],'SizeData',20);
title("Ground truth")
xlabel("nm")
ylabel("nm")
zlabel("nm")

figure(2);
h = scatter3(new_model(1,:),new_model(2,:),new_model(3,:),'filled','MarkerEdgeColor',[0 0 0],'SizeData',20);
title("Traced coordinates")
xlabel("nm")
ylabel("nm")
zlabel("nm")

[a, b, c]=find_matchind_twomodels_new(semin_coord,new_model,0.5);

A1 = new_model(1,b);
A2 = new_model(2,b);
A3 = new_model(3,b);
% At = new_atomtype(1,b);

A(1,:) = A1;
A(2,:) = A2;
A(3,:) = A3;

B1 = semin_coord(1,a);
B2 = semin_coord(2,a);
B3 = semin_coord(3,a);
% Bt = semin_type(1,a);

B(1,:) = B1;
B(2,:) = B2;
B(3,:) = B3;

 figure(4);
 scatter3(A(1,:),A(2,:),A(3,:),'filled','MarkerEdgeColor',[0 0 0])
 title('Classified coordinates')
%  xlim([-11 11])
%  ylim([-11 11])
%  zlim([-11 11])
 
 figure(5);
 scatter3(B(1,:),B(2,:),B(3,:),'filled','MarkerEdgeColor',[0 0 0])
 title('Original coordinates')
 

 SD = ((B - A).^2);
 SD = sum(SD,1);
 MSD = sum(SD,2)/size(A,2);
 RMSD = sqrt(MSD);
 dev = RMSD ; % unit: Anstrom
 dev = dev*10^2 ; % in pico meter

 
 
 fprintf('\n Yo bro, the RMS deviation is %2.2f pm \n',dev)
 
 a = find(At==2);
 aa = find(At==1);
 
 b = find(Bt==2);
 
 
 AA = Bt - At;
 
  length(find(AA==0))
%  length(find(AA==0)) - length(a)

 %%
%  scatter3(semin_coord(1,:),semin_coord(2,:),semin_coord(3,:),'filled','MarkerEdgeColor',[0 0 0])

