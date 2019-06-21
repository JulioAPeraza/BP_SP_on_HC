# BP_SP_on_HC
Belief Propagation and Susceptibility Propagation on the Human Connectome (998).

For details about this algorithm see the preprint version of the paper: https://arxiv.org/abs/1906.05369.

## Prerequisites
At least 8 Gb RAM is required

## Description
To execute the algorithm, open [main.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/main.m). It contains five [functions](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/):
* [update_bp.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/update_bp.m): This function updates the messages of BP, h_{i->j}, u_{i->j}.
* [magnet.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/magnet.m): This function calculates the activations (local magnetizations) once the messages converge.
* [update_sp.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/update_sp.m): This function updates the messages of SP, g_{i->j,k}, v_{i->j,k}.
* [susceptibility.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/susceptibility.m): This function calculates the long-range correlations after the convergence of the SP messages.
* [visualization.m](https://github.com/JulioAPeraza/BP_SP_on_HC/blob/master/fucntions/visualization.m): This function is optional, it just visualizes the activation maps obtained with the BP and the long-range correlation matrix from SP.
  
## Usage
```matlab
main.m
```
  
  ## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
