##Model and plotting script

### packages
require(lmerTest)
require(effects)
### directory
setwd("~/Jasmine uni/Imperial/Summer project/Jasmine")



# DATA --------------------------------------------------------------------


##long term data - female quality assumption
a<-read.csv("alleggadult1789_CB.csv") # N = 98
head(a)
##2019 data - paternal investment assumption
b<-read.csv("parentalproveggs.csv")


### the age difference of birds, long term data
a$age_diff = abs(a$male_age - a$female_age)  
summary(a$age_diff) # 11 NAs

### the average age and delta ages
# average age males
av = aggregate(x = a$male_age, by = list(a$birdID_male ), FUN = "mean") # N = 67
colnames(av)[1] = "birdID_male"
colnames(av)[2] = "av_age_male"
head(av)

a = merge(a, av, by="birdID_male", all.x=T, all.y=F) # N = 98
summary(a)

# average age females
av = aggregate(x = a$female_age, by = list(a$birdID_female ), FUN = "mean") # N = 70
colnames(av)[1] = "birdID_female"
colnames(av)[2] = "av_age_female"
head(av)

a = merge(a, av, by="birdID_female", all.x=T, all.y=F) # N = 98
summary(a)

# delta age males
a$delta_age_male = a$male_age - a$av_age_male
summary(a)

# delta age females
a$delta_age_female = a$female_age - a$av_age_female
summary(a)

### variable transformations
a$bs<-as.factor(a$bs)
a$year<-as.factor(a$year)
a$nest<-as.factor(a$nest)
a$birdID_female<-as.factor(a$birdID_female)
a$birdID_male<-as.factor(a$birdID_male)
summary(a)





# DATA EXPLORATION --------------------------------------------------------


## distributions
hist(a$prov_rate_male)
hist(a$prov_rate_female)

hist(a$prop_prov_male)
hist(a$prop_prov_female)

hist(a$total_prov_rate)

hist(a$male_age)
hist(a$female_age)

###quite a few birds that are around 7/8 years old. Good season?

hist(a$pairbond)

hist(a$spotiness)
hist(a$H_shell)
hist(a$S_shell)
hist(a$V_shell)

##correlations between variables

cor.test(a$female_age, a$prov_rate_female)
#t = 0.53098, df = 86, p-value = 0.5968
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
#  -0.1541238  0.2634518
#sample estimates:
#  cor 
#0.05716374 

# ==> not correlated


plot(a$female_age, a$spotiness)
cor.test(a$female_age, a$spotiness) #bot correlated

plot(a$female_age, a$H_shell)
cor.test(a$female_age, a$H_shell) # positive
#t = 3.9962, df = 86, p-value = 0.0001355
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
#  0.2031334 0.5588605
#sample estimates:
#  cor 
#0.3957391 

plot(a$female_age, a$S_shell)
cor.test(a$female_age, a$S_shell) # negative
#t = -2.4868, df = 86, p-value = 0.01482
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
#  -0.44434572 -0.05240876
#sample estimates:
#  cor 
#-0.259008 

plot(a$female_age, a$V_shell)
cor.test(a$female_age, a$V_shell) # NS


##age seems to be correlated with H and S values

## for males

plot(a$male_age, a$prov_rate_male)
cor.test(a$male_age, a$prov_rate_male)
#t = -0.25913, df = 96, p-value = 0.7961
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
#  -0.2236854  0.1728897
#sample estimates:
#  cor 
#-0.02643803 

# ==> not correlated

plot(a$male_age, a$spotiness)
cor.test(a$male_age, a$spotiness) # NS

plot(a$male_age, a$H_shell)
cor.test(a$male_age, a$H_shell) # NS

plot(a$male_age, a$S_shell)
cor.test(a$male_age, a$S_shell) # NS

plot(a$male_age, a$V_shell)
cor.test(a$male_age, a$V_shell) # NS


##prov rate and age?
cor.test(a$av_age_female, a$prov_rate_female)
cor.test(a$delta_age_female, a$prov_rate_female)
summary(a)

# FOR FEMALES -------------------------------------------------------------
require(lmerTest)
m1 = lmer(spotiness ~ bs
          + av_age_female
          + delta_age_female
          + prov_rate_female
          + (1|year)
          + (1|birdID_female)
          , data=a
)
summary(m1)

#REML criterion at convergence: -183

#Scaled residuals: 
#  Min       1Q   Median       3Q      Max 
#-1.59730 -0.46784 -0.02073  0.41406  2.03756 

#Random effects:
#  Groups        Name        Variance  Std.Dev.
#birdID_female (Intercept) 3.817e-03 0.061784
#year          (Intercept) 4.564e-05 0.006756
#Residual                  1.820e-03 0.042657
#Number of obs: 87, groups:  birdID_female, 59; year, 3

