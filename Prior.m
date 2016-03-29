function F = Prior(current,subBlock)
global priorCenter
global priorSD
global priorRecord
global kNorm
priorTime = tic;
prior = 0; %for when you are not doing cwise MH

 prior = log(lognpdf(current(subBlock)*kNorm,priorCenter(subBlock),priorSD(subBlock))) + prior;
% if subBlock == 1
%     for index = 1:1
%         prior = log(lognpdf(current(index)*kNorm,center(index),sd(index))) + prior;
%     end
% elseif subBlock == 2
%     for actIndex = 2:2
%         prior = log(lognpdf(current(actIndex),center(actIndex),sd(actIndex))) + prior;
%     end
% else
%         prior = log(lognpdf(current(3),center(3),sd(3)));
% end
F = prior;
priorRecord = [priorRecord prior];
priorTimeElapsed = toc(priorTime);
assignin('base', 'priorTimeElapsed', priorTimeElapsed);
end