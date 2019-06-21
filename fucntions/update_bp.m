% update function
function [diffmax, h_ij, u_ij] = update_bp(B, N, h, J, h_ij, u_ij, jIdx)
    
    alpha = 0.5;
    
    % messages prod (for all-neigs j ~= neig i)     
    sum_u = accumarray(jIdx,u_ij,[],@sum);
    sum_u = sum_u(jIdx)-u_ij;
    
    Nodes = (1:N)';

    [indA,~] = ind2sub([size(jIdx,1) size(Nodes,1)],find(pdist2(jIdx,Nodes)==0));

    h = h(jIdx);
    h_ij_new = B*h + sum_u(indA);
    u_ij_new = atanh(tanh(B*J).*tanh(h_ij));
    
    % diff
    diffmax1 = max(abs(h_ij_new - h_ij)); 
    diffmax2 = max(abs(u_ij_new - u_ij)); 
          
    diffmax = max(diffmax1,diffmax2);
    % final update
    h_ij = alpha*h_ij_new + (1-alpha)*h_ij;
    u_ij = alpha*u_ij_new + (1-alpha)*u_ij;
end