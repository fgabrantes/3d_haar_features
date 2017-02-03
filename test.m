function test()


load('test_param.mat')

% Text Header
fprintf('== \n');
fprintf('== %43s | %9s\n', 'Function Name', 'Score');
fprintf('== %43s | %9s\n', '---------', '-----');

% Test 3D Images
int_image_ones=intimage(ones(4,4,4));
int_image_zeros=intimage(zeros(4,4,4));
int_image_ones_big=intimage(ones(8,8,8));
image_magic=reshape(magic(8), 4,4,4);
int_image_magic=intimage(image_magic);
image_rand=rand(8,8,8);
int_image_rand=intimage(image_rand);

%% intimage()


array(1)=result_eval(int_image_ones, test_param.intimage1);
array(2)=result_eval(int_image_zeros, test_param.intimage2);
fprintf('== %43s | %9s\n', test_param.names{1}, num2str(100*mean(array)));

%% calc_volume()


[kernel, desc]=haar3dfeature([0.5 0.5 0.5], 1);

clear array
array(1)=result_eval(volume_calc(int_image_ones, [1 1 1], desc(:,2)), test_param.volume_calc1);
array(2)=result_eval(volume_calc(int_image_ones, [1 2 1], desc(:,2)), test_param.volume_calc1);
array(3)=result_eval(volume_calc(int_image_ones, [1 1 2], desc(:,2)), test_param.volume_calc1);
array(4)=result_eval(volume_calc(int_image_ones, [2 1 1], desc(:,2)), test_param.volume_calc1);
array(5)=result_eval(volume_calc(int_image_ones, [2 1 2], desc(:,1)), -test_param.volume_calc1);
array(6)=result_eval(volume_calc(int_image_ones, [1 2 2], desc(:,1)), -test_param.volume_calc1);
array(7)=result_eval(volume_calc(int_image_ones, [2 2 1], desc(:,1)), -test_param.volume_calc1);
array(8)=result_eval(volume_calc(int_image_ones_big, [4 4 4], desc(:,1)), -test_param.volume_calc1);
array(9)=result_eval(volume_calc(int_image_magic, [1 2 2], desc(:,1)), test_param.volume_calc3);

[kernel, desc]=haar3dfeature([1 1 1], 4);
array(10)=result_eval(volume_calc(int_image_ones_big, [1 1 1], desc(:,1)), -test_param.volume_calc2);
array(11)=result_eval(volume_calc(int_image_ones_big, [4 4 4], desc(:,4)), test_param.volume_calc2);

fprintf('== %43s | %9s\n', test_param.names{2}, num2str(100*mean(array)));

%% feature_eval()
clear array

for i=1:length(test_param.feature_eval)
    array(i)=result_eval(feature_eval(int_image_magic, i, test_param.feature_pos(i,:), [0.5 0.5 0.5]), test_param.feature_eval(i));
end

fprintf('== %43s | %9s\n', test_param.names{3}, num2str(100*mean(array)));

%% haar3dfeatures()
clear array
for i=1:length(test_param.feature_eval)
    [kernel, ~]=haar3dfeature([0.5 0.5 0.5], i);
    x=test_param.feature_pos(i,1):test_param.feature_pos(i,1)+1;
    y=test_param.feature_pos(i,2):test_param.feature_pos(i,2)+1;
    z=test_param.feature_pos(i,3):test_param.feature_pos(i,3)+1;
    array(i)=result_eval(sum(sum(sum(kernel.*image_magic(x,y,z)))), test_param.feature_eval(i));
end

fprintf('== %43s | %9s\n', test_param.names{4}, num2str(100*mean(array)));

%% filt3d()
clear array
for i=1:length(test_param.filt3d)
    [kernel, ~]=haar3dfeature([0.5 0.5 0.5], i);
     array(i)=result_eval(filt3d(image_magic, kernel), test_param.filt3d{i});
end

fprintf('== %43s | %9s\n', test_param.names{5}, num2str(100*mean(array)));


%% data_sorted()
filt_img=filt3d(image_magic, kernel);
features=data_sorted(filt_img, 7, [0.5, 0.5, 0.5]);
[features_len, ~]=size(features);
clear array
for i=1:features_len
    array(i)=result_eval(features(i,2), feature_eval(int_image_magic, features(i,1), features(i, 3:5), features(i, 6:8)));
end    

fprintf('== %43s | %9s\n', test_param.names{6}, num2str(100*mean(array)));

%% training_features()
clear array

features=training_features(image_rand, test_param.scale_array);

[features_len, ~]=size(features);
cont=1;
for i=1:25:features_len
    array(cont)=result_eval(features(i,2), feature_eval(int_image_rand, features(i,1), features(i, 3:5), features(i, 6:8)));
    cont=cont+1;
end    

array(cont)=result_eval(features(features_len,2), feature_eval(int_image_rand, features(features_len,1), features(features_len, 3:5), features(features_len, 6:8)));
array(cont+1)=result_eval(features_len, test_param.feat_qt);

fprintf('== %43s | %9s\n', test_param.names{7}, num2str(100*mean(array)));
end



function eval=result_eval(calc, result)
    if(sum((calc(:)-result(:)).^2)<1e-4)
        eval= true;
    else
        eval=false;
    end
end