#Fixed effects:
#  Estimate Std. Error        df t value Pr(>|t|)    
#(Intercept)       0.261221   0.026626 27.256064   9.811 1.94e-10 ***
#  bs2              -0.006693   0.018512 32.007073  -0.362    0.720    
#bs3               0.012200   0.019243 48.524017   0.634    0.529    
#av_age_female    -0.001636   0.002089 56.509105  -0.783    0.437    
#delta_age_female  0.012048   0.010417  1.871184   1.157    0.374    
#prov_rate_female -0.012973   0.016460 35.838417  -0.788    0.436    
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Correlation of Fixed Effects:
#  (Intr) bs2    bs3    av_g_f dlt_g_
#bs2         -0.485                            
#bs3         -0.395  0.673                     
#av_age_feml -0.745  0.056  0.032              
#delta_g_fml  0.109 -0.078 -0.158 -0.047       
#prov_rt_fml -0.203 -0.094 -0.172 -0.043 -0.041


m2 = lmer(H_shell ~ bs
          + av_age_female
          + delta_age_female
          + prov_rate_female
          + (1|year)
          + (1|birdID_female)
          , data=a
          , control=lmerControl(optimizer = "bobyqa")
)
summary(m2)

#Random effects:
#Groups        Name        Variance  Std.Dev. 
#birdID_female (Intercept) 2.181e-04 1.477e-02
#year          (Intercept) 1.503e-18 1.226e-09
#Residual                  2.424e-05 4.923e-03
#Number of obs: 87, groups:  birdID_female, 59; year, 3

#Fixed effects:
#  Estimate Std. Error        df t value Pr(>|t|)    
#(Intercept)      1.243e-01  4.998e-03 7.213e+01  24.864   <2e-16 ***
#  bs2              2.173e-03  2.618e-03 4.288e+01   0.830   0.4111    
#bs3              3.308e-03  2.639e-03  3.850e+01   1.253   0.2177    
  #av_age_female    1.146e-03  4.422e-04 5.746e+01   2.591   0.0121 *  
#  delta_age_female 2.767e-03  1.081e-03 2.598e+01   2.559   0.0167 *  
#  prov_rate_female 1.253e-03  2.121e-03 3.312e+01   0.591   0.5587    
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Correlation of Fixed Effects:
#  (Intr) bs2    bs3    av_g_f dlt_g_
#bs2         -0.365                            
#bs3         -0.301  0.705                     
#av_age_feml -0.824  0.038  0.025              
#delta_g_fml  0.073 -0.137 -0.230 -0.003       
#prov_rt_fml -0.157 -0.056 -0.148 -0.029 -0.022
#convergence code: 0
#singular fit



##average age and H shell 
##between and within evidence 


m3 = lmer(S_shell ~ bs        
          + av_age_female     
          + delta_age_female
          + prov_rate_female
          + (1|year)
          + (1|birdID_female) 
          , data=a
)
summary(m3)

#Random effects:
#Groups        Name        Variance  Std.Dev.
#birdID_female (Intercept) 3.554e-03 0.059612
#year          (Intercept) 5.948e-05 0.007712
#Residual                  5.119e-04 0.022625
#Number of obs: 87, groups:  birdID_female, 59; year, 3

#Fixed effects:
#  Estimate Std. Error        df t value Pr(>|t|)    
#(Intercept)       0.391082   0.021851 40.576546  17.898   <2e-16 ***
#  bs2              -0.009689   0.012869 36.019001  -0.753    0.456    
#bs3               0.001460   0.012491 40.619709   0.117    0.908    
#av_age_female    -0.002258   0.001824 55.962699  -1.238    0.221    
#delta_age_female -0.013947   0.007222  1.818760  -1.931    0.206    
#prov_rate_female -0.008460   0.010040 32.986267  -0.843    0.406    
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Correlation of Fixed Effects:
#  (Intr) bs2    bs3    av_g_f dlt_g_
#bs2         -0.417                            
#bs3         -0.350  0.736                     
#av_age_feml -0.788  0.048  0.033              
#delta_g_fml  0.139 -0.057 -0.124 -0.098       
#prov_rt_fml -0.101 -0.174 -0.229 -0.035 -0.045


m4 = lmer(V_shell ~ bs
          + av_age_female
          + delta_age_female
          +prov_rate_female
          + (1|year)
          + (1|birdID_female)
          , data=a
)
summary(m4)
#Random effects:
#Groups        Name        Variance  Std.Dev.
#birdID_female (Intercept) 0.0027333 0.05228 
#year          (Intercept) 0.0009774 0.03126 
#Residual                  0.0007093 0.02663 
#Number of obs: 87, groups:  birdID_female, 59; year, 3

