library(vnpc.avg)
set.seed(0) 


n <- 2 ^ 11
d <- 2
n_segments <- 2 #4
print(paste("Simulating data of", d, "x", n, " (dividing into ", n_segments, ")"))
param_ar <- rbind(c(.1, 0, 0, 0), c(0, -.3, 0, -.5))
param_ma <- matrix(nrow=2, ncol=0)
param_sigma <- matrix(data=c(1, .9, .9, 1), nrow=2, ncol=2)

data <- beyondWhittle::sim_varma(model=list(ar=param_ar, ma=param_ma, sigma=param_sigma),
                                 n=n, d=d)

Ntotal <- 3000 #3000 # TODO 80000
burnin <- 1000 #1000  # TODO 30000
Nadaptive <- burnin
thin <- 1 # TODO 5
print_interval <- 100# 500 # TODO 10000


debug(gibbs_vnpc_avg)
undebug(gibbs_vnpc_avg)

mcmc_vnp_avg <- gibbs_vnpc_avg(
   data = data,
   samp_freq = 2*pi,
   seg_n = 4,
   Ntotal = Ntotal,
   burnin = burnin,
   print_interval = print_interval
)
save(mcmc_vnp_avg, file = "mcmc_results.RData")

