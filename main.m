%% Belief-Propagation and Susceptibility-Propagation algorithm for brain connectome 
%
% Yedidia, J. S., Freeman, W. T., & Weiss, Y. (2003). Understanding Belief Propagation 
% and Its Generalizations. In B. Lakemeyer, Gerhard and Nebel (Ed.), Exploring Artificial 
% Intelligence in the New Millennium (pp. 239–269). San Francisco, CA, USA: Morgan 
% Kaufmann Publishers Inc. Retrieved from http://dl.acm.org/citation.cfm?id=779343.779352
%
% Running over the structure of the remapped Human Brain Connectome described in:
%
% Hagmann, P., Cammoun, L., Gigandet, X., Meuli, R., Honey, C. J., Wedeen, V. J., 
% & Sporns, O. (2008). Mapping the Structural Core of Human Cerebral Cortex. 
% PLoS Biology, 6(7), e159. https://doi.org/10.1371/journal.pbio.0060159.
%
% (File 'DSI_release2_2011.mat' provided by O. Sporns)
%
% The dynamics of the model as a function of the control parameter T was explored 
% by Peraza-Goicolea et al, Modeling functional resting-state brain networks
% through neural message-passing on the human connectome (2019).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all; clc

% data 
pathData = 'data\';

% parameters
temperature = 0.40:0.05:0.5;% values of temperature 
eps = 10^(-6); % for convergence 
Nitermax = 10000; % maximum number of iterations for each temperature
iTc = 1; % Tc = 0.40. Index 9 in temperature[]
h = []; 

% optional 
ncut = Inf; % Inf, 100 % reduce size of the connectome (for testing the code)

%% Step 0: Load data

data = load([pathData 'DSI_release2_2011.mat']);

J = sparse(data.CIJ_fbden_average);
if ~isinf(ncut)
    J = J(1:ncut,1:ncut); 
end

neigs = J'~=0;
N = size(J,1); % number of rigions of the Connectome
% We defined the message as i (sender), j (reseiver) and k (influencer): i->j,k 
[jIdx,iIdx,~] = find(neigs);
idx = sub2ind([N,N],jIdx,iIdx);
J = full(J(idx));
Nmess = size(iIdx,1); % number of message of the Connectome

if isempty(h) % external field
    h = zeros(N,1); 
end

%% Step 1: Initialize all messages randomly h_(i->j),u_(i->j),v_(i->j,k),g_(i->j,k)
h_ij = rand(Nmess,1);
u_ij = rand(Nmess,1);
g_ijk = rand(Nmess,N);
v_ijk = rand(Nmess,N);

d = zeros(Nmess,N); % Kronecker delta
for k=1:N
    d(iIdx==k,k)=1;
end

%% Step 1': Loop for temperatures    
mag_mean = nan(length(temperature),1);
mag = nan(length(temperature),N);
Tc = temperature(iTc); % critical temperature
count = 1;
for T = temperature 
   B = 1/T; 
   %% Step 2-7: BP Update
   diff = 100;
   iter = 1;
   tic;
   while diff>eps  && iter<Nitermax 
       %  messages update
       [diff, h_ij, u_ij] = update_bp(B, N, h, J, h_ij, u_ij, jIdx);
       iter = iter+1;
       %disp([iter diff]);%checking the convergence
   end
   tt = toc;
   if iter<Nitermax
       disp(['Convergence of BP reached in ' num2str(iter) ' iterations']);
       disp(['Time: ' num2str(tt)]);
   else
       disp('Loop reached max No. of Iterations!');
   end
   
   %% Step 8: Local activations are calculated from Eq. (D.10) o Eq. (9)
   [mag_mean(count), mag(count,:)] = magnet(B, h, u_ij, jIdx);
   disp(['temp: ' num2str(T) '  mean Mag: ' num2str(mag_mean(count))]); % display value
  
   %% Step 9: For T=T_C
   if T==Tc 
       %% Step 10-16: SP Update
       diff = 100;
       iter = 1;
       tic;
       while diff>eps  %&& iter<Nitermax 
           %  messages update
           [diff, g_ijk, v_ijk] = update_sp(B, N, Nmess, d, J, h_ij, u_ij, g_ijk, v_ijk, jIdx);
           %disp([iter diff]);%checking the convergence
           iter = iter+1;
       end
       tt = toc;
       if iter<Nitermax
           disp(['Convergence of SP reached in ' num2str(iter) ' iterations']);
           disp(['Time: ' num2str(tt)]);
       else
           disp('Loop reached max No. of Iterations!');
       end
       
       m_Tc = mag(iTc,:)';
       %% Step 17: The correlations between all the system nodes are calculated according to Eq. (D.17)
       chi = zeros(N,N);
       chi = susceptibility(B, N, d, m_Tc, v_ijk, chi, jIdx);
       %max(max(abs(chi-chi')));% testing the symmetry of chi
   end
   
   count = count+1;    
end

%% In case you want to visualize the results
talairach = (data.roi_xyz_avg)';
visualization(N, m_Tc,chi,talairach);

%% Save the results
save ('results\magnet_Tc.eng', 'm_Tc','-ascii');
save ('results\chi.txt', 'chi','-ascii');