#Fixed effects:
#  Estimate Std. Error         df t value Pr(>|t|)    
#(Intercept)       0.7933627  0.0284616  6.5213869  27.875 4.99e-08 ***
#  bs2               0.0129651  0.0141657 72.7610671   0.915    0.363    
#bs3               0.0015321  0.0138885 56.9775999   0.110    0.913    
#av_age_female     0.0004191  0.0017643 55.8575826   0.238    0.813    
#delta_age_female -0.0155460  0.0145454 12.6492300  -1.069    0.305    
#prov_rate_female  0.0046920  0.0115374 40.9550052   0.407    0.686    
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#correlation of Fixed Effects:
#  (Intr) bs2    bs3    av_g_f dlt_g_
#bs2         -0.367                            
#bs3         -0.303  0.730                     
#av_age_feml -0.617  0.072  0.046              
#delta_g_fml  0.282 -0.064 -0.083 -0.325       
#prov_rt_fml -0.074 -0.211 -0.257 -0.037 -0.045



### ==> NOTHING apart from Hue

##plot
require(ggplot2)


H<-ggplot(data=a, aes(x=H_shell, y=av_age_female)) +
  geom_point()+
  geom_smooth(method="lm", se=F, color="black")+
  theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Average female age", x = "Hue")
H

S<-ggplot(data=a, aes(x=S_shell, y=av_age_female)) +
  geom_point()+
 # geom_smooth(method="lm", se=F, color="black")+
  theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Average female age", x = "Saturation")
S

V<-ggplot(data=a, aes(x=V_shell, y=av_age_female)) +
  geom_point()+
 # geom_smooth(method="lm", se=F, color="black")+
  theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Average female age", x = "Value")
V

SP<-ggplot(data=a, aes(x=spotiness, y=av_age_female)) +
  geom_point()+
  #geom_smooth(method="lm", se=F, color="black")+
  theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Average female age", x = "Spotiness")
SP

require(gridExtra)
grid.arrange(H,S,V,SP, ncol=2)


##ASSUMPTION 2 - Paternal investment:--------------------------------------------------------
##just 2019 data as this is when egg manipulation exp was performed

b<-b[-c(1)]
#b$couple_ID = as.factor(paste(b$birdID_female, b$birdID_male, sep="_"))
#b$diff_prop_rate = abs(b$prop_prov_female-b$prop_prov_male)
b$age_diff = abs(b$male_age-b$female_age)
b$bs<-as.factor(b$bs)
b$exp<-as.factor(b$exp)
hist(b$prov_rate_female)
hist(log(b$prov_rate_female+1))
hist(b$prov_rate_male)
##more normal now



##for real egg parameters first-males

m20 = lm((prov_rate_male) ~ bs
         +spotiness
         #+exp*spotiness
         +exp
         +male_age
         #+(1|birdID_male)
         , data=b
)
summary(m20)

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.60724 -0.35275 -0.05769  0.17303  0.83510 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)       0.737288   0.536691   1.374    0.184
#bs2               0.300948   0.320239   0.940    0.358
#bs3               0.302919   0.308817   0.981    0.338
#spotiness        -0.252631   2.525572  -0.100    0.921
#expyes           -0.160113   0.633062  -0.253    0.803
#male_age          0.003225   0.023381   0.138    0.892
#spotiness:expyes -0.347380   2.749189  -0.126    0.901

#Residual standard error: 0.4354 on 21 degrees of freedom
#Multiple R-squared:  0.1371,	Adjusted R-squared:  -0.1094 
#F-statistic: 0.5562 on 6 and 21 DF,  p-value: 0.7599

#interaction 0.90 not signif
#withou
#'Call:
#lm(formula = (prov_rate_male) ~ bs + spotiness + exp + male_age, 
#data = b)

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.60662 -0.34297 -0.06126  0.17032  0.83857 

#Coefficients:
#Estimate Std. Error t value Pr(>|t|)  
#(Intercept)  0.787922   0.348935   2.258   0.0342 *
#bs2          0.318567   0.281771   1.131   0.2704  
#bs3          0.315077   0.286807   1.099   0.2838  
#spotiness   -0.545260   0.984779  -0.554   0.5854  
#expyes      -0.235482   0.207289  -1.136   0.2682  
#male_age     0.002754   0.022561   0.122   0.9039  
#---
#Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.4256 on 22 degrees of freedom
#Multiple R-squared:  0.1365,	Adjusted R-squared:  -0.05979 
#F-statistic: 0.6953 on 5 and 22 DF,  p-value: 0.6325


m22 = lm((prov_rate_male) ~ bs
         + H_shell
        # +exp*H_shell
         +exp
         +male_age
         #+(1|birdID_male)
         , data=b
)

summary(m22)

#
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-0.6218 -0.3457 -0.0177  0.2084  0.7785 

##Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)     1.697849   1.771178   0.959    0.349
#bs2             0.333164   0.294460   1.131    0.271
#bs3             0.332918   0.314828   1.057    0.302
#H_shell        -7.970551  13.918960  -0.573    0.573
#expyes         -1.624930   1.940394  -0.837    0.412
#male_age        0.005599   0.022674   0.247    0.807
#H_shell:expyes  9.914328  14.366750   0.690    0.498

