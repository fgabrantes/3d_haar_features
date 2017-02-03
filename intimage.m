function int_img=intimage(img)
% int_img=intimage(img)
% Evaluate integral volume of the 3d Image
% By Flavio Abrantes 12/12/2016

[s1,s2,s3]=size(img);

int_img=zeros(s1,s2,s3);

for i=1:s1
    for j=1:s2
        for k=1:s3
            int_img(i,j,k)=sum(sum(sum(img(1:i,1:j,1:k),3),2),1);
        end
    end    
end

