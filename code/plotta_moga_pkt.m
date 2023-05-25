function plotta_pkt(X,Y,Z,tekka)
num=0;
type = {'s','d','^','v','>','<','p','o'};
type_tex = {'\\blacksquare','\\blacklozenge','\\blacktriangle','\\blacktriangledown','\\blacktriangleright','\\blacktriangleleft','\\bigstar','\\bullet'};
type=[type,type,type]; type_tex = [type_tex type_tex type_tex]; 

color={'r','g','b','c','m','y'};
color_tex = {'\\color{red}','\\color{green}','\\color{blue}','\\color{cyan}','\\color{magenta}','\\color{yellow}'};
color=[color,color,color]; color_tex = [color_tex color_tex color_tex];

for i=1:length(X)
    plot3(X(i),Y(i),Z(i),type{i+num},'MarkerEdgeColor','k',...
        'MarkerFaceColor',color{i+num},'MarkerSize',12) 
end

end