#Residual standard error: 0.4332 on 21 degrees of freedom
#Multiple R-squared:  0.1459,	Adjusted R-squared:  -0.09813 
#F-statistic: 0.5979 on 6 and 21 DF,  p-value: 0.7287
#
##without interaction

#Call:
#  lm(formula = (prov_rate_male) ~ bs + H_shell + exp + male_age, 
 #    data = b)

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.58878 -0.34937 -0.01972  0.19165  0.83034 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)  0.558214   0.632521   0.883    0.387
#bs2          0.280479   0.280984   0.998    0.329
#bs3          0.262551   0.294290   0.892    0.382
#H_shell      1.069677   4.647373   0.230    0.820
#expyes      -0.292625   0.192091  -1.523    0.142
#male_age     0.004682   0.022364   0.209    0.836

#Residual standard error: 0.428 on 22 degrees of freedom
#Multiple R-squared:  0.1265,	Adjusted R-squared:  -0.07198 
#F-statistic: 0.6374 on 5 and 22 DF,  p-value: 0.6735

m23 = lm((prov_rate_male) ~ bs
         + S_shell
         +exp*S_shell
         +exp
         +male_age
         #+(1|birdID_male)
         , data=b
)

summary(m23)

#Residuals:
#Min      1Q  Median      3Q     Max 
#-0.5686 -0.3237  0.0059  0.2397  0.7815 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)    -0.108676   1.008473  -0.108    0.915
#bs2             0.295260   0.281138   1.050    0.306
#bs3             0.327447   0.289574   1.131    0.271
#S_shell         2.177235   2.578650   0.844    0.408
#expyes          0.676850   1.059429   0.639    0.530
#male_age        0.005088   0.022928   0.222    0.827
#S_shell:expyes -2.719625   2.944513  -0.924    0.366

#Residual standard error: 0.4299 on 21 degrees of freedom
#Multiple R-squared:  0.1589,	Adjusted R-squared:  -0.08147 
#F-statistic: 0.661 on 6 and 21 DF,  p-value: 0.6816

##no interaction
##Residuals:
#Min       1Q   Median       3Q      Max 
#-0.59632 -0.34247 -0.02441  0.17682  0.89006 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)  0.645964   0.589175   1.096    0.285
#bs2          0.291632   0.280170   1.041    0.309
#bs3          0.284913   0.284932   1.000    0.328
#S_shell      0.100586   1.258423   0.080    0.937
#expyes      -0.285741   0.189708  -1.506    0.146
#male_age     0.005368   0.022849   0.235    0.816

#Residual standard error: 0.4285 on 22 degrees of freedom
#Multiple R-squared:  0.1247,	Adjusted R-squared:  -0.07425 
#F-statistic: 0.6268 on 5 and 22 DF,  p-value: 0.6811



m24 = lm((prov_rate_male) ~ bs
         + V_shell
        # +exp*V_shell
         +exp
         +male_age
         #+(1|birdID_male)
         , data=b
)

summary(m24)
#Residuals:
#Min      1Q  Median      3Q     Max 
#-0.5177 -0.3101 -0.1086  0.2974  0.7585 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)     2.814960   2.297258   1.225    0.234
#bs2             0.289910   0.271396   1.068    0.298
#bs3             0.333344   0.278195   1.198    0.244
#V_shell        -2.495938   2.707534  -0.922    0.367
#expyes         -3.946270   2.672640  -1.477    0.155
#male_age        0.002475   0.022263   0.111    0.913
#V_shell:expyes  4.418991   3.172668   1.393    0.178

#Residual standard error: 0.4173 on 21 degrees of freedom
#Multiple R-squared:  0.2076,	Adjusted R-squared:  -0.01884 
#F-statistic: 0.9168 on 6 and 21 DF,  p-value: 0.5024

#no interactions

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.63265 -0.36578 -0.04293  0.16558  0.83426 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)  0.088173   1.227361   0.072    0.943
#bs2          0.287550   0.277128   1.038    0.311
#bs3          0.276532   0.281006   0.984    0.336
#V_shell      0.723489   1.439788   0.502    0.620
#expyes      -0.234976   0.211936  -1.109    0.280
#male_age     0.002583   0.022733   0.114    0.911

#Residual standard error: 0.4261 on 22 degrees of freedom
#Multiple R-squared:  0.1344,	Adjusted R-squared:  -0.06237 
#F-statistic: 0.683 on 5 and 22 DF,  p-value: 0.6412



##now with fake
m25 = lm((prov_rate_male) ~ bs
         + spotiness_fake
     #  +exp*spotiness_fake
         +exp
         +male_age
         #+(1|birdID_male)
 
         , data=b
     
)

summary(m25)
#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.56114 -0.25468 -0.02256  0.20404  0.77321 

##Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)            0.948704   0.522027   1.817   0.0835 .
#bs2                    0.131479   0.328310   0.400   0.6929  
#bs3                    0.118244   0.306515   0.386   0.7035  
#spotiness_fake        -0.645216   2.578550  -0.250   0.8048  
#expyes                 0.055823   0.634148   0.088   0.9307  
#male_age               0.004633   0.021789   0.213   0.8337  
#spotiness_fake:expyes -2.810567   3.474679  -0.809   0.4277  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.4026 on 21 degrees of freedom
#Multiple R-squared:  0.2624,	Adjusted R-squared:  0.05171 
#F-statistic: 1.245 on 6 and 21 DF,  p-value: 0.3238

##no interaction

#Call:
#lm(formula = (prov_rate_male) ~ bs + spotiness_fake + exp + male_age, 
#   data = b)

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.55586 -0.30579 -0.05064  0.20516  0.80689 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)   
#(Intercept)     1.214923   0.402007   3.022  0.00626 **
#  bs2             0.291715   0.259744   1.123  0.27351   
#bs3             0.241072   0.264156   0.913  0.37134   
#spotiness_fake -2.426724   1.330346  -1.824  0.08175 . 
#expyes         -0.432175   0.193813  -2.230  0.03628 * 
#  male_age        0.000395   0.020983   0.019  0.98515   
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.3994 on 22 degrees of freedom
#Multiple R-squared:  0.2395,	Adjusted R-squared:  0.06661 
#F-statistic: 1.385 on 5 and 22 DF,  p-value: 0.2681


m26 = lm((prov_rate_male) ~ bs
         + H_shell_fake
         + exp*H_shell_fake
         +exp
         +male_age
         #+(1|birdID_male)
         , data=b
)

summary(m26)

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.65334 -0.35810  0.02707  0.20211  0.83603 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)           1.960865   1.709311   1.147    0.264
#bs2                   0.425378   0.329340   1.292    0.211
#bs3                   0.447429   0.347853   1.286    0.212
#H_shell_fake        -10.653239  13.556205  -0.786    0.441
#expyes               -4.950361   6.774568  -0.731    0.473
#male_age              0.006428   0.022534   0.285    0.778
#H_shell_fake:expyes  37.209815  54.884155   0.678    0.505

#Residual standard error: 0.4309 on 21 degrees of freedom
#Multiple R-squared:  0.1551,	Adjusted R-squared:  -0.08625 
#F-statistic: 0.6427 on 6 and 21 DF,  p-value: 0.6952

#no interaction

#Call:
#lm(formula = (prov_rate_male) ~ bs + H_shell_fake + exp + male_age, 
#   data = b)

#Residuals:
#  Min      1Q  Median      3Q     Max 
#-0.6196 -0.3502  0.0048  0.1729  0.8733 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)   1.552136   1.579700   0.983    0.337
#bs2           0.311173   0.279503   1.113    0.278
#bs3           0.319155   0.288290   1.107    0.280
#H_shell_fake -6.770072  12.134946  -0.558    0.583
#expyes       -0.360160   0.231657  -1.555    0.134
#male_age      0.005653   0.022227   0.254    0.802

#Residual standard error: 0.4255 on 22 degrees of freedom
#Multiple R-squared:  0.1366,	Adjusted R-squared:  -0.05957 
#F-statistic: 0.6964 on 5 and 22 DF,  p-value: 0.6318


m27 = lm((prov_rate_male) ~ bs
         + S_shell_fake
       #  +exp*S_shell_fake
         +exp
         +male_age
         #+(1|birdID_male)
         , data=b
)

summary(m27)

#Call:
#lm(formula = (prov_rate_male) ~ bs + S_shell_fake + exp * S_shell_fake + 
#     exp + male_age, data = b)

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.59284 -0.33431 -0.00876  0.26159  0.84776 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)         -0.070683   1.107871  -0.064    0.950
#bs2                  0.330654   0.289178   1.143    0.266
#bs3                  0.374543   0.311667   1.202    0.243
#S_shell_fake         2.020780   2.859148   0.707    0.487
#expyes               1.408150   2.673180   0.527    0.604
#male_age             0.003556   0.023931   0.149    0.883
#S_shell_fake:expyes -4.370929   6.561974  -0.666    0.513

#Residual standard error: 0.4322 on 21 degrees of freedom
#Multiple R-squared:   0.15,	Adjusted R-squared:  -0.09291 
#F-statistic: 0.6174 on 6 and 21 DF,  p-value: 0.7141

#Call:
#lm(formula = (prov_rate_male) ~ bs + S_shell_fake + exp + male_age, 
#   data = b)

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.57934 -0.34378 -0.01758  0.17901  0.87300 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)   0.289238   0.954859   0.303    0.765
#bs2           0.285682   0.277608   1.029    0.315
#bs3           0.291580   0.282063   1.034    0.312
#S_shell_fake  1.071750   2.447328   0.438    0.666
#expyes       -0.363710   0.261231  -1.392    0.178
#male_age      0.007404   0.022928   0.323    0.750

