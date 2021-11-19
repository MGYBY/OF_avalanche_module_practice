dx = 2.0/16;
U = 1.7405;
H = 0.20;
W = H*10.0;
rho_flow = 1500.0;

% 10 gauges
frontForce_data = importdata("./postProcessing/swakExpression_faFrontForce/0/faFrontForce", ' ',2);
backForce_data = importdata("./postProcessing/swakExpression_faBackForce/0/faBackForce", ' ',2);

frontForce = frontForce_data.data;
backForce = backForce_data.data;

time = frontForce(:,1);

force1 = frontForce(:,2);
force2 = backForce(:,2);

fw_1 = dx*(force1); 
fw_2 = dx*(force2); 
delta_fw = fw_1+fw_2;
force = delta_fw*rho_flow;
% density already considered
normal_fw = (0.50*(1.0)*W*(U^2)*H); % take sum by cols

coeff_cd = delta_fw./normal_fw;
cd_time_series = [time, force, coeff_cd];

csvwrite ('./cd_time_series.csv', cd_time_series)
