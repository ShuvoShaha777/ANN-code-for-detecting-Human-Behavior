%Clear Memory & Command Window
clc;
clear all;
close all;
% %% SVM 
% load('inputfeatureann.mat')
%  v=inputdlg('Number of feature to use');
%     v=str2double(v(1));
% %     save unnamed v;
% 
% % unnamed=unnamed;
% % save unnamed;
% d=unnamed1(1:1:v, 1:1:37);
%  p=double(d);
% q=p';
% load('targetANN_SVM.mat')
%  m=inputdlg('Number of row of target to use');
%     m=str2double(m(1));
%     save unnamed1 m;
%     n=unnamed1(1:1:m, 1:1:37);
%     t=double(n);
% 
% s=t(1,:);
% s=s';
% % linear kernel
% SVMStruct = svmtrain(q,s);
% w=inputdlg('Number of sample to test');
%     w=str2double(w(1));
%     w=w';
%     
% Output = svmclassify(SVMStruct,w);
% disp('linear kernel');
% Acc(1,:)=my_svm_acc(g2,Output)

%% Training through Backpropagation Algorithm

load('inputfeatureann_EEG.mat')
 v=inputdlg('Number of feature to use');
    v=str2double(v(1));
%     save unnamed v;

% unnamed=unnamed;
% save unnamed;
d=unnamed1(1:1:v, 1:1:15);
 p=double(d);


load('targetANN_SVM_EEG_1.mat')
 m=inputdlg('Number of row of target to use');
    m=str2double(m(1));
    save target1 m;
    n=unnamed(1:1:m, 1:1:15);
    t1=double(n);


% net=patternnet(39);
net=feedforwardnet(130);
% net=newff(minmax(p),t,[65,50],{'tansig','purelin'},'trainlm','learngd','mse');


net.trainParam.show = 50;
net.trainParam.lr = 0.05;
net.trainParam.mc = 0.0001;
net.trainParam.epochs = 2000;
net.trainParam.goal = 0.005;
net.trainParam.min_grad=1e-20;
net.trainParam.max_fail=200;

net.divideParam.trainRatio = 90/100;
net.divideParam.valRatio   = 5/100;
net.divideParam.testRatio  = 5/100;

% N=10;
[net,tr]=train(net,p,t1);
save tr;
% out=double(unnamed1(1:1:v, 1:1:7));
outputs = net(p);
errors = gsubtract(t1,outputs);
performance = perform(net,t1,outputs)
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotconfusion(t1,outputs)
figure, ploterrhist(errors)


% view(net);


%% Whether to go next step or not
bGo=1;
while bGo 
    if ~strcmp(questdlg('Is your Training over?'),'No'),bGo=0;
    end
end

% %% Testing the network
% 
% r=inputdlg('Number of sample to test');
%     r=str2double(r(1));
% %     save unnamed r;
%     
% testX = p(:,1:r);
% testT = t1(:,1:r);
% 
% testY = net(testX);
% testIndices = vec2ind(testY)
% 
% 
% [c,cm] = confusion(testT,testY)
% plotconfusion(testT,testY)
% fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
% fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);


