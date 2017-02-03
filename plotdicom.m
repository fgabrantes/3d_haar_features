function plotdicom(dicom)
% plotdicom(dicom)
% Fun��o que aceita como vari�vel um conjunto de dados dicom com 3
% dimens�es e plota elas lado a lado
% Escrita por Fl�vio Abrantes em 12/12/2016


[s1 s2 s3]=size(dicom);
for i=1:s3
    subplot(ceil(s3/5), 5, i)
    imshow(dicom(:,:,i), [0, 255])
    set(gca, 'XTickLabel', [],'XTick',[])
    set(gca, 'YTickLabel', [],'YTick',[])
end