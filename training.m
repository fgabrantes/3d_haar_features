function training(str)
% open training set
load(str);

scale_array=[1 1 1;
    1.5 1.5 1.5;
    2 2 2];

%int_img=intimage(img);

% Waiting Bar
h = waitbar(0,'1','Name','Calculating Features...');

len_positive=length(positive);
len_negative=length(negative);
len_bar=len_positive+len_negative;

% Preparing File
features_positive=zeros(1556905,38);
% features_negative=zeros(1556905,76);
% save('features.mat', 'features_positive', 'features_negative');
% clear features_positive features_negative
% file=matfile('features.mat', 'Writable', true);

% Evaluates the first positive in order to allocate memory
waitbar(1/len_bar,h,sprintf('Positive Traning Examples %3d/%3d',1, len_positive));

img=positive{1,1};
info=training_features(img, scale_array);
[s1 ~]=size(info);
cont=0;
features_positive=create_array(s1, len_positive, cont);
features_positive(:,1)=info(:,2);

% Positive Features
aux=1;
for i=2:len_positive
   waitbar(i/len_bar,h,sprintf('Positive Traning Examples %3d/%3d',i, len_positive));
   img=positive{1,i};
   info=training_features(img, scale_array);
   features_positive(:,aux)=info(:,2);
   aux=aux+1;
   if aux==30
       file.features_positive(1:s1,(cont+1):(cont+30))=features_positive;
       cont=cont+1;
       aux=1;
       features_positive=create_array(s1, len_positive, cont);
   end
end

if rem(i, 30)~=0
    file.features_positive(1:s1,(30*cont+1):(30*cont+rem(i, 30)))=features_positive(1:s1,1:rem(i, 30));
end
clear features_positive

save(strcat('features_positive','.mat'), 'features_positive')
%% Negative Features
% 
% for i=1:len_negative
%     waitbar((i+len_positive)/len_bar,h,sprintf('Negative Traning Examples %3d/%3d',i, len_negative));
% 
%    img=negative{1,i};
%    info=training_features(img, scale_array);
%    features_negative(:,i)=info(:,2);
% end
% 
% delete(h)
% info=info(:,[1,3:8]);
% save('features.mat', 'features_negative', 'features_positive','info');
end

function array=create_array(row, length_dataset, cont)

if (length_dataset-((cont-1)*30)>30)
    array = zeros(row,30);
else
    array =zeros(row, length_dataset-((cont-1)*30));
end
end
