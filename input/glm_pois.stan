data {
  int<lower=1> N;
  array[N] int<lower=0> y;
  vector[N] t;
  real dp_priori; // sqrt(100) se prior var=100
}

parameters {
  real beta0;
  real beta1;
}

model {
  beta0 ~ normal(0, dp_priori);
  beta1 ~ normal(0, dp_priori);

  y ~ poisson(exp(beta0 + beta1 * t));
}

generated quantities {
  vector[N] y_rep;
  for (i in 1:N)
    y_rep[i] = poisson_rng(exp(beta0 + beta1 * t[i]));
}