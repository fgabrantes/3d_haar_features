function plotdicom(dicom)
% plotdicom(dicom)
% Função que aceita como variável um conjunto de dados dicom com 3
% dimensões e plota elas lado a lado
% Escrita por Flávio Abrantes em 12/12/2016


[s1 s2 s3]=size(dicom);
for i=1:s3
    subplot(ceil(s3/5), 5, i)
    imshow(dicom(:,:,i), [0, 255])
    set(gca, 'XTickLabel', [],'XTick',[])
    set(gca, 'YTickLabel', [],'YTick',[])
end