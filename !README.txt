For details about this algorithm see the preprint version of the paper: https://arxiv.org/abs/1906.05369.
To execute the algorithm, open main.m. It contains five functions:
	update_bp.m: This function updates the messages of BP, h_{i->j}, u_{i->j}.
	magnet.m: This function calculates the activations (local magnetizations) once the messages converge.
	update_sp.m: This function updates the messages of SP, g_{i->j,k}, v_{i->j,k}.
	susceptibility.m: This function calculates the long-range correlations after the convergence of the SP messages.
	visualization.m: This function is optional, it just visualizes the activation maps obtained with the BP and the long-range correlation matrix from SP.