# Case Study 03
# The Study of Palindromes in DNA
# Patterns of DNA

data = read.table("hcmv-263hxkx.txt",header = T)
length(data$location) # in total 296 observations that has letter greater than 10
N <- 229354
n <- length(data$location)
intcut <- 46 # with 46 cuts we yield 45 intervals
intlength <- 45
# Spacing between Two consecutive Palindromes
spacing = c()
for (i in 1:295) {
  spacing[i] = data$location[i+1] - data$location[i]
}
plot(density(spacing), xlab = "Spacing between Consequtive Palindromes", 
     main = "Density Graph of Spacing between two consecutive palindromes", lwd = 2)
lambda.hat = mean(spacing)
exp.sim = rexp(n-1, rate = lambda.hat)
lines(density(exp.sim), col = "blue", lwd = 2)
legend("topright", legend=c("Observed", "Simulated Exponential"),col=c("black", "blue"), lty=1:1, 
       cex=0.8)
chisq.test(x = spacing, y = exp.sim)
# Spacing among Three Palindromes
ds = c()
for (i in 1: 294) {
  ds[i] = data$location[i+2] - data$location[i]
}

scale_hat = sd(ds)^2/mean(ds)
shape_hat = mean(ds)/scale_hat
gamma.sim = rgamma(n-2, shape = shape_hat, scale = scale_hat)
plot(density(gamma.sim), xlab = "Spacing among Three Palindromes", 
     main = "Density Graph of Spacing among Three Palindromes", col = "blue", lwd = 2)
lines(density(ds), col = "black", lwd = 2)
legend("topright", legend=c("Observed", "Simulated Gamma"),col=c("black", "blue"), lty=1:1, 
       cex=0.8)
chisq.test(x = ds, y = gamma.sim)
# Counts in each intervals in the data
s <- seq(from = 1, to = N, length.out = intcut)
datacount <- c()
for (i in 1:intlength) {
  datacount[i] = 0
  for (j in 1:length(data$location)) {
    if ((data$location[j] >= s[i]) && (data$location[j] <= s[i+1]))
      datacount[i] = datacount[i] + 1
  }
}
library(Hmisc)
int = table(cut(N, breaks = s))
intt = as.data.frame(int)
counttab = as.data.frame(datacount)
counttabint = cbind(intt$Var1, counttab)
plot(counttabint, type = "h", xlab = "CMV intervals in Complementary Pairs of Letters or Base Pairs",
     ylab = "Counts", main = "Palindromes counts in each interval")
counts = table(counttab$datacount)
counts

# Distribution Simulation
# Create a genome sequence of length 200,000 with 300 palindrome sites
library(lattice)
set.seed(100)
gene <- seq(1,N)
site.random <- sample.int(N, size = n)
stripplot(site.random, pch = 16, cex = 0.25) # 1-dim scatter plot
# Another example that selects the location according to some pre-determined distribution
set.seed(200)
norm.quant <-seq(-3, 3, length.out = N)
site.norm <- sample.int(N, size = n, prob = dnorm(norm.quant))
stripplot(site.norm, pch = 16, cex = 0.25)
# Another example sample according to the t student distribution
set.seed(300)
t.quant <- seq(-3, 3, length.out = N)
site.t <- sample.int(N, size = n, prob = dt(t.quant,1))
stripplot(site.t, pch = 16, cex = 0.25)

# Split the region into non-overlapping regions of equal length and examine the counts
regionsplit2 <- function(n.region, site) {
  count.int <- table(cut(site, breaks = n.region))
  count.tab <- as.vector(count.int)
  count.df <- as.data.frame(count.tab)
  return(count.df)
}
n.region <- 45
nnn <- regionsplit2(n.region, site.random)
range <- seq(1, length(gene), length.out = n.region)
table1 <- cbind(range, nnn)


# Chi-square Test
chisqtable <- function(n.region, site, N){
  n <- length(site)
  lambda.est <- n/n.region
  count.int <- table(cut(site, breaks = seq(1, 229354, length.out=n.region+1),
                         include.lowest=TRUE))
  count.vector <- as.vector(count.int)
  count.range <- max(count.vector) - min(count.vector) + 1
  table <- matrix(rep(NA, count.range*3), count.range, 3)
  for (i in 1:count.range){
    offset <- min(count.vector) - 1
    table[i, 1] <- i + offset
    table[i, 2] <- sum(count.vector == i + offset)
    table[i, 3] <- n.region*dpois(i+offset, lambda.est)
  }
  return (table)
}
chisq = chisqtable(intlength, data$location, N)
chisq

chisq1 <- matrix(rep(NA, 6*2), 6, 2)
chisq1[1,] <- colSums(chisq[1:3, 2:3])
chisq1[2:5,] <- chisq[4:7, 2:3]
chisq1[6,] <- colSums(chisq[8:14, 2:3])
site.random.stats <- sum((chisq1[,2] - chisq1[,1])^2/chisq1[,2])
pchisq(site.random.stats, 8-2, lower.tail = F)
# Standard Residuals
residuals <- (chisq1[,1] - chisq1[,2]) / sqrt(chisq1[,2])
plot(residuals, xlab = "Grouped index of intervals", ylab = "Standardized residuals", type = "h")
# Plotting
plot(chisq[,2], type = "l", lwd = 2, ylab = "Number of Intervals", xlab = "Counts")
points(chisq[,3], type = "l", col = "blue", lwd = 2)
legend("topleft", legend=c("Observed", "Expected"),col=c("black", "blue"), lty=1:1, cex=0.8)
poi.sim = ppois()
# Biggest Cluter p-value
# Max count prob calculation
p = 0
for (i in 0:15) {
  p = p + (lambda.est^i)*(exp(1)^(-lambda.est))/(factorial(i))
}
pp= p^intlength
appcha = 1 - pp
appcha
