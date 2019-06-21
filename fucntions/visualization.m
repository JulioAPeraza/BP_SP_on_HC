function visualization(N, m_Tc,chi,talairach)
    %% View mean magnetization vs. temperatures
    %plot(temperature, mag_mean);
    
    %% Activation maps obtained with the BP algorithm in the Human Connectome
    x=(talairach(:,1));
    y=(talairach(:,2));
    z=(talairach(:,3));
    
    m1 = m_Tc;
    
    % All estimated maps were thresholded at 0.7 (i.e. activations 
    % below that value were set to zero) to improve the visualization.
    porc=70;
    %tot=256;
    gris=porc*250/100;
    col=(100-porc)*250/100;
        
    leg={'R                   L','R                   L',...
        'P                      A', 'A                      P'};
    ViewPoints=[0,90;0,0;90,0;-90,0];
    figure; 
    for i=1:4
        subplot(2,2,i)
        scatter3(x(:),y(:),z(:),40,m1,'filled');
        axis equal off
        map = [repmat([0.7 .7 .7],gris,1);hot(col)];
        colormap(map);
        t1=title(leg{i});
        set(t1,'Color','black','FontSize',10,'FontWeight','bold','FontName','Times')
        view(ViewPoints(i,:))
    end
    
    h1=colorbar;
    title(h1,'m','fontweight','bold')
    set(h1,'Position',[0.92 0.36 0.03 0.4],'YLim',[0 1],'YTick',[0 0.7 1])
    
    %% Functional long-range correlation matrices among the 998 brain regions.
    figure;
    map=jet(64);
    log_chi=log(chi);
    min0=min(min(log_chi(log_chi~=-Inf)));
    max0=max(max(log_chi(log_chi~=-Inf)));
    imagesc(log_chi)
    tick = round(N,-2)/10;
    set(gca,'FontSize',8,'YLim',[-.5 (N+.5)],'YTick',[0:tick:N N],...
        'XLim',[-.5 (N+.5)],'XTick',[0:tick:N N], 'DataAspectRatio',[1,1,1]);
    colormap(map);
    caxis([min0 max0])
    h1 = colorbar;
    title(h1,'log_{10}','fontweight','bold')
    set(h1,'Position',[0.92 0.16 0.03 0.66],'XLim',[floor(min0) 0],'XTick',(floor(min0):2:0))

end