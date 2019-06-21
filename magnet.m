function [mag_mean, mag] = magnet(B, h, u_ij, jIdx)

    sum_u = accumarray(jIdx,u_ij,[],@sum);
    mag = tanh(B*h+sum_u);
    mag_mean = mean(mag);
    
end