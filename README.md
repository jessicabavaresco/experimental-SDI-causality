## Code to accompany: *["Experimental semi-device-independent certification of indefinite causal order with the quantum switch"](https://arxiv.org/abs/xxxx.xxxxx)*
#### Jessica Bavaresco

This is a repository for the code used to calculate the coefficient of the semi-device-independent causal inequality of the article "*Title*, Authors, [arXiv:xxxx.xxxxx [quant-ph]](https://arxiv.org/abs/xxxx.xxxxx)".

All code is written in MATLAB and requires:
- [Yalmip](https://yalmip.github.io) - a free MATLAB toolbox for rapid prototyping of optimization problems
- [MOSEK](https://www.mosek.com) - a software package for solving mathematical optimization problems (under the free personal academic license)
- [QETLAB](http://www.qetlab.com/) - a free MATLAB toolbox for quantum entanglement theory

This repository consists in the following:

#### CODE

- [make_theoryoperators](https://github.com/jessicabavaresco/experimental-SDI-causality/blob/master/make_theoryoperators.m):
Code specific to the paper variables. Generates the matrices corresponding to the Choi operators of the quantum switch, to the instruments of Alice and Bob, and the measurements of Charlie, as described in Section II of the Supplemental Material.

- [make_theoryprobabilities](https://github.com/jessicabavaresco/experimental-SDI-causality/blob/master/make_theoryprobabilities.m):
Code specific to the paper variables. Generates the theoretical sets of probability distributions using the quantum switch, instruments and measurements from [make_theoryoperators](https://github.com/jessicabavaresco/experimental-SDI-causality/blob/master/make_theoryoperators.m).

- [primalSDP](https://github.com/jessicabavaresco/experimental-SDI-causality/blob/master/primalSDP.m):
General code. Primal SDP problem, as described in Section I of the Supplemental Material. Not used in the results of the paper but made available here for convenience.

- [dualSDP](https://github.com/jessicabavaresco/experimental-SDI-causality/blob/master/dualSDP.m):
General code. Dual SDP problem, as described in Section I of the Supplemental Material. Generates the set of coefficients of the semi-device-independent causal inequality.

- [evaluate_S](https://github.com/jessicabavaresco/experimental-SDI-causality/blob/master/evaluate_S.m):
General code. Evaluates the value of S that a given set of probability distributions achieves for a given set of semi-device-independent-causal-inequality coefficients.

#### DATA FILES

- [inequality_coefficients](https://github.com/jessicabavaresco/experimental-SDI-causality/blob/master/inequality_coefficients.mat):
MATLAB data file containing the following variables pertaining to the results of the paper:
  - alpha_abcxyz: coefficients of our experimentally-tested semi-device-independent causal inequality.
  - p_experiment: experimentally measured set of probability distributions.
  - p_theory: theoretical prediction of the set of probability distributions.
  - S_experiment: inequality violation of the experimental data.
  - S_theory: theoretical prediction of the violation of the inequality.


