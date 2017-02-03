close all
clear

%% Params
neg=2; %negative per true

%% Open Dicom and NRRD files and find POSITIVE

dicom_folder='C:\Users\bouth\Google Drive\Mestrado\ELE205 - Processamento de imagens digitais\Trabalho Final\08 - Banco de dados\DOI';
old_folder=cd(dicom_folder);
lista_pacientes=dir;

cont=1;
for paciente=1:(size(lista_pacientes)-2)
    if( paciente ~= 12 && paciente ~= 19  && paciente ~= 33 && paciente ~= 40 && paciente <43 )
        clear img
        %Acess Dicom folder
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
        
        % Open NRRD
        
        nrrd_folder='C:\Users\bouth\Google Drive\Mestrado\ELE205 - Processamento de imagens digitais\Trabalho Final\08 - Banco de dados\Segmentation Results';
        cd(nrrd_folder);
        nrrd_files=dir;
        
        NRRD=double(nrrdread(nrrd_files(paciente+2).name)); % Read NRRD file
        
        % Find ROI Truth
        [s1 s2 s3]=size(img);
        size_cube=zeros(1,6);
        flag=0;
        for i=1:s3
            [row, col]=find(NRRD(:,:,i)>0);
            if isempty(row)==0
                if flag==0
                    size_cube(1)=min(row);
                    size_cube(2)=max(row);
                    size_cube(3)=min(col);
                    size_cube(4)=max(col);
                    size_cube(5)=i;
                    size_cube(6)=i;
                    flag=1;
                    
                else
                    size_cube(6)=i;
                    if(size_cube(1)>min(row))
                        size_cube(1)=min(row);
                    end
                    if(size_cube(2)<max(row))
                        size_cube(2)=max(row);
                    end
                    if(size_cube(3)>min(col))
                        size_cube(3)=min(col);
                    end
                    if(size_cube(4)<max(col))
                        size_cube(4)=max(col);
                    end
                end
            end
        end
        nrrd_f{1, cont}=NRRD;
        ROI{1, cont}=img(size_cube(1):size_cube(2), size_cube(3):size_cube(4),size_cube(5):size_cube(6));
        ROI_position(cont,:)=size_cube;
        DICOM{1, cont}=img;
        cont=cont+1;
        cd(dicom_folder)
    end
end

cd(old_folder)
%% RESIZE 3D
for paciente=1:length(ROI)
    size_each(paciente,:)=size(ROI{1, paciente});
end

res_size=round(mean(size_each));

for paciente=1:length(ROI)
    positive{1,paciente}=resize3D(ROI{1,paciente}, res_size);
end

%% FIND NEGATIVE

cont=1;
for paciente=1:length(ROI)
    size_dicom=size(nrrd_f{1, paciente});
    test_img=zeros(size_dicom(1,1), size_dicom(1,2));
    %test ROI  image
    test_img(ROI_position(paciente ,1):ROI_position(paciente ,2),...
        ROI_position(paciente ,3):ROI_position(paciente ,4))= ...
        ones(ROI_position(paciente ,2)-ROI_position(paciente ,1)+1,...
        ROI_position(paciente ,4)-ROI_position(paciente ,3)+1);
    for i=1:neg
          r1=randi(size_dicom(1,1)-res_size(1,1));
          r2=r1+res_size(1,1)-1;
          if((r1>=ROI_position(paciente,1) && r1<=ROI_position(paciente,2)) ...
                  ||(r2>=ROI_position(paciente,1) && r2<=ROI_position(paciente,2)))
                rdn_array=[1:(ROI_position(paciente,3)-1-res_size(1,2)),...
                    (ROI_position(paciente,4)+1):(size_dicom(1,2)-res_size(1,2))];
                if isempty(rdn_array)
                    c1=1;
                else
                    c1=rdn_array(randi(length(rdn_array)));
                end
                c2=c1+res_size(1,2)-1;
          else
              c1=randi(size_dicom(1,2)-res_size(1,2));
              c2=c1+res_size(1,2)-1;
          end
       z1=randi(size_dicom(1,3)-res_size(1,3));
       z2=z1+res_size(1,3)-1;
       
       negative{1,cont}=DICOM{1,paciente}(r1:r2,c1:c2, z1:z2);
       cont=cont+1;
    end
end


%save training.mat positive negative

