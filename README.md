## Code to accompany: *["Experimental semi-device-independent certification of indefinite causal order"](https://arxiv.org/abs/2202.05346)*
#### Jessica Bavaresco

This is a repository for the code used to calculate the coefficients of the semi-device-independent causal inequality of the article "*Experimental semi-device-independent certification of indefinite causal order*, Huan Cao, Jessica Bavaresco, Ning-Ning Wang, Lee A. Rozema, Chao Zhang, Yun-Feng Huang, Bi-Heng Liu, Chuan-Feng Li, Guang-Can Guo, and Philip Walther, [arXiv:2202.05346 [quant-ph]](https://arxiv.org/abs/2202.05346)".

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
  - alpha_abcxyz: coefficients of our semi-device-independent causal inequality. Real tensor following the convention alpha_abcxyz(a,b,c,x,y,z).
  - experimental_counts: number of counts experimentally measured for each outcome of each input setting. Real tensor following the convention experimental_counts(a,b,c,x,y,z).
  - p_experiment: normalized number of experimentally measured counts. Real tensor following the convention p_experiment(a,b,c,x,y,z).
  - p_theory: theoretical prediction of the set of probability distributions. Real tensor following the convention p_theory(a,b,c,x,y,z).
  - S_experiment: inequality violation of the experimental data. Single real number.
  - S_theory: theoretical prediction of the violation of the inequality. Single real number.