#Residual standard error: 0.4267 on 22 degrees of freedom
#Multiple R-squared:  0.132,	Adjusted R-squared:  -0.

m28 = lm((prov_rate_male) ~ bs
         + V_shell_fake
        # +exp*V_shell_fake
         +exp
         +male_age
         #+(1|birdID_male)
         , data=b
)

summary(m28)
#Call:
#lm(formula = (prov_rate_male) ~ bs + V_shell_fake + exp * V_shell_fake + 
#     exp + male_age, data = b)

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.57837 -0.34446  0.00887  0.20476  0.84358 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)          1.397985   2.524216   0.554    0.586
#bs2                  0.317048   0.310985   1.019    0.320
#bs3                  0.326873   0.322846   1.012    0.323
#V_shell_fake        -0.859934   2.976031  -0.289    0.775
#expyes               0.649203   8.744448   0.074    0.942
#male_age             0.004834   0.023695   0.204    0.840
#V_shell_fake:expyes -1.135905  10.370793  -0.110    0.914

#Residual standard error: 0.4374 on 21 degrees of freedom
#Multiple R-squared:  0.1294,	Adjusted R-squared:  -0.1193 
#F-statistic: 0.5202 on 6 and 21 DF,  p-value: 0.7865

#Call:
#lm(formula = (prov_rate_male) ~ bs + V_shell_fake + exp + male_age, 
#   data = b)

#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.57292 -0.34418 -0.00198  0.19352  0.85644 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)   1.475916   2.366856   0.624    0.539
#bs2           0.304205   0.281490   1.081    0.292
#bs3           0.315588   0.299015   1.055    0.303
#V_shell_fake -0.944400   2.809094  -0.336    0.740
#expyes       -0.308304   0.201470  -1.530    0.140
#male_age      0.005513   0.022349   0.247    0.807

#Residual standard error: 0.4274 on 22 degrees of freedom
#Multiple R-squared:  0.1289,	Adjusted R-squared:  -0.06907 
#F-statistic: 0.6511 on 5 and 22 DF,  p-value: 0.6637

sp=allEffects(m20)
plot(sp)


##nothing

# FOR FEMALES -------------------------------------------------------------

### provisioning rate
m29 = lm((prov_rate_female) ~ bs
          + spotiness
        #  +exp*spotiness
         +exp
         +female_age
              , data=b
)
summary(m29)

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.28216 -0.17964 -0.05789  0.05512  0.89561 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)       0.370469   0.370211   1.001   0.3295  
#bs2               0.286004   0.241192   1.186   0.2503  
#bs3               0.450452   0.235033   1.917   0.0705 .
#spotiness        -1.214125   1.843530  -0.659   0.5181  
#expyes            0.006456   0.488673   0.013   0.9896  
#female_age       -0.006509   0.017238  -0.378   0.7099  
#spotiness:expyes  0.247446   2.050270   0.121   0.9052  
#---
 # Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.3236 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.2123,	Adjusted R-squared:  -0.03648 
#F-statistic: 0.8533 on 6 and 19 DF,  p-value: 0.5456

##without interaction

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.28115 -0.18325 -0.06217  0.05428  0.89426 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)  0.33876    0.25432   1.332   0.1978  
#bs2          0.27430    0.21533   1.274   0.2173  
#bs3          0.44188    0.21844   2.023   0.0567 .
#spotiness   -1.01683    0.83094  -1.224   0.2353  
#expyes       0.06212    0.15756   0.394   0.6976  
#female_age  -0.00654    0.01681  -0.389   0.7013  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.3156 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.2117,	Adjusted R-squared:  0.01459 
#F-statistic: 1.074 on 5 and 20 DF,  p-value: 0.4042

m30 = lm((prov_rate_female) ~ bs
         + H_shell
   #      +exp*H_shell
         +exp
         +female_age,
          family=gaussian
         , data=b
)
summary(m30)

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.32456 -0.19985 -0.08051  0.14316  0.87379 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)     -2.205534   1.256721  -1.755   0.0954 .
#bs2              0.089781   0.209327   0.429   0.6728  
#bs3              0.225632   0.225694   1.000   0.3300  
#H_shell         18.491492   9.835674   1.880   0.0755 .
#expyes           2.644967   1.374743   1.924   0.0695 .
#female_age       0.001538   0.017543   0.088   0.9311  
#H_shell:expyes -20.066583  10.272655  -1.953   0.0657 .
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#
#Residual standard error: 0.306 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.2956,	Adjusted R-squared:  0.0731 
#F-statistic: 1.329 on 6 and 19 DF,  p-value: 0.2927

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.28338 -0.15050 -0.09333  0.04636  0.87682 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)  0.071328   0.501821   0.142    0.888
#bs2          0.199679   0.215351   0.927    0.365
#bs3          0.371614   0.227460   1.634    0.118
#H_shell      0.742076   4.021599   0.185    0.855
#expyes      -0.027360   0.144815  -0.189    0.852
#female_age  -0.003409   0.018541  -0.184    0.856

