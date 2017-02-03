function result=resize3D(img, size_resul)
% dado_resized = resize3D(img, [s1, s2, s3])
%Função para realizar resize de dados 3D
%Escrita por Flávio Abrantes 12/12/16

    size_image=size(img);
    img_res=zeros(size_resul(1,1), size_resul(1,2), size_image(1, 3));
    img_new=zeros(size_resul(1,3), size_resul(1,1), size_resul(1,2));
    
    for i=1:size_image(1, 3)
        img_res(:,:,i)=imresize(img(:,:,i), [size_resul(1,1), size_resul(1,2)]);
    end
    img_res= permute(img_res, [3 1 2]);
    for i=1:size_resul(1,2)
         img_new(:,:,i)=imresize(img_res(:,:,i), [size_resul(1,3), size_resul(1,1)]);
    end
    result= permute(img_new, [2 3 1]);