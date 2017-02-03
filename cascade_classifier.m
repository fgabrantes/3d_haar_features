

load('classificador.mat')
load('features_2.mat')
cascata=[1, 9, 20, 30, 40]; 

clear features_positive features_negative

features_class=info(classif(:,1),:);

%% Abre dicom
dicom_folder='C:\Users\bouth\Google Drive\Mestrado\ELE205 - Processamento de imagens digitais\Trabalho Final\08 - Banco de dados\DOI';
old_folder=cd(dicom_folder);
lista_pacientes=dir;
paciente=4;
% Acess Dicom folder
cd(strcat('.\', lista_pacientes(paciente+2).name));
for i=1:2
    DOI_folders=dir;
    cd(strcat('.\', DOI_folders(3).name));
end
files=dir;
%Open Dicom
for i=3:length(files)
    info=dicominfo(files(i).name); % Read Dicom info
    img(:,:,info.InstanceNumber)=double(dicomread(files(i).name)); % Read Dicom file
    % Histogram Equalization 8 bits
    mult = 255/(max(max(img(:,:,info.InstanceNumber)))); % full range multiplier
    img(:,:,info.InstanceNumber) = double(mult*img(:,:,info.InstanceNumber));   % full range 8-bit reference image
end
%%





cd(old_folder)

n=0;
i=1;
% scale=[features_class(i,5), features_class(i,6), features_class(i,7)];
scale=[2^n,  2^n, 2^n];
pos=[features_class(i,2), features_class(i,3), features_class(i,4)];
type=(features_class(i,1));

box=img(1:86,1:106,1:14);