#Residual standard error: 0.3269 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1541,	Adjusted R-squared:  -0.05739 
#F-statistic: 0.7286 on 5 and 20 DF,  p-value: 0.6102

m31 = lm((prov_rate_female) ~ bs
         + S_shell
        # +exp*S_shell
         +exp
         +female_age
         , data=b
)
summary(m31)
#esiduals:
#Min       1Q   Median       3Q      Max 
#-0.36747 -0.15819 -0.09557  0.04363  0.87026 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)     1.106e+00  7.313e-01   1.512    0.147
#bs2             1.849e-01  2.109e-01   0.877    0.391
#bs3             3.162e-01  2.217e-01   1.426    0.170
#S_shell        -2.619e+00  1.925e+00  -1.360    0.190
#expyes         -9.808e-01  8.706e-01  -1.127    0.274
#female_age      7.921e-05  1.893e-02   0.004    0.997
#S_shell:expyes  2.676e+00  2.352e+00   1.138    0.269

#Residual standard error: 0.3204 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.2279,	Adjusted R-squared:  -0.01598 
#F-statistic: 0.9345 on 6 and 19 DF,  p-value: 0.4933

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.27162 -0.16840 -0.07900  0.03537  0.84272 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)  0.474920   0.480334   0.989    0.335
#bs2          0.197935   0.212087   0.933    0.362
#bs3          0.368570   0.218483   1.687    0.107
#S_shell     -0.786874   1.063109  -0.740    0.468
#expyes      -0.004013   0.146264  -0.027    0.978
#female_age  -0.006932   0.018029  -0.385    0.705

#Residual standard error: 0.3228 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1752,	Adjusted R-squared:  -0.03095 
#F-statistic: 0.8499 on 5 and 20 DF,  p-value: 0.5309
m32 = lm((prov_rate_female) ~ bs
         + V_shell
      #  +exp*V_shell
         +exp
         +female_age
         , data=b
)
summary(m32)

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.29374 -0.15778 -0.10289  0.07166  0.86586 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)     0.643407   1.838404   0.350    0.730  
#bs2             0.213452   0.216996   0.984    0.338  
#bs3             0.402336   0.225974   1.780    0.091 .
#V_shell        -0.552856   2.142638  -0.258    0.799  
#expyes         -1.401115   2.182180  -0.642    0.528  
#female_age     -0.006351   0.017920  -0.354    0.727  
#V_shell:expyes  1.697902   2.615198   0.649    0.524  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.3298 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1819,	Adjusted R-squared:  -0.07642 
#F-statistic: 0.7042 on 6 and 19 DF,  p-value: 0.65


#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.25149 -0.15851 -0.10754  0.04046  0.90889 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept) -0.35055    1.00298  -0.350    0.730
#bs2          0.20717    0.21362   0.970    0.344
#bs3          0.37734    0.21943   1.720    0.101
#V_shell      0.60440    1.17168   0.516    0.612
#expyes       0.01162    0.16214   0.072    0.944
#female_age  -0.00361    0.01716  -0.210    0.836

#Residual standard error: 0.325 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1638,	Adjusted R-squared:  -0.04529 
#F-statistic: 0.7834 on 5 and 20 DF,  p-value: 0.5735

####### FAKE EGGS FEMALES

m33 = lm((prov_rate_female) ~ bs
         + spotiness_fake
         #+exp*spotiness_fake
         +exp
         +female_age
         , data=b
)
summary(m33)



#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.33070 -0.16668 -0.06884  0.04012  0.90308 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)            0.339873   0.391497   0.868    0.396
#bs2                    0.184613   0.273371   0.675    0.508
#bs3                    0.360093   0.252349   1.427    0.170
#spotiness_fake        -0.759442   2.056633  -0.369    0.716
#expyes                -0.014656   0.535151  -0.027    0.978
#female_age            -0.004633   0.017338  -0.267    0.792
#spotiness_fake:expyes -0.378120   2.862744  -0.132    0.896

#Residual standard error: 0.3289 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1865,	Adjusted R-squared:  -0.07039 
#F-statistic: 0.726 on 6 and 19 DF,  p-value: 0.6342

#no interaction

#Residuals:
 # Min       1Q   Median       3Q      Max 
#-0.32584 -0.15686 -0.06821  0.04638  0.90590 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)     0.368925   0.315810   1.168   0.2565  
#bs2             0.206737   0.210675   0.981   0.3382  
#bs3             0.375948   0.216446   1.737   0.0978 .
#spotiness_fake -0.987061   1.094567  -0.902   0.3779  
#expyes         -0.082162   0.154724  -0.531   0.6013  
#female_age     -0.004563   0.016899  -0.270   0.7899  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.3207 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1858,	Adjusted R-squared:  -0.01781 
#F-statistic: 0.9125 on 5 and 20 DF,  p-value: 0.4928


