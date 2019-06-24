# BP_SP_on_HC
Belief Propagation (BP) and Susceptibility Propagation (SP) algorithm for solving the Direct Ising problem on the Human Connectome (998) in criticality.

The critical parameter (T_C) is determined using the [Metropolis algorithm](https://github.com/JulioAPeraza/MH_on_HC).

For details about this algorithm see the preprint version of the paper "[Modeling functional resting-state brain networks through neural message passing on the human connectome](https://arxiv.org/abs/1906.05369)".

## Prerequisites
At least 8 Gb RAM is required

## Description
To execute the algorithm, open [main.m](main.m). It contains five [functions](functions/):
* [update_bp.m](functions/update_bp.m): This function updates the messages of BP, h_{i->j}, u_{i->j}.
* [magnet.m](functions/magnet.m): This function calculates the activations (local magnetizations) once the messages converge.
* [update_sp.m](functions/update_sp.m): This function updates the messages of SP, g_{i->j,k}, v_{i->j,k} at (T_C).
* [susceptibility.m](functions/susceptibility.m): This function calculates the long-range correlations at (T_C) after the convergence of the SP messages.
* [visualization.m](functions/visualization.m): This function is optional, it just visualizes the activation maps obtained with the BP and the long-range correlation matrix from SP.
  
## Usage
Enter the next statement in Command Window of Matlab:
```matlab
main
```
  
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

### Reference list
[Yedidia, J. S., Freeman, W. T., & Weiss, Y. (2003). "Understanding Belief Propagation and Its Generalizations". In B. Lakemeyer, Gerhard and Nebel (Ed.), Exploring Artificial Intelligence in the New Millennium (pp. 239–269). San Francisco, CA, USA: Morgan Kaufmann Publishers Inc.](http://dl.acm.org/citation.cfm?id=779343.779352)

[Mora, T. (2007). "Geometry and Inference in Optimization and in Information Theory". Université Paris Sud - Paris XI.](http://tel.archives-ouvertes.fr/tel-00175221/en/)

[Ollion, C. (2010). "Susceptibility Propagation for the Inverse Ising Model". School of Computer Science and Engineering, Royal Institute of Technology.](https://www.nada.kth.se/utbildning/grukth/exjobb/rapportlistor/2010/rapporter10/ollion_charles_10021.pdf)

[Hagmann, P., Cammoun, L., Gigandet, X., Meuli, R., Honey, C. J., Wedeen, V. J., & Sporns, O. (2008). "Mapping the Structural Core of Human Cerebral Cortex". PLoS Biology, 6(7), e159.](https://doi.org/10.1371/journal.pbio.0060159)

## License
[MIT](https://choosealicense.com/licenses/mit/)
