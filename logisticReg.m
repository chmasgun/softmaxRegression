function logisticReg(file,learnRate)
iters=30000;
d1=fopen(file,'r');
header=fscanf(d1, '%f %d\n',[1 2]);
length=header(1);
numVars=header(2);
theta=zeros((numVars+1),1);

data1=fscanf(d1,'%f',[(numVars+1) length]);
data1=data1';
y=data1(:,numVars+1);
numClass=max(y)
x=data1(:,1:numVars);
lim1=min(x);
lim2=max(x);
x(:,2:numVars+1)=x;
x(:,1)=ones(length,1);

for class=1:numClass
    theta=zeros((numVars+1),1);
    y2=y==class;
    for m=1:1:iters
        theta=theta-(learnRate/length)*x'*((1./(1+exp(-x*theta)))-y2);
    end       
    
    thetas(:,class)=theta;
end
if(numVars==1)
    testVal=input('Please enter the test value: ');
    (1./(1+exp(-[1 testVal]*theta)))
    scanplot(file,'r')
    hold on
    refline(theta(2),theta(1))
    axis([lim1,lim2,0,1])
else
    testX=input('Please enter the test value for X: ');
    testY=input('Please enter the test value for Y: ');
    classPlot(file);
    hold on
    for class=1:numClass
        refline(-thetas(2,class)/thetas(3,class),-thetas(1,class)/thetas(3,class))
        disp(strcat('Probability of ',num2str(class),' th group: ',num2str(1./(1+exp(-[1 testX testY]*thetas(:,class))))));
        thetas(:,class);
    end
    axis([lim1(1),lim2(1),lim1(2),lim2(2)]);
end
fclose(d1);
end