function texify(more_dat)
num=0;
type = {'s','d','^','v','>','<','p','o'};
type_tex = {'\\blacksquare','\\blacklozenge','\\blacktriangle','\\blacktriangledown','\\blacktriangleright','\\blacktriangleleft','\\bigstar','\\bullet'};
type=[type,type,type]; type_tex = [type_tex type_tex type_tex]; 
color={'r','g','b','c','m','y'};
color_tex = {'\\color{red}','\\color{green}','\\color{blue}','\\color{cyan}','\\color{magenta}','\\color{yellow}'};
color=[color,color,color,color,color]; color_tex = [color_tex color_tex color_tex color_tex color_tex];


disp('Latex kóði:')
fprintf('\\begin{array}{|c|cccc|ccc|ccc|c|}\\hline\n')
fprintf('  &   x_1 & x_2 & x_3 & x_4 &    f_1 &    f_2 &    f_3 & f_1 & f_2 & f_3 & t\\\\ \\hline\n') 
[N,M]=size(more_dat);
for i=1:N
    fprintf([color_tex{i+num} type_tex{i+num} '\n'])
    fprintf('& %6.4f & %d & %d & %6.3f & %6.2f & %6.2f & %6.3f & %6.2f & %6.2f & %6.3f & %6.2f \\\\\n',...
            more_dat(i,1),more_dat(i,2),more_dat(i,3),more_dat(i,4),more_dat(i,5),more_dat(i,6),more_dat(i,7),more_dat(i,8),more_dat(i,9),more_dat(i,10),more_dat(i,11));
end
fprintf('\\hline\\end{array}\n')

end