function [kernel, desc]=haar3dfeature(scale, type)
 % kernel=3dhaarfeature(scale, type)
 % Scale is an array [s1 s2 s3]
 % Desc = [tipo, ponto inicial, tamanho]
 % Create 3d haar feature with 4x4x4 by types
 % Escrito por Flávo Abrantes 12/12/16
 
 size_kernel=4;
 new_size=2*ceil((size_kernel*scale)./2);
 kernel=ones(new_size);
 
switch type
    case 1
        kernel(1:new_size(1,1), ((new_size(1,2)/2)+1):new_size(1,2), 1:new_size(1,3))=-ones(new_size(1,1),new_size(1,2)/2, new_size(1,3));
        %Descritor 2 blocos
        desc(:,1)=[-1; 1; ((new_size(1,2)/2)+1); 1; new_size(1,1)-1; (new_size(1,2)/2)-1; new_size(1,3)-1];
        desc(:,2)=[ 1; 1; 1;                     1; new_size(1,1)-1; (new_size(1,2)/2)-1; new_size(1,3)-1];
    case 2
        kernel(1:new_size(1,1), 1:new_size(1,2), ((new_size(1,3)/2)+1):(new_size(1,3)))=-ones(new_size(1,1),new_size(1,2), new_size(1,3)/2);
        %Descritor 2 blocos
        desc(:,1)=[-1; 1; 1; ((new_size(1,3)/2)+1); new_size(1,1)-1; new_size(1,2)-1; (new_size(1,3)/2)-1];
        desc(:,2)=[ 1; 1; 1; 1;                     new_size(1,1)-1; (new_size(1,2))-1; (new_size(1,3)/2)-1];
    case 3
        kernel(1:new_size(1,1), ((new_size(1,2)/2)+1):new_size(1,2), 1:(new_size(1,3)/2))=-ones(new_size(1,1),new_size(1,2)/2, new_size(1,3)/2);
        kernel(1:new_size(1,1), 1:(new_size(1,2)/2), ((new_size(1,3)/2)+1):(new_size(1,3)))=-ones(new_size(1,1),new_size(1,2)/2, new_size(1,3)/2);
        %Descritor 4 blocos
        desc(:,1)=[-1; 1; (new_size(1,2)/2)+1; 1;                   new_size(1,1)-1;  new_size(1,2)/2-1;    (new_size(1,3)/2)-1];
        desc(:,2)=[-1; 1; 1;                   (new_size(1,3)/2)+1; new_size(1,1)-1;  (new_size(1,2)/2)-1;  (new_size(1,3)/2)-1];
        desc(:,3)=[ 1; 1; 1;                   1;                   new_size(1,1)-1;  new_size(1,2)/2-1;    (new_size(1,3)/2)-1];
        desc(:,4)=[ 1; 1; (new_size(1,2)/2)+1; (new_size(1,3)/2)+1; new_size(1,1)-1;  (new_size(1,2)/2)-1;  (new_size(1,3)/2)-1];
    case 4
        kernel(1:new_size(1,1)/2, 1:new_size(1,2), ((new_size(1,3)/2)+1):(new_size(1,3)))=-ones(new_size(1,1)/2,new_size(1,2), new_size(1,3)/2);
        kernel(((new_size(1,1)/2)+1):new_size(1,1), 1:new_size(1,2), 1:new_size(1,3)/2)=-ones(new_size(1,1)/2,new_size(1,2), new_size(1,3)/2);
        %Descritor 4 blocos
        desc(:,1)=[-1; 1;                     1; (new_size(1,3)/2)+1; new_size(1,1)/2-1; new_size(1,2)-1; (new_size(1,3)/2)-1];
        desc(:,2)=[-1; ((new_size(1,1)/2)+1); 1; 1;                   new_size(1,1)/2-1; new_size(1,2)-1; (new_size(1,3)/2)-1];
        desc(:,3)=[ 1; 1;                     1; 1;                   new_size(1,1)/2-1; new_size(1,2)-1; (new_size(1,3)/2)-1];
        desc(:,4)=[ 1; (new_size(1,1)/2)+1;   1; (new_size(1,3)/2)+1; new_size(1,1)/2-1; new_size(1,2)-1; (new_size(1,3)/2)-1];
    case 5
        kernel(1:new_size(1,1)/2, ((new_size(1,2)/2)+1):new_size(1,2), 1:new_size(1,3))=-ones(new_size(1,1)/2,new_size(1,2)/2, new_size(1,3));
        kernel(((new_size(1,1)/2)+1):new_size(1,1), 1:new_size(1,2)/2, 1:new_size(1,3))=-ones(new_size(1,1)/2,new_size(1,2)/2, new_size(1,3));
        %Descritor 4 blocos
        desc(:,1)=[-1; 1;                     ((new_size(1,2)/2)+1); 1; new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)-1];
        desc(:,2)=[-1; ((new_size(1,1)/2)+1); 1;                     1; new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)-1];
        desc(:,3)=[ 1; 1;                     1;                     1; new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)-1];
        desc(:,4)=[ 1; (new_size(1,1)/2)+1;   ((new_size(1,2)/2)+1); 1; new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)-1];
    case 6
        kernel(1:new_size(1,1)/2, ((new_size(1,2)/2)+1):new_size(1,2), 1:new_size(1,3)/2)=-ones(new_size(1,1)/2,new_size(1,2)/2, new_size(1,3)/2);
        kernel(((new_size(1,1)/2)+1):new_size(1,1), 1:new_size(1,2)/2, 1:new_size(1,3)/2)=-ones(new_size(1,1)/2,new_size(1,2)/2, new_size(1,3)/2);
        kernel(1:new_size(1,1)/2, 1:new_size(1,2)/2, ((new_size(1,3)/2)+1):(new_size(1,3)))=-ones(new_size(1,1)/2,new_size(1,2)/2, new_size(1,3)/2);
        kernel(((new_size(1,1)/2)+1):new_size(1,1), ((new_size(1,2)/2)+1):new_size(1,2), ((new_size(1,3)/2)+1):(new_size(1,3)))=-ones(new_size(1,1)/2,new_size(1,2)/2, new_size(1,3)/2);
        %Descritor 8 blocos
        desc(:,1)=[-1; 1;                       ((new_size(1,2)/2)+1);  1;                       new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
        desc(:,2)=[-1; ((new_size(1,1)/2)+1);   1;                      1;                       new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
        desc(:,3)=[-1; 1;                       1;                      ((new_size(1,3)/2)+1);   new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
        desc(:,4)=[-1; (new_size(1,1)/2)+1;     ((new_size(1,2)/2)+1);  ((new_size(1,3)/2)+1);   new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
        desc(:,5)=[ 1; 1;                       1;                      1;                       new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
        desc(:,6)=[ 1; ((new_size(1,1)/2)+1);   ((new_size(1,2)/2)+1);  1;                       new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
        desc(:,7)=[ 1; 1;                       ((new_size(1,2)/2)+1);  ((new_size(1,3)/2)+1);   new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
        desc(:,8)=[ 1; ((new_size(1,1)/2)+1);   1;                      ((new_size(1,3)/2)+1);   new_size(1,1)/2-1; new_size(1,2)/2-1; new_size(1,3)/2-1];
    case 7
        kernel(((new_size(1,1)/2)+1):new_size(1,1), 1:new_size(1,2), 1:new_size(1,3))=-ones(new_size(1,1)/2,new_size(1,2), new_size(1,3));
        %Descritor 2 blocos
        desc(:,1)=[-1; ((new_size(1,1)/2)+1);   1;  1;  new_size(1,1)/2-1;  new_size(1,2)-1;    (new_size(1,3))-1];
        desc(:,2)=[ 1; 1;                       1;  1;  new_size(1,1)/2-1;  new_size(1,2)-1;    (new_size(1,3))-1];
end