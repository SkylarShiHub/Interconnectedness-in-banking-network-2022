% ***********Credit Shock to a Single Bank***********
clear;close all;clc;
BankNum=321;
% delta=linspace(0,1,100);
M=100;
N=80;
delta=linspace(0,1,M);
AA1_data=zeros(M);
round_1_data=zeros(1,M);
round_2_data=zeros(1,M);
round_3_data=zeros(1,M);
round_4_data=zeros(1,M);
decrease_1_data=zeros(1,M);
decrease_2_data=zeros(1,M);
decrease_3_data=zeros(1,M);
decrease_4_data=zeros(1,M);

for i=1:M
    ii1=136;
%     parfor j=1:267
    [round_1,round_2,round_3,round_4,a,decrease1,decrease2,decrease3,decrease4]=bank_down(BankNum,delta(i),ii1);
       % AA1_data(i,j)=AA1;
        round_1_data(i)=round_1;
        decrease_1_data(i)=decrease1;
        round_2_data(i)=round_2;
        decrease_2_data(i)=decrease2;
        round_3_data(i)=round_3;
        decrease_3_data(i)=decrease3;
        round_4_data(i)=round_4;
        decrease_4_data(i)=decrease4;
%     end
end
save('AA1','round_1_data','round_2_data','round_3_data','round_4_data');
save('AA2','decrease_1_data','decrease_2_data','decrease_3_data','decrease_4_data');
% save('decreaseX','decrease1','decrease2','decrease3','decrease4');

% ***********Credit Shock + Funding Liquidity Shock to a Single Bank***********
clear;close all;clc;
BankNum=321;
rollover=0.5;
M=50;
N=50;
discount=linspace(0,2,M);
% discount=0.7
delta=linspace(0,1,N);
% delta=0.45;
AA1_data=zeros(M,N);
round_1_data=zeros(M,N);
round_2_data=zeros(M,N);
round_3_data=zeros(M,N);
round_4_data=zeros(M,N);
for i=1:M
    for j=1:N
        ii=136;
        [round_1,round_2,round_3,round_4,a]=bank_down2(BankNum,delta(j),ii,rollover,discount(i),i,j);
        round_1_data(i,j)=round_1;
        round_2_data(i,j)=round_2;
        round_3_data(i,j)=round_3;
        round_4_data(i,j)=round_4;
    end
end
save('AA1_0.2.mat','round_1_data','round_2_data','round_3_data','round_4_data');
% figure_fun();