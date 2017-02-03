function volume_sum=feature_eval(box, type, pos, scale)
%FEATURE_EVAL(box, type, pos, scale)
%Evaluates the feature volume with position and scale

[~, desc]=haar3dfeature(scale, type);
[~, desc_size]=size(desc);

volume_sum=0;
for j=1:desc_size
    volume_sum=volume_sum+volume_calc(box, pos, desc(:,j));
end
