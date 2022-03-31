library(lme4)
library(multilevelTools)
library(JWileymisc)
library(lmerTest)
library(ggplot2)

emp_d <- read.csv("empirical_dims.csv")
emp_d <- emp_d[emp_d$Resolution>64,] # removes lower resolutions
emp_d$res_log_inv <- 1/log(emp_d$Resolution) 

# Exponential decrease towards ? with resolution increase
p1 <- ggplot(emp_d,aes(x=Resolution,color=Estimator,y=Value))+
  geom_point()+#geom_smooth(method="lm")+
  ylim(0,2)+xlim(0,80000)+facet_grid(rows=vars(Estimator))
# Inverse of log 
p2 <- ggplot(emp_d,aes(x=1/(log(Resolution)),color=Estimator,y=Value))+
  geom_point()+#geom_smooth(method="lm")+
  ylim(0,2)+xlim(0,0.5)+facet_grid(rows=vars(Estimator))


ggplot(emp_d,aes(x=log(1/(Resolution)),color=Estimator,y=Value))+
  geom_point()+#geom_smooth(method="lm")+
  facet_grid(rows=vars(Estimator))+
  xlim(-10,0)


multiplot(p1,p2)
# Including 64x64: R^2 = 0.99; Beta0 = 0.90025 (0.85-0.95)
d_fit <- lm(Value ~ I(1/log(Resolution)),
            data = emp_d[emp_d$Estimator=="BoxCount",])

d_fit <- lm(Value ~ res_log_inv,
             data = emp_d[emp_d$Estimator=="BoxCount",])

# Including 64x64: R^2 = 1.0 ; Beta0 = 0.86448 (0.82-0.90)
d_fit <- lm(Value ~ res_log_inv,
             data = emp_d[emp_d$Estimator=="Fractal-Dimension",])

d_fit <- lmer(Value ~ 0+ (1+res_log_inv|Estimator),
              data = emp_d)
ranef(d_fit)

# Log(1+sqrt(2)) ?
