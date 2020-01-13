clear vars; close all; clc;

%% User input


studycase = 'linear'; % 'linear' or 'nonlinear';



%% Real plant

xp_0 = 0;

ap = 1;
kp = 3;


% linear case
if strcmp(studycase, 'linear')
    alphap = 0;
    fz = @(x) 0;
    
% nonlinear case
else
    alphap = -3*[0.01 -1 1 0.5]';
    % alphap = -3*[0 -1 1 0]';
    fz = @(x) [x^3 exp(-10*(x+0.5)^2) exp(-10*(x-0.5)^2) sin(2*x)]';
end

f_plant = @(x,u) ap * x + kp * u + alphap' * fz(x);
    


%% model reference: xm_dot = am*xm + km*r

am = -4;
km = 4;
xm_0 = 0;

%% Adaptive gains

gamma = 2;

% initial guess for the 
theta_0 = zeros( size(ap,1) + size(kp,2) + size(alphap,1),1);

%% True parameters

theta_true = [km/kp; (am-ap)/kp; -alphap/kp];



%% SIMULATE

% sim('adaptive_control')
sim('adaptive_control_v18a')


