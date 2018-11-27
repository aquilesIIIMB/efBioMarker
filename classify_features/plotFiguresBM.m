% Grafica

negro = [0 0 0];
azul = [0 0.4470 0.7410];
rojo = [0.85, 0.325, 0.098];
verde = [0.466, 0.674, 0.188];
morado = [0.494, 0.184, 0.556];
amarillo = [0.929, 0.694, 0.125];
azul_claro = [0.2 0.6470 0.9410];
rojo_oscuro = [0.635, 0.078, 0.184];
verde_claro = [0.666, 0.874, 0.388];
morado_claro = [0.694, 0.384, 0.756];
gris = [0.5 0.5 0.5];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot caracteristicas 
%{
% Por puntos
%%% Raw %%%
% Potencia oscilatoria
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-4)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    pc_pts = plot(x(1,j)', feature_eval(Labels_BM_EP == 0,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(pc_pts,{'Color'},{azul;azul})
    hold on
    pli_pts = plot(x(2,j)', feature_eval(Labels_BM_EP == 1,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(pli_pts,{'Color'},{rojo;verde;morado})
    hold on
    plm_pts = plot(x(3,j)', feature_eval(Labels_BM_EP == 2,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(plm_pts,{'Color'},{rojo;verde;morado})
    hold on
    pla_pts = plot(x(4,j)', feature_eval(Labels_BM_EP == 3,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
    hold on
end
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,5,1); % clases
delta_x = [-0.3 -0.1 0 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','\newlineM1','L-M','L-A','C','L-I','\newlineSTR','L-M','L-A','C','L-I','\newlineVPL','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([0, 160]./1000)
xlim([x(1)-0.1, x(end)+0.1])

% Promedio Potencia oscilatoria
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-4)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
pc_pts = plot(x(1)', mean(feature_eval(Labels_BM_EP == 0,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(pc_pts,{'Color'},{azul;azul})
hold on
pli_pts = plot(x(2)', mean(feature_eval(Labels_BM_EP == 1,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(pli_pts,{'Color'},{rojo;verde;morado})
hold on
plm_pts = plot(x(3)', mean(feature_eval(Labels_BM_EP == 2,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(plm_pts,{'Color'},{rojo;verde;morado})
hold on
pla_pts = plot(x(4)', mean(feature_eval(Labels_BM_EP == 3,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
hold on
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([0, 120]./1000)
xlim([x(1)-0.1, x(end)+0.1])


% Potencia fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-3)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    pc_pts = plot(x(1,j)', feature_eval(Labels_BM_EP == 0,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(pc_pts,{'Color'},{azul;azul})
    hold on
    pli_pts = plot(x(2,j)', feature_eval(Labels_BM_EP == 1,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(pli_pts,{'Color'},{rojo;verde;morado})
    hold on
    plm_pts = plot(x(3,j)', feature_eval(Labels_BM_EP == 2,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(plm_pts,{'Color'},{rojo;verde;morado})
    hold on
    pla_pts = plot(x(4,j)', feature_eval(Labels_BM_EP == 3,j)'./1000,'*','MarkerSize',40,'LineWidth',15);
    set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
    hold on
end
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,5,1); % clases
delta_x = [-0.3 -0.1 0 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','\newlineM1','L-M','L-A','C','L-I','\newlineSTR','L-M','L-A','C','L-I','\newlineVPL','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([100, 800]./1000)
xlim([x(1)-0.1, x(end)+0.1])

% Promedio Potencia fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-3)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
pc_pts = plot(x(1)', mean(feature_eval(Labels_BM_EP == 0,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(pc_pts,{'Color'},{azul;azul})
hold on
pli_pts = plot(x(2)', mean(feature_eval(Labels_BM_EP == 1,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(pli_pts,{'Color'},{rojo;verde;morado})
hold on
plm_pts = plot(x(3)', mean(feature_eval(Labels_BM_EP == 2,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(plm_pts,{'Color'},{rojo;verde;morado})
hold on
pla_pts = plot(x(4)', mean(feature_eval(Labels_BM_EP == 3,:),2)./1000,'*','MarkerSize',40,'LineWidth',15);
set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
hold on
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([100, 700]./1000)
xlim([x(1)-0.1, x(end)+0.1])


% D2 fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-2)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    pc_pts = plot(x(1,j)', feature_eval(Labels_BM_EP == 0,j)','*','MarkerSize',40,'LineWidth',15);
    set(pc_pts,{'Color'},{azul;azul})
    hold on
    pli_pts = plot(x(2,j)', feature_eval(Labels_BM_EP == 1,j)','*','MarkerSize',40,'LineWidth',15);
    set(pli_pts,{'Color'},{rojo;verde;morado})
    hold on
    plm_pts = plot(x(3,j)', feature_eval(Labels_BM_EP == 2,j)','*','MarkerSize',40,'LineWidth',15);
    set(plm_pts,{'Color'},{rojo;verde;morado})
    hold on
    pla_pts = plot(x(4,j)', feature_eval(Labels_BM_EP == 3,j)','*','MarkerSize',40,'LineWidth',15);
    set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
    hold on
end
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,5,1); % clases
delta_x = [-0.3 -0.1 0 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','\newlineM1','L-M','L-A','C','L-I','\newlineSTR','L-M','L-A','C','L-I','\newlineVPL','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([0.8, 2.8])
xlim([x(1)-0.1, x(end)+0.1])

% Promedio D2 fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-2)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
pc_pts = plot(x(1)', mean(feature_eval(Labels_BM_EP == 0,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pc_pts,{'Color'},{azul;azul})
hold on
pli_pts = plot(x(2)', mean(feature_eval(Labels_BM_EP == 1,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pli_pts,{'Color'},{rojo;verde;morado})
hold on
plm_pts = plot(x(3)', mean(feature_eval(Labels_BM_EP == 2,:),2),'*','MarkerSize',40,'LineWidth',15);
set(plm_pts,{'Color'},{rojo;verde;morado})
hold on
pla_pts = plot(x(4)', mean(feature_eval(Labels_BM_EP == 3,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
hold on
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([1.2, 2.4])
xlim([x(1)-0.1, x(end)+0.1])


% D3 fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-1)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    pc_pts = plot(x(1,j)', feature_eval(Labels_BM_EP == 0,j)','*','MarkerSize',40,'LineWidth',15);
    set(pc_pts,{'Color'},{azul;azul})
    hold on
    pli_pts = plot(x(2,j)', feature_eval(Labels_BM_EP == 1,j)','*','MarkerSize',40,'LineWidth',15);
    set(pli_pts,{'Color'},{rojo;verde;morado})
    hold on
    plm_pts = plot(x(3,j)', feature_eval(Labels_BM_EP == 2,j)','*','MarkerSize',40,'LineWidth',15);
    set(plm_pts,{'Color'},{rojo;verde;morado})
    hold on
    pla_pts = plot(x(4,j)', feature_eval(Labels_BM_EP == 3,j)','*','MarkerSize',40,'LineWidth',15);
    set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
    hold on
end
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,5,1); % clases
delta_x = [-0.3 -0.1 0 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','\newlineM1','L-M','L-A','C','L-I','\newlineSTR','L-M','L-A','C','L-I','\newlineVPL','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([0.8, 2.8])
xlim([x(1)-0.1, x(end)+0.1])

% Promedio D3 fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-1)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
pc_pts = plot(x(1)', mean(feature_eval(Labels_BM_EP == 0,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pc_pts,{'Color'},{azul;azul})
hold on
pli_pts = plot(x(2)', mean(feature_eval(Labels_BM_EP == 1,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pli_pts,{'Color'},{rojo;verde;morado})
hold on
plm_pts = plot(x(3)', mean(feature_eval(Labels_BM_EP == 2,:),2),'*','MarkerSize',40,'LineWidth',15);
set(plm_pts,{'Color'},{rojo;verde;morado})
hold on
pla_pts = plot(x(4)', mean(feature_eval(Labels_BM_EP == 3,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
hold on
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([1, 2.4])
xlim([x(1)-0.1, x(end)+0.1])


% D4 fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    pc_pts = plot(x(1,j)', feature_eval(Labels_BM_EP == 0,j)','*','MarkerSize',40,'LineWidth',15);
    set(pc_pts,{'Color'},{azul;azul})
    hold on
    pli_pts = plot(x(2,j)', feature_eval(Labels_BM_EP == 1,j)','*','MarkerSize',40,'LineWidth',15);
    set(pli_pts,{'Color'},{rojo;verde;morado})
    hold on
    plm_pts = plot(x(3,j)', feature_eval(Labels_BM_EP == 2,j)','*','MarkerSize',40,'LineWidth',15);
    set(plm_pts,{'Color'},{rojo;verde;morado})
    hold on
    pla_pts = plot(x(4,j)', feature_eval(Labels_BM_EP == 3,j)','*','MarkerSize',40,'LineWidth',15);
    set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
    hold on
end
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,5,1); % clases
delta_x = [-0.3 -0.1 0 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','\newlineM1','L-M','L-A','C','L-I','\newlineSTR','L-M','L-A','C','L-I','\newlineVPL','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([-0.5, 3])
xlim([x(1)-0.1, x(end)+0.1])

% Promedio D4 fractal
fig = figure('units','normalized','outerposition',[0 0 1 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
pc_pts = plot(x(1)', mean(feature_eval(Labels_BM_EP == 0,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pc_pts,{'Color'},{azul;azul})
hold on
pli_pts = plot(x(2)', mean(feature_eval(Labels_BM_EP == 1,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pli_pts,{'Color'},{rojo;verde;morado})
hold on
plm_pts = plot(x(3)', mean(feature_eval(Labels_BM_EP == 2,:),2),'*','MarkerSize',40,'LineWidth',15);
set(plm_pts,{'Color'},{rojo;verde;morado})
hold on
pla_pts = plot(x(4)', mean(feature_eval(Labels_BM_EP == 3,:),2),'*','MarkerSize',40,'LineWidth',15);
set(pla_pts,{'Color'},{rojo;verde;rojo_oscuro})
hold on
legend([pla_pts;pc_pts(1);pla_pts(end)], {'S01','S02','S03','S04','S05'},'Location','southoutside','Orientation','horizontal')
set(gca, 'XTick', x(:), 'XTickLabel', {'C','L-I','L-M','L-A'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([0.6, 2.4])
xlim([x(1)-0.1, x(end)+0.1])
%}

% Por boxplot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Potencia oscilatoria
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-4)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    p_box = boxplot(feature_eval(:,j)',Labels_BM_EP,'position',x(:,j), 'widths',0.1);
    set(p_box,'LineWidth',6)
    set(p_box,'LineStyle','-')
    h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Median'); 
    set(h_pre,'LineWidth',10);
    hold on
end
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','E','I','L'})
ylim([0, 160])
xlim([x(1)-0.2, x(end)+0.2])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)

% Promedio Potencia oscilatoria
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-4)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
p_box = boxplot(mean(feature_eval,2),Labels_BM_EP,'position',x, 'widths',0.1);
set(p_box,'LineWidth',6)
set(p_box,'LineStyle','-')
h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Median'); 
set(h_pre,'LineWidth',10);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([0, 120])
xlim([x(1)-0.1, x(end)+0.1])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)

% Potencia fractal
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-3)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    p_box = boxplot(feature_eval(:,j)',Labels_BM_EP,'position',x(:,j), 'widths',0.1);
    set(p_box,'LineWidth',6)
    set(p_box,'LineStyle','-')
    h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Median'); 
    set(h_pre,'LineWidth',10);
    hold on
end
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([100, 800])
xlim([x(1)-0.2, x(end)+0.2])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)

% Promedio Potencia fractal
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-3)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
p_box = boxplot(mean(feature_eval,2),Labels_BM_EP,'position',x, 'widths',0.1);
set(p_box,'LineWidth',6)
set(p_box,'LineStyle','-')
h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Median'); 
set(h_pre,'LineWidth',10);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([100, 700])
xlim([x(1)-0.1, x(end)+0.1])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)


% D2 fractal 
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-2)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    p_box = boxplot(feature_eval(:,j)',Labels_BM_EP,'position',x(:,j), 'widths',0.1);
    set(p_box,'LineWidth',6)
    set(p_box,'LineStyle','-')
    h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Median'); 
    set(h_pre,'LineWidth',10);
    hold on
end
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([0.8, 2.8])
xlim([x(1)-0.2, x(end)+0.2])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)

% Promedio D2 fractal
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-2)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
p_box = boxplot(mean(feature_eval,2),Labels_BM_EP,'position',x, 'widths',0.1);
set(p_box,'LineWidth',6)
set(p_box,'LineStyle','-')
h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Median'); 
set(h_pre,'LineWidth',10);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([1.2, 2.4])
xlim([x(1)-0.1, x(end)+0.1])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)


% D3 fractal
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-1)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    p_box = boxplot(feature_eval(:,j)',Labels_BM_EP,'position',x(:,j), 'widths',0.1);
    set(p_box,'LineWidth',6)
    set(p_box,'LineStyle','-')
    h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Median'); 
    set(h_pre,'LineWidth',10);
    hold on
end
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([0.8, 2.8])
xlim([x(1)-0.2, x(end)+0.2])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)

% Promedio D3 fractal
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-1)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
p_box = boxplot(mean(feature_eval,2),Labels_BM_EP,'position',x, 'widths',0.1);
set(p_box,'LineWidth',6)
set(p_box,'LineStyle','-')
h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Median'); 
set(h_pre,'LineWidth',10);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([1, 2.4])
xlim([x(1)-0.1, x(end)+0.1])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)


% D4 fractal
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i)]; % caracteristicas
end
x_base = [1, 2, 3]; % areas
x_base = repmat(x_base,4,1); % clases
delta_x = [-0.3 -0.1 0.1 0.3]; % clases
delta_x = repmat(delta_x,3,1)'; % areas
x = x_base + delta_x;
for j = 1:3 %areas
    p_box = boxplot(feature_eval(:,j)',Labels_BM_EP,'position',x(:,j), 'widths',0.1);
    set(p_box,'LineWidth',6)
    set(p_box,'LineStyle','-')
    h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
    set(h_pre,'LineWidth',4); 
    h_pre=findobj(p_box,'tag','Median'); 
    set(h_pre,'LineWidth',10);
    hold on
end
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([-0.5, 3])
xlim([x(1)-0.2, x(end)+0.2])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)

% Promedio D4 fractal
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i)]; % caracteristicas
end
x = [0.7 0.9 1.1 1.3];
p_box = boxplot(mean(feature_eval,2),Labels_BM_EP,'position',x, 'widths',0.1);
set(p_box,'LineWidth',6)
set(p_box,'LineStyle','-')
h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Median'); 
set(h_pre,'LineWidth',10);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','L-I','L-M','L-A'})
ylim([0.6, 2.4])
xlim([x(1)-0.1, x(end)+0.1])
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',30)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Las mejores caracteristicas (4)
% Promedio Potencia oscilatoria STR
fig = figure('units','normalized','outerposition',[0 0 0.4 0.9]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-4)]; % caracteristicas
end
x = [0.85 0.9 0.95 1];
%{
pc_pts = bar(x(1)', median(feature_eval(Labels_BM_EP == 0,2)),0.1,'FaceColor',azul);
hold on
pc_pts = bar(x(2)', median(feature_eval(Labels_BM_EP == 1,2)),0.1,'FaceColor',rojo);
pc_pts = bar(x(3)', median(feature_eval(Labels_BM_EP == 2,2)),0.1,'FaceColor',verde);
pc_pts = bar(x(4)', median(feature_eval(Labels_BM_EP == 3,2)),0.1,'FaceColor',morado);
%}

pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,2)','*','MarkerSize',45,'LineWidth',20);
set(pc_pts,{'Color'},{azul;azul})
hold on
pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,2)','ko','MarkerSize',45,'LineWidth',5);
hold on

pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,2)','*','MarkerSize',45,'LineWidth',20);
set(pli_pts,{'Color'},{rojo;rojo;rojo})
pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,2)','ko','MarkerSize',45,'LineWidth',5);
hold on

plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,2)','*','MarkerSize',45,'LineWidth',20);
set(plm_pts,{'Color'},{verde;verde;verde})
plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,2)','ko','MarkerSize',45,'LineWidth',5);
hold on

pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,2)','*','MarkerSize',45,'LineWidth',20);
set(pla_pts,{'Color'},{morado;morado;morado})
pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,2)','ko','MarkerSize',45,'LineWidth',5);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','E','I','L'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([0, 120])
xlim([x(1)-0.02, x(end)+0.02])


% Promedio D3 fractal M1
fig = figure('units','normalized','outerposition',[0 0 0.4 0.9]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-1)]; % caracteristicas
end
x = [0.85 0.9 0.95 1];
pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,1)','*','MarkerSize',45,'LineWidth',20);
set(pc_pts,{'Color'},{azul;azul})
hold on
pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,1)','ko','MarkerSize',45,'LineWidth',5);
hold on

pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,1)','*','MarkerSize',45,'LineWidth',20);
set(pli_pts,{'Color'},{rojo;rojo;rojo})
pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,1)','ko','MarkerSize',45,'LineWidth',5);
hold on

plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,1)','*','MarkerSize',45,'LineWidth',20);
set(plm_pts,{'Color'},{verde;verde;verde})
plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,1)','ko','MarkerSize',45,'LineWidth',5);
hold on

pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,1)','*','MarkerSize',45,'LineWidth',20);
set(pla_pts,{'Color'},{morado;morado;morado})
pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,1)','ko','MarkerSize',45,'LineWidth',5);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','E','I','L'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([0.8, 2.2])
xlim([x(1)-0.02, x(end)+0.02])


% Promedio D3 fractal VPL
fig = figure('units','normalized','outerposition',[0 0 0.4 0.9]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i-1)]; % caracteristicas
end
x = [0.85 0.9 0.95 1];
pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,3)','*','MarkerSize',45,'LineWidth',20);
set(pc_pts,{'Color'},{azul;azul})
hold on
pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,3)','ko','MarkerSize',45,'LineWidth',5);
hold on

pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,3)','*','MarkerSize',45,'LineWidth',20);
set(pli_pts,{'Color'},{rojo;rojo;rojo})
pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,3)','ko','MarkerSize',45,'LineWidth',5);
hold on

plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,3)','*','MarkerSize',45,'LineWidth',20);
set(plm_pts,{'Color'},{verde;verde;verde})
plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,3)','ko','MarkerSize',45,'LineWidth',5);
hold on

pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,3)','*','MarkerSize',45,'LineWidth',20);
set(pla_pts,{'Color'},{morado;morado;morado})
pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,3)','ko','MarkerSize',45,'LineWidth',5);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','E','I','L'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([1, 2.8])
xlim([x(1)-0.02, x(end)+0.02])


% Promedio D4 fractal VPL
fig = figure('units','normalized','outerposition',[0 0 0.4 0.9]);
feature_eval = [];
for i = 1:3 % areas
    feature_eval = [feature_eval,BiomarkerDataBase_EP(:,5*i)]; % caracteristicas
end
x = [0.85 0.9 0.95 1];
pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,3)','*','MarkerSize',45,'LineWidth',20);
set(pc_pts,{'Color'},{azul;azul})
hold on
pc_pts = plot(x(1)', feature_eval(Labels_BM_EP == 0,3)','ko','MarkerSize',45,'LineWidth',5);
hold on

pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,3)','*','MarkerSize',45,'LineWidth',20);
set(pli_pts,{'Color'},{rojo;rojo;rojo})
pli_pts = plot(x(2)', feature_eval(Labels_BM_EP == 1,3)','ko','MarkerSize',45,'LineWidth',5);
hold on

plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,3)','*','MarkerSize',45,'LineWidth',20);
set(plm_pts,{'Color'},{verde;verde;verde})
plm_pts = plot(x(3)', feature_eval(Labels_BM_EP == 2,3)','ko','MarkerSize',45,'LineWidth',5);
hold on

pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,3)','*','MarkerSize',45,'LineWidth',20);
set(pla_pts,{'Color'},{morado;morado;morado})
pla_pts = plot(x(4)', feature_eval(Labels_BM_EP == 3,3)','ko','MarkerSize',45,'LineWidth',5);
hold on
set(gca, 'XTick', x(:)', 'XTickLabel', {'C','E','I','L'})
ylabel("Potencia oscilatoria [mW/Hz]")
title("Suma de potencia oscilatoria en la banda alfa-beta durante alzas de potencia") % En los momentos de alza
set(gca,'fontsize',40)
ylim([1, 2.8])
xlim([x(1)-0.02, x(end)+0.02])



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot espacio de caracteristicas
%figure;
%plot(BiomarkerDataBase_EP((Labels_BM_EP == 0,:),4),BiomarkerDataBase_EP((Labels_BM_EP == 0,:),6),'*')
%hold on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot espacio t-SNE



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ranking de caracteristicas y areas
fig = figure('units','normalized','outerposition',[0 0 0.8 1]);
x = [1:15];
[~, I] = sort(accuracy_all(:,7),'descend');
accuracy_all_sorted = accuracy_all(I,:);
accuracy_all_sorted = fliplr(accuracy_all_sorted(:,3:end));
color_sel = {negro;azul;rojo;verde;morado};
for i=1:4
    p_pts = plot(accuracy_all_sorted(:,6-i),'o','Color',color_sel{6-i},'MarkerSize',30,'LineWidth',6);
    hold on
    %p_line = plot(accuracy_all_sorted(:,6-i),'-','Color',color_sel{6-i},'LineWidth',6);
end
p_pts = plot(accuracy_all_sorted(:,1),'+','Color',color_sel{1},'MarkerSize',30,'LineWidth',10);
hold on
p_line = plot(accuracy_all_sorted(:,1),'-','Color',color_sel{1},'LineWidth',10);

xtl = {'\begin{tabular}{c} D3 \\ M1\end{tabular}', '\begin{tabular}{c} Po \\ STR\end{tabular}',...
    '\begin{tabular}{c} D4 \\ M1\end{tabular}', '\begin{tabular}{c} Psf \\ STR\end{tabular}',...
    '\begin{tabular}{c} Po \\ M1\end{tabular}', '\begin{tabular}{c} D2 \\ STR\end{tabular}',...
    '\begin{tabular}{c} D3 \\ STR\end{tabular}', '\begin{tabular}{c} Po \\ VPL\end{tabular}',...
    '\begin{tabular}{c} D4 \\ VPL\end{tabular}', '\begin{tabular}{c} Psf \\ M1\end{tabular}',...
    '\begin{tabular}{c} D2 \\ M1\end{tabular}', '\begin{tabular}{c} D4 \\ STR\end{tabular}',...
    '\begin{tabular}{c} Psf \\ VPL\end{tabular}', '\begin{tabular}{c} D2 \\ VPL\end{tabular}',...
    '\begin{tabular}{c} D3 \\ VPL\end{tabular}'};
set(gca, 'XTick', x(:)', 'XTickLabel', xtl, 'TickLabelInterpreter', 'latex')
set(gca,'fontsize',30)
xlim([x(1)-0.2, x(end)+0.2])
ylim([0, 100])
ylabel("Classification (%)")
xlabel("Area features")
grid on


fig = figure('units','normalized','outerposition',[0 0 1 0.7]);
x = [1:3];
areas_list = [[1:3]',[accuracy_STR_total;accuracy_S1_total;accuracy_SMA_total]];
[~, I] = sort(areas_list(:,6),'descend');
areas_sorted = areas_list(I,:);
areas_sorted = fliplr(areas_sorted(:,2:end));
color_sel = {negro;azul;rojo;verde;morado};
for i=1:4
    p_pts = plot(areas_sorted(:,6-i),'o','Color',color_sel{6-i},'MarkerSize',30,'LineWidth',8);
    hold on
    %p_line = plot(areas_sorted(:,6-i),'-','Color',color_sel{6-i},'LineWidth',6);
end
p_pts = plot(areas_sorted(:,1),'+','Color',color_sel{1},'MarkerSize',30,'LineWidth',10);
hold on
p_line = plot(areas_sorted(:,1),'-','Color',color_sel{1},'LineWidth',10);
set(gca, 'XTick', x(:)', 'XTickLabel', {'M1','STR','VPL'})
set(gca,'fontsize',30)
xlim([x(1)-0.2, x(end)+0.2])
ylim([0, 100])
ylabel("Classification (%)")
xlabel("Areas")
grid on


fig = figure('units','normalized','outerposition',[0 0 1 0.7]);
x = [1:5];
features_list = [[1:5]',[accuracy_Po_total;accuracy_Psf_total;...
    accuracy_D2_total;accuracy_D3_total;accuracy_D4_total]];
[~, I] = sort(features_list(:,6),'descend');
features_sorted = features_list(I,:);
features_sorted = fliplr(features_sorted(:,2:end));
color_sel = {negro;azul;rojo;verde;morado};
for i=1:4
    p_pts = plot(features_sorted(:,6-i),'o','Color',color_sel{6-i},'MarkerSize',30,'LineWidth',8);
    hold on
    %p_line = plot(features_sorted(:,6-i),'-','Color',color_sel{6-i},'LineWidth',6);
end
p_pts = plot(features_sorted(:,1),'+','Color',color_sel{1},'MarkerSize',30,'LineWidth',10);
hold on
p_line = plot(features_sorted(:,1),'-','Color',color_sel{1},'LineWidth',10);
set(gca, 'XTick', x(:)', 'XTickLabel', {'Po','D3','D4','Psf','D2'})
set(gca,'fontsize',30)
xlim([x(1)-0.2, x(end)+0.2])
ylim([0, 100])
ylabel("Classification (%)")
xlabel("Features")
grid on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matriz de confusion
fig = figure('units','normalized','outerposition',[0 0 0.6 1]);
imagesc(confM_test_total);            % Create a colored plot of the matrix values
colormap(flipud(bone));
textStrings = num2str(confM_test_total(:), '%0.0f');       % Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
[x, y] = meshgrid(1:4);  % Create x and y coordinates for the strings
hStrings = text(x(:), y(:), textStrings(:), ...  % Plot the strings
                'HorizontalAlignment', 'center','FontSize',30,'FontWeight','bold');
midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range
textColors = repmat(confM_test_total(:) > midValue, 1, 3);  % Choose white or black for the
                                               %   text color of the strings so
                                               %   they can be easily seen over
                                               %   the background color
set(hStrings, {'Color'}, num2cell(textColors, 2));
set(gca,'fontsize',30)
set(gca, 'XTick', 1:4, ...                             % Change the axes tick marks
         'XTickLabel', {'C', 'LI', 'LM', 'LA'}, ...  %   and tick labels
         'YTick', 1:4, ...
         'YTickLabel', {'C', 'LI', 'LM', 'LA'}, ...
         'TickLength', [0 0]);
c=colorbar('EastOutside');
set(c,'fontsize',30)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot espacio de indice de parkinsonismo
fig = figure('units','normalized','outerposition',[0 0 1 1]);
p_box = boxplot(idxPk_test_temp');
%pre = boxplot(datos(:,1:3:end)',repmat(areas,1,num_record),'position',x(:,1), 'widths',0.2,'Color',azul);
set(p_box,'LineWidth',7)
set(p_box,'LineStyle','-')
h_pre=findobj(p_box,'tag','Upper Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Lower Adjacent Value'); 
set(h_pre,'LineWidth',4); 
h_pre=findobj(p_box,'tag','Median'); 
set(h_pre,'LineWidth',10);
set(gca, 'XTickLabel', {'C','L-I','L-M','L-A'})
ylabel("Indice de Parkinsonism")
xlabel("Clase")
title("Boxplots del indice de Parkinsonism con 6-fold") % En los momentos de alza
set(gca,'fontsize',30)
ylim([0.5 1.7])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Biomarcador
fig = figure('units','normalized','outerposition',[0 0 1 1]);
pc_pts = plot(pred_test(Labels_BM_EP(comb_subj_test)==0),idxPk_test(Labels_BM_EP(comb_subj_test)==0),'*','Color',azul,'MarkerSize',50,'LineWidth',20);
hold on
pli_pts = plot(pred_test(Labels_BM_EP(comb_subj_test)==1),idxPk_test(Labels_BM_EP(comb_subj_test)==1),'*','Color',rojo,'MarkerSize',50,'LineWidth',20);
plm_pts = plot(pred_test(Labels_BM_EP(comb_subj_test)==2),idxPk_test(Labels_BM_EP(comb_subj_test)==2),'*','Color',verde,'MarkerSize',50,'LineWidth',20);
pla_pts = plot(pred_test(Labels_BM_EP(comb_subj_test)==3),idxPk_test(Labels_BM_EP(comb_subj_test)==3),'*','Color',morado,'MarkerSize',50,'LineWidth',20);
plot(predM_trat(1,:)+0.1, idxPk_trat(1,:),'p','Color',verde,'MarkerSize',25,'LineWidth',12)
hold on
plot(predM_trat(2,:)+0.1, idxPk_trat(2,:),'p','Color',amarillo,'MarkerSize',25,'LineWidth',12)
plot(predM_trat(3,:)+0.1, idxPk_trat(3,:),'p','Color',gris,'MarkerSize',25,'LineWidth',12)
legend([pc_pts;pli_pts;plm_pts;pla_pts], {'real-C','real-LI','real-LM','real-LA'},'Location','southoutside','Orientation','horizontal')
set(gca, 'XTick', [0,1,2,3], 'XTickLabel', {'C','L-I','L-M','L-A'})
ylabel("Indice de Parkinsonismo")
xlabel("Prediccion")
title("Comportamiento del Biomarcador") % En los momentos de alza
set(gca,'fontsize',40)
xlim([-0.1, 3.1])

% Alex 130Hz
[62.1187485093756	382.972937685959	1.97249419003326	1.67422600030479	1.76228411657711	103.455279267208	1200.71474950006	1.75098540687464	1.02055105410596	1.28914913438779	57.4706206886422	382.375383681434	2.46805202145244	2.41088785042264	2.65092949299697;
57.7029537730500	322.701876914764	1.63423089016670	1.74811432710810	1.58770938591719	0	164.701421032896	1.77927205071746	0.805687192356915	2.08725938880733	61.0378302655971	199.937340996501	1.87413626933187	1.52432092180586	1.37175447106101;
57.1330796258980	348.854738703214	1.57763464767954	1.78649420341910	1.48252971213470	0	0	0	0	0	53.7248571605219	249.879409596614	1.71772971667784	1.94589622459876	1.93545639068793]

% Alx 300Hz
[59.3067  754.1225    2.2762    1.9965    1.8944 53.4692  410.1549    1.8985    1.9097    1.7362  65.2821  655.8047    2.6608    2.5450    2.6615;
49.5963097495811	265.615013129973	1.65176638273563	1.43135557976809	1.28199482884177	55.2637114064217	325.882855866973	1.79814960417645	1.75653949139354	1.64349687413944	0	220.009805237736	2.12364928914303	1.46162192913137	1.74924312564031;
50.4512148707219	316.045808399547	1.71791287713651	1.64944495801716	1.48690212937503	57.8755948959082	324.399501406179	1.68964987087686	1.82776856297472	1.62577078810699	0	261.262376427080	2.11795873226511	1.76258783673705	2.33972264606118]





