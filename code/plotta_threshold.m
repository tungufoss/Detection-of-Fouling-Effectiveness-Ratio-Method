function plotta_threshold(ratio,th,MAXSETS,fileName)

number_of_sets = ratio.number_of_sets;
intervals = ratio.intervals;

handle=figure('position',[100 100 600 400]); hold on
subplot(1,2,1),hold on
subplot(1,2,2),hold on

number_of_sets = ratio.number_of_sets;
intervals = ratio.intervals;

rand_sets = randperm(number_of_sets); rand_sets(min(number_of_sets,MAXSETS)+1:end)=[];

for k=rand_sets
  for j=1:intervals
    subplot(1,2,1),plot((ratio.begin:ratio.N(j))/ratio.final,ratio.c{k,j},'color',[0.5 0.5 0.5]);
    subplot(1,2,2),plot((ratio.begin:ratio.N(j))/ratio.final,ratio.f{k,j},'k');
  end
end
subplot(1,2,1)
line([0 1],[th.mean th.mean],'LineWidth',2)
%line([0 1],[th.quant(1) th.quant(1)],'linestyle','--','LineWidth',2)
%line([0 1],[th.quant(2) th.quant(2)],'linestyle','--','LineWidth',2)
ylabel('Effectiveness ratio','interpreter','latex','FontSize',14)
xlabel('Dimensionless time, $t$','interpreter','latex','FontSize',14)
%title(['Moving average with s=' num2str('%.3f')])
legend('Clean data'), axis([ratio.begin/ratio.final 1 0.1 1.3])
subplot(1,2,2)
line([0 1],[th.mean th.mean],'LineWidth',2)
%line([0 1],[th.quant(1) th.quant(1)],'linestyle','--','LineWidth',2)
%line([0 1],[th.quant(2) th.quant(2)],'linestyle','--','LineWidth',2)
legend('Fouled data'), axis([ratio.begin/ratio.final 1 0.1 1.3])
ylabel('Effectiveness ratio','interpreter','latex','FontSize',14)
xlabel('Dimensionless time, $t$','interpreter','latex','FontSize',14)
%title(['Moving average with s=' num2str(ratio.final,'%.3f')])
fprintf('SAVING FILE %s\n',fileName);
%saveas(handle,fileName);
end