% ***********Credit Shock to a Single Bank***********
function[round_1,round_2,round_3,round_4,a,decrease1,decrease2,decrease3,decrease4]=bank_down(BankNum,delta,ii)
C=xlsread('world_interbank_lending_matrix.xlsx','Sheet1','LK2:LK322');
X=xlsread('world_interbank_lending_matrix.xlsx','Sheet1','B2:LJ322');
% load("C_X_matrix");
A=X(ii,:);
% B=X(:,ii);
round_1=1;
group_1=[];
group_2=[];
group_3=[];
group_4=[];
C1=zeros(1,BankNum);
E=zeros(1,BankNum);
F=zeros(1,BankNum);
G=zeros(1,BankNum);
decrease1=0;
decrease2=0;
decrease3=0;
decrease4=0;
for jj=1:BankNum;
    if jj~=ii;
    decrease1=decrease1+A(jj)*delta;
    C1(jj)=C(jj)-A(jj)*delta;
       if C1(jj)<=0;
          round_1=round_1+1;
          group_1=[group_1 jj];
       end
    else C1(jj)=0;
    end
end
a=ones(1,BankNum);
a(ii)=0;
for x=1:length(group_1);
    mm=group_1(x);
    a(mm)=0;
    E=E+X(mm,:);
end
C2=zeros(1,BankNum);
round_2=round_1;
for nn=1:BankNum;
    if a(nn)~=0;
    decrease2=decrease2+E(nn)*delta;
    C2(nn)=C1(nn)-E(nn)*delta;
      if C2(nn)<=0;    
         round_2=round_2+1;
         group_2=[group_2 nn];
      end
    else C2(nn)=0;
    end
end
for x=1:length(group_2);
    pp=group_2(x);
    a(pp)=0;
    F=F+X(pp,:);
end
round_3=round_2;
for qq=1:BankNum;
    if a(qq)~=0;
    decrease3=decrease3+F(qq)*delta;
    C3(qq)=C2(qq)-F(qq)*delta;
      if C3(qq)<=0;    
         round_3=round_3+1;
         group_3=[group_3 qq];
      end
    else C3(nn)=0;
    end
end
for x=1:length(group_3);
    vv=group_3(x);
    a(vv)=0;
    G=G+X(vv,:);
end
 round_4=round_3;
for ww=1:BankNum;
    if a(ww)~=0;
    decrease4=decrease4+G(ww)*delta;
    C4(ww)=C3(ww)-G(ww)*delta;
      if C4(ww)<=0;    
         round_4=round_4+1;
         group_4=[group_4 ww];
      end
    else C4(nn)=0;
    end
end
end

% ***********Credit Shock + Funding Liquidity Shock to a Single Bank***********
function[round_1,round_2,round_3,round_4,a]=bank_down2(BankNum,delta,ii,rollover,discount,i,j)
load("C_X_matrix");
A=X(ii,:);   
B=X(:,ii);    
round_1=1;
group_1=[];
group_2=[];
group_3=[];
group_4=[];
C1=zeros(1,BankNum);
E=zeros(1,BankNum);
F=zeros(1,BankNum);
G=zeros(1,BankNum);
H=zeros(1,BankNum);
I=zeros(1,BankNum);
J=zeros(1,BankNum);
load('decreaseXL.mat');
decrease1(i,j)=0;
decrease2(i,j)=0;
decrease3(i,j)=0;
decrease4(i,j)=0;
for jj=1:BankNum;
    if jj~=ii;
%         A(jj)*delta+discount*(1-rollover)*B(jj);
        decrease1(i,j)=decrease1(i,j)+A(jj)*delta+discount/(1-discount)*(1-rollover)*B(jj);
        C1(jj)=C(jj)-A(jj)*delta-discount/(1-discount)*(1-rollover)*B(jj);
       if C1(jj)<=0;
          round_1=round_1+1;
          group_1=[group_1 jj];
       end
    else C1(jj)=0;
    end
end
a=ones(1,BankNum);
a(ii)=0;
for x=1:length(group_1);
    mm=group_1(x);
    a(mm)=0;
    E=E+X(mm,:);
    F=F+X(:,mm);
end
C2=zeros(1,BankNum);
round_2=round_1;
for nn=1:BankNum;
    if a(nn)~=0;
     decrease2(i,j)=decrease2(i,j)+E(nn)*delta+discount/(1-discount)*(1-rollover)*F(nn);
    C2(nn)=C1(nn)-E(nn)*delta-discount/(1-discount)*(1-rollover)*F(nn);
      if C2(nn)<=0;    
         round_2=round_2+1;
         group_2=[group_2 nn];
      end
    else C2(nn)=0;
    end
