# BP_SP_on_HC
Belief Propagation (BP) and Susceptibility Propagation (SP) algorithm for solving the Direct Ising problem on the Human Connectome (998) in criticality.

The critical parameter (T_C) is determined using the [Metropolis algorithm]().

For details about this algorithm see the preprint version of the paper "[Modeling functional resting-state brain networks through neural message passing on the human connectome](https://arxiv.org/abs/1906.05369)".

## Prerequisites
At least 8 Gb RAM is required

## Description
To execute the algorithm, open [main.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/main.m). It contains five [functions](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/):
* [update_bp.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/update_bp.m): This function updates the messages of BP, h_{i->j}, u_{i->j}.
* [magnet.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/magnet.m): This function calculates the activations (local magnetizations) once the messages converge.
* [update_sp.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/update_sp.m): This function updates the messages of SP, g_{i->j,k}, v_{i->j,k} at (T_C).
* [susceptibility.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/susceptibility.m): This function calculates the long-range correlations at (T_C) after the convergence of the SP messages.
* [visualization.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/visualization.m): This function is optional, it just visualizes the activation maps obtained with the BP and the long-range correlation matrix from SP.
  
## Usage
Enter the next statement in Command Window of Matlab:
```matlab
main
```
  
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

### Reference

## License
[MIT](https://choosealicense.com/licenses/mit/)
