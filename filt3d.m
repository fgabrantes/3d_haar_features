function filtered=filt3d(img, kernel)
% FILT3D filter 3-dimensional images using a 3-dimensional kernel only using the valid positions.
% FILT3D return the 3-dimensional filtered image with dimension:
% img_size-kernel_size+1
% By Flavio Abrantes 09/01/2017


kernel_size=size(kernel);
max_position=size(img)-kernel_size+1;


% Positions
[X, Y, Z]=meshgrid(1:max_position(1), 1:max_position(2), 1:max_position(3));
%Positions reshape in column vector
[s1,s2,s3]=size(Y);
X=reshape(X,s1*s2*s3,1);
Y=reshape(Y,s1*s2*s3,1);
Z=reshape(Z,s1*s2*s3,1);


%kernel length minus 1
len_x=kernel_size(1)-1;
len_y=kernel_size(2)-1;
len_z=kernel_size(3)-1;

filtered=zeros(s1*s2*s3, 1);

for i = 1:length(X)
    filtered(i)=sum(sum(sum(kernel.*img(X(i):X(i)+len_x,Y(i):Y(i)+len_y, Z(i):Z(i)+len_z))));
end

filtered=reshape(filtered, max_position(1),max_position(2),max_position(3));