end
for x=1:length(group_2);
    pp=group_2(x);
    a(pp)=0;
    G=G+X(pp,:);
    H=H+X(:,pp);
end
round_3=round_2;
for qq=1:BankNum;
    if a(qq)~=0;
        decrease3(i,j)=decrease3(i,j)+G(qq)*delta+discount/(1-discount)*(1-rollover)*H(qq);
    C3(qq)=C2(qq)-G(qq)*delta-discount/(1-discount)*(1-rollover)*H(qq);
      if C3(qq)<=0;    
         round_3=round_3+1;
         group_3=[group_3 qq];
      end
    else C3(nn)=0;
    end
end
for x=1:length(group_3);
    vv=group_3(x);
    a(vv)=0;
    I=I+X(vv,:);
    J=J+X(:,vv);
end
 round_4=round_3;
for ww=1:BankNum;
    if a(ww)~=0;
        decrease4(i,j)=decrease4(i,j)+I(ww)*delta+discount/(1-discount)*(1-rollover)*J(ww);
    C4(ww)=C3(ww)-I(ww)*delta-discount/(1-discount)*(1-rollover)*J(ww);
      if C4(ww)<=0;    
         round_4=round_4+1;
         group_4=[group_4 ww];
      end
    else C4(nn)=0;
    end
end
save('decreaseXL','decrease1','decrease2','decrease3','decrease4');
end

% ***********Funding Liquidity Shock to a Single Bank***********
function[round_1,round_2,round_3,round_4,a]=bank_down3(BankNum,ii,rollover,discount,i)
load("C_X_matrix");
load('decreaseL.mat');
A=X(ii,:); 
B=X(:,ii); 
round_1=1;
group_1=[];
group_2=[];
group_3=[];
group_4=[];
C1=zeros(1,BankNum);
E=zeros(1,BankNum);
F=zeros(1,BankNum);
G=zeros(1,BankNum);
H=zeros(1,BankNum);
I=zeros(1,BankNum);
J=zeros(1,BankNum);
decrease1(i)=0;
decrease2(i)=0;
decrease3(i)=0;
decrease4(i)=0;
for jj=1:BankNum;
    if jj~=ii;
    C1(jj)=C(jj)-discount*(1-rollover)*B(jj);
    decrease1(i)=decrease1(i)+discount*(1-rollover)*B(jj);
       if C1(jj)<=0;
          round_1=round_1+1;
          group_1=[group_1 jj];
       end
    else C1(jj)=0;
    end
end
save('group1','group_1');
a=ones(1,BankNum);
a(ii)=0;
for x=1:length(group_1);
    mm=group_1(x);
    a(mm)=0;
    E=E+X(mm,:);
    F=F+X(:,mm);
end
C2=zeros(1,BankNum);
round_2=round_1;
for nn=1:BankNum;
    if a(nn)~=0;
    C2(nn)=C1(nn)-discount*(1-rollover)*F(nn);
    decrease2(i)=decrease2(i)+discount*(1-rollover)*F(nn);
      if C2(nn)<=0;    
         round_2=round_2+1;
         group_2=[group_2 nn];
      end
    else C2(nn)=0;
    end
end
save('group2','group_2');
for x=1:length(group_2);
    pp=group_2(x);
    a(pp)=0;
    G=G+X(pp,:);
    H=H+X(:,pp);
end
round_3=round_2;
for qq=1:BankNum;
    if a(qq)~=0;
    C3(qq)=C2(qq)-discount*(1-rollover)*H(qq);
    decrease3(i)=decrease3(i)+discount*(1-rollover)*H(qq);
      if C3(qq)<=0;    
         round_3=round_3+1;
         group_3=[group_3 qq];
      end
    else C3(nn)=0;
    end
end
for x=1:length(group_3);
    vv=group_3(x);
    a(vv)=0;
    I=I+X(vv,:);
    J=J+X(:,vv);
end
 round_4=round_3;
for ww=1:BankNum;
    if a(ww)~=0;
    C4(ww)=C3(ww)-discount*(1-rollover)*J(ww);
    decrease4(i)=decrease4(i)+discount*(1-rollover)*J(ww);
      if C4(ww)<=0;    
         round_4=round_4+1;
         group_4=[group_4 ww];
      end
    else C4(nn)=0;
    end
end
save('decreaseL','decrease1','decrease2','decrease3','decrease4');
end
