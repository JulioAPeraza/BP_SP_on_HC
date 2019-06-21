function chi = susceptibility(B, N, d, m, v_ijk, chi, jIdx)

    for k=1:N
        sum_v = accumarray(jIdx,v_ijk(:,k),[],@sum);
        chi(:,k) = (sum_v).*(1-m.^2);
        chi(k,k) = 0;% diagonal values of the matrix formed by elements chi_ij are set to 0)
    end
    
end