m34 = lm((prov_rate_female) ~ bs
         + H_shell_fake
        #+ exp*H_shell_fake
         +exp
         +female_age
         , data=b
)
summary(m34)

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.32645 -0.20211 -0.07628  0.15685  0.78062 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)          -2.246304   1.195355  -1.879   0.0756 .
#bs2                  -0.013509   0.230164  -0.059   0.9538  
#bs3                   0.108719   0.245718   0.442   0.6632  
#H_shell_fake         19.680063   9.427363   2.088   0.0505 .
#expyes                7.111449   4.709010   1.510   0.1474  
#female_age           -0.001821   0.015591  -0.117   0.9082  
#H_shell_fake:expyes -56.700506  38.164458  -1.486   0.1538  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.2998 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.3238,	Adjusted R-squared:  0.1102 
#F-statistic: 1.516 on 6 and 19 DF,  p-value: 0.2262

#no interaction
#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.31994 -0.18657 -0.07761  0.09871  0.90389 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)  -1.621818   1.152293  -1.407    0.175
#bs2           0.158768   0.204733   0.775    0.447
#bs3           0.302698   0.214349   1.412    0.173
#H_shell_fake 13.798089   8.810191   1.566    0.133
#expyes        0.119408   0.165616   0.721    0.479
#female_age   -0.001358   0.016051  -0.085    0.933

#Residual standard error: 0.3088 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.2452,	Adjusted R-squared:  0.05652 
#F-statistic:   1.3 on 5 and 20 DF,  p-value: 0.3036




m35 = lm((prov_rate_female) ~ bs
         + S_shell_fake
 #        +exp*S_shell_fake
         +exp
         +female_age
         , data=b
)
summary(m35)

#Residuals:
#Min      1Q  Median      3Q     Max 
#-0.3914 -0.1625 -0.0967  0.1072  0.7852 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)          1.327600   0.796794   1.666    0.112
#bs2                  0.151933   0.214050   0.710    0.486
#bs3                  0.246831   0.237918   1.037    0.313
#S_shell_fake        -3.177026   2.106302  -1.508    0.148
#expyes              -2.114313   1.942347  -1.089    0.290
#female_age           0.001449   0.016715   0.087    0.932
#S_shell_fake:expyes  5.485457   4.801822   1.142    0.267

#Residual standard error: 0.3161 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.2483,	Adjusted R-squared:  0.01086 
#F-statistic: 1.046 on 6 and 19 DF,  p-value: 0.4276

#Residuals:
#Min       1Q   Median       3Q      Max 
#-0.29909 -0.16528 -0.07042  0.03796  0.92993 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)   0.813766   0.662692   1.228    0.234
#bs2           0.210697   0.209356   1.006    0.326
#bs3           0.366054   0.215430   1.699    0.105
#S_shell_fake -1.855947   1.773816  -1.046    0.308
#expyes        0.094857   0.182877   0.519    0.610
#female_age   -0.002066   0.016554  -0.125    0.902

#Residual standard error: 0.3185 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1966,	Adjusted R-squared:  -0.004224 
#F-statistic: 0.979 on 5 and 20 DF,  p-value: 0.4546



m36 = lm((prov_rate_female) ~ bs
         + V_shell_fake
       #  +exp*V_shell_fake
         +exp
         +female_age
         , data=b
)
summary(m36)
##Residuals:
#Min       1Q   Median       3Q      Max 
#-0.32963 -0.14352 -0.07641  0.02057  0.87528 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)
#(Intercept)          0.938976   1.954472   0.480    0.636
#bs2                  0.188297   0.240995   0.781    0.444
#bs3                  0.384846   0.262198   1.468    0.159
#V_shell_fake        -0.904781   2.281956  -0.396    0.696
#expyes              -1.964227   6.703344  -0.293    0.773
#female_age          -0.002087   0.017785  -0.117    0.908
#V_shell_fake:expyes  2.284482   7.965355   0.287    0.777

#Residual standard error: 0.3338 on 19 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1617,	Adjusted R-squared:  -0.103 
#F-statistic: 0.6109 on 6 and 19 DF,  p-value: 0.7188

#no interaction
##Residuals:
#Min       1Q   Median       3Q      Max 
#-0.30733 -0.14936 -0.08580  0.04552  0.89370 

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)  
#(Intercept)   0.822810   1.867658   0.441   0.6643  
#bs2           0.215149   0.216911   0.992   0.3331  
#bs3           0.413469   0.236833   1.746   0.0962 .
#V_shell_fake -0.789413   2.194080  -0.360   0.7228  
#expyes       -0.042202   0.150605  -0.280   0.7822  
#female_age   -0.002937   0.017129  -0.171   0.8656  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.3261 on 20 degrees of freedom
#(2 observations deleted due to missingness)
#Multiple R-squared:  0.1581,	Adjusted R-squared:  -0.05238 
#F-statistic: 0.7511 on 5 and 20 DF,  p-value: 0.595
