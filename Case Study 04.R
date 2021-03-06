# Math 189 Project-based Class
# Case Study 4, Snow Gauge
# Main topic: Regression

# Input variables
data = read.table("gauge.txt", header = T)
data1 = read.table("C2012_L1.dat", header = F)
# Problem 1: Fitted the Data
density = data$density
gain = data$gain
# First give the scatter plot
plot(data)
    # Negative correlation
reg = lm(formula = density~gain, data = data)
summary(reg)
plot(data)
abline(reg, col = "orange", lwd = 2)
res1 = resid(reg)
plot(res1)
plot(density(res1))
qqnorm(res1)

# Exponential Regression
loggain = log(data$gain)
reg2 = lm(formula = data$density~loggain)
plot(reg2)
summary(reg2)
data.0 = data.frame(loggain = log(38.6))
predict(reg2, data.0, interval = "predict")
data.0.0 = data.frame(loggain = log(426.7))
predict(reg2, data.0.0, interval = "predict")


# Cross Validation
# Omitting the set of variables density = 0.5080 
data.ind = which(data["density"]!=0.5080)
newdata = data[data.ind,]
plot(x = log(newdata$gain), y = newdata$density, main = "Scatter Plot Omitted Density = 0.5080",
     xlab = "Log(Gain)", ylab = "Density")
log.gain = log(newdata$gain)
newreg = lm(formula = newdata$density~log.gain)
plot(newreg)
res.2 = resid(newreg)
plot(res.2)
summary(newreg)
plot(newreg)
# Predicting density at corresponding gain
data.1 = data.frame(log.gain = log(38.6))
predict(newreg, data.1, interval = "predict")
# Omitting the set of variables density = 0.0010
data.ind1 = which(data["density"]!=0.0010)
newdata1 = data[data.ind1,]
plot(x = log(newdata1$gain), y = newdata1$density, main = "Scatter Plot Omitted Density = 0.0010",
     xlab = "Log(Gain)", ylab = "Density")
log.gain.1 = log(newdata1$gain)
newreg1 = lm(formula = newdata$density~log.gain.1)
res.2 = resid(newreg1)
plot(res.2)
plot(newreg1)
summary(newreg1)
data.2 = data.frame(log.gain.1 = log(38.6))
data.3 = data.frame(log.gain.1 = log(426.7))
predict(newreg1, data.2, interval = "predict")
predict(newreg1, data.3, interval = "predict")


# Advance Analysis
# Polynomial Regression, p = 2
newreg2 = lm(formula = data$density~poly(loggain, 2))
summary(newreg2)
plot(newreg2)
res.3 = resid(newreg2)
plot(res.3)
predict(newreg2, data.0, interval = "predict")
predict(newreg2, data.0.0, interval = "predict")
# Density 0.5080 removed, access newdata from above
newreg3 = lm(formula = newdata$density~poly(log.gain,2))
summary(newreg3)
plot(newreg3)
res.4 = resid(newreg3)
plot(res.4)
predict(newreg3, data.1, interval = "predict")
# Denisty 0.0010 removed, access newdata1 from above
newreg4 = lm(formula = newdata$density~poly(log.gain.1, 2))
summary(newreg4)
plot(newreg4)
res.5 = resid(newreg4)
plot(res.4)
predict(newreg4, data.3, interval = "predict")

# Polynomial Regression, p = 3
newreg10 = lm(formula = data$density~poly(loggain, 3))
predict(newreg10, data.0, interval = "predict")
predict(newreg10, data.0.0, interval = "predict")
newreg11 = lm(formula = newdata$density~poly(log.gain,3))
predict(newreg11, data.1, interval = "predict")
newreg12 = lm(formula = newdata$density~poly(log.gain.1, 3))
predict(newreg12, data.3, interval = "predict")

newreg20 = lm(formula = data$density~poly(loggain, 4))
predict(newreg20, data.0, interval = "predict")
predict(newreg20, data.0.0, interval = "predict")
newreg21 = lm(formula = newdata$density~poly(log.gain, 4))
predict(newreg21, data.1, interval = "predict")
newreg22 = lm(formula = newdata$density~poly(log.gain.1, 4))
predict(newreg22, data.3, interval = "predict")

newreg30 = lm(formula = data$density~poly(loggain, 5))
predict(newreg30, data.0, interval = "predict")
predict(newreg30, data.0.0, interval = "predict")
newreg31 = lm(formula = newdata$density~poly(log.gain, 5))
predict(newreg31, data.1, interval = "predict")
newreg32 = lm(formula = newdata$density~poly(log.gain.1, 5))
predict(newreg32, data.3, interval = "predict")

newreg40 = lm(formula = data$density~poly(loggain, 6))
predict(newreg40, data.0, interval = "predict")
predict(newreg40, data.0.0, interval = "predict")
newreg41 = lm(formula = newdata$density~poly(log.gain, 6))
predict(newreg41, data.1, interval = "predict")
newreg42 = lm(formula = newdata$density~poly(log.gain.1, 6))
predict(newreg42, data.3, interval = "predict")

