% update function
function [diffmax, g_ijk, v_ijk]=update_sp(B, N, Nmess, d, J, h_ij, u_ij, g_ijk, v_ijk, jIdx)
    
    alpha = 0.5;
    Nodes = (1:N)';
    [indA,~] = ind2sub([Nmess N],find(pdist2(jIdx,Nodes)==0));
    %indA = repmat(indA,N,1);
    % messages sum (for all-neigs j ~= neig i)
    %sum_v = zeros(N,N);
    g_ijk_new = zeros(Nmess,N);
    v_ijk_new = zeros(Nmess,N);
    for k=1:N
        sum_v = accumarray(jIdx,v_ijk(:,k),[],@sum);
        sum_v = sum_v(jIdx)-v_ijk(:,k);
        g_ijk_new(:,k) =  B*d(:,k) + sum_v(indA); % = B*d + sum_v(indA)
        v_ijk_new(:,k) = g_ijk(:,k).*tanh(B*J).*(1-tanh(h_ij).^2)./(1-tanh(u_ij).^2);
    end
    
    % diff
    diffmax1 = max(max(abs(g_ijk_new - g_ijk))); 
    diffmax2 = max(max(abs(v_ijk_new - v_ijk))); 
          
    diffmax = max(diffmax1,diffmax2);
    % final update
    g_ijk = alpha*g_ijk_new + (1-alpha)*g_ijk;
    v_ijk = alpha*v_ijk_new + (1-alpha)*v_ijk;
end