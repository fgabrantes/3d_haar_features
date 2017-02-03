function features=data_sorted(conv, type, scale)
% features=data_sorted(conv)
% Sort the data as a matrix n X 8 - n is conv's element quantity
% With this header:
% Feature type - Filtered value - X Position(Row) - Y Position - Z Position
%- Scale X - Scale Y- Scale Z
%
% By Flavio Abrantes 09/01/2017


% Constants
feature_type=1;
filt_value=2;
pos_x=3;
pos_y=4;
pos_z=5;
scale_x=6;
scale_y=7;
scale_z=8;

%Size
[p1,p2,p3]=size(conv);
%Scales
s1=scale(1);
s2=scale(2);
s3=scale(3);


features=zeros(p1*p2*p3, 8);
[Y, X, Z]=meshgrid(1:p1,1:p2,1:p3);
features(:,feature_type)=type*ones(p1*p2*p3, 1);
features(:,filt_value)=reshape(conv, p1*p2*p3, 1);
features(:,pos_x)=reshape(X, p1*p2*p3, 1);
features(:,pos_y)=reshape(Y, p1*p2*p3, 1);
features(:,pos_z)=reshape(Z, p1*p2*p3, 1);
features(:,scale_x)=(s1)*ones(p1*p2*p3, 1);
features(:,scale_y)=(s2)*ones(p1*p2*p3, 1);
features(:,scale_z)=(s3)*ones(p1*p2*p3, 1);
