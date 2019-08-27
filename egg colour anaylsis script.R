##Egg data exploration - correlation testing,PCAs
setwd("~/Jasmine uni/Imperial/Summer project/Jasmine/Eggs/Geolocator eggs")
egg<-read.csv("alleggsnew2019_hsv.csv")
egg2<-read.csv("pcafinalnestshell.csv")

##I want to check that HSV components are correlated with particular RGB components
##should be as derived from RGB values
##As my study is seeing if blue/green eggs are provisioned more by parents when hatched(sexual signalling hypothesis)
##and some studies use brightness instead/as well as blue/green values
##therefore I want to see if brightness and Blue/green (and red) are correlated
##a study also mentioned saturation can be correlated with RGB colours so I am also exploring this
##To do this, I will do simple correlation tests and plots to visualise data.


require(ggplot2)

##Red shell vs Saturation - does saturation correlate with red?
cor.test(egg$mean_red_shell, egg$S_shell)
RSS<-plot(egg$mean_red_shell, egg$S_shell, xlab = "Red Shell", ylab="Shell Saturation", pch=20, col="red")
##significantly negative correlation
??col
RSS<-ggplot() + 
  geom_point(data=egg, aes(x=mean_red_shell, y=S_shell), color="red")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_red_shell, y=S_shell), color="red")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Saturation", x = "Red Shell")
RSS

##Red spot vs saturation
cor.test(egg$mean_red_spot, egg$S_spot)
plot(egg$mean_red_spot, egg$S_spot)
##significantly positive correlation

RSPS<-ggplot() + 
  geom_point(data=egg, aes(x=mean_red_spot, y=S_spot), color="red")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_red_spot, y=S_spot), color="red")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Spot Saturation", x = "Red Spot")
RSPS

##Red shell vs V (brightness)
cor.test(egg$mean_red_shell, egg$V_shell)
RSV<-plot(egg$mean_red_shell, egg$V_shell, xlab = "Red Shell", ylab="Shell Brightness", pch=20, col="red")
##Highly correlated! (0.99)

RSV<-ggplot() + 
  geom_point(data=egg, aes(x=mean_red_shell, y=V_shell), color="red")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_red_shell, y=V_shell), color="red")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Brightness", x = "Red Shell")
RSV

##Red spot vs V
cor.test(egg$mean_red_spot, egg$V_spot)
plot(egg$mean_red_spot, egg$V_spot)
##HIGHLY CORRELATION (CORR = 1)

RSPV<-ggplot() + 
  geom_point(data=egg, aes(x=mean_red_spot, y=V_spot), color="red")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_red_spot, y=V_spot), color="red")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Spot Brightness", x = "Red Spot")
RSPV

##Blue shell vs saturation

cor.test(egg$mean_blue_shell, egg$S_shell)
BSS<-plot(egg$mean_blue_shell, egg$S_shell,xlab = "Blue Shell", ylab="Shell Saturation", pch=20, col="blue")
##highly correlated - negative

BSS<-ggplot() + 
  geom_point(data=egg, aes(x=mean_blue_shell, y=S_shell), color="blue")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_blue_shell, y=S_shell), color="blue")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Saturation", x = "Blue Shell")
BSS
##blue vs hue
BHS<-ggplot() + 
  geom_point(data=egg, aes(x=mean_blue_shell, y=H_shell), color="blue")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_blue_shell, y=H_shell), color="blue")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Hue", x = "Blue Shell")
BHS

cor.test(egg$mean_blue_shell, egg$H_shell)

##Blue spot vs saturation
cor.test(egg$mean_blue_spot, egg$S_spot)
plot(egg$mean_blue_spot, egg$S_spot)
##weak negative correlation.

BSPS<-ggplot() + 
  geom_point(data=egg, aes(x=mean_blue_spot, y=S_spot), color="blue")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_blue_spot, y=S_spot), color="blue")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Spot Saturation", x = "Blue Spot")

BSPS

##Blue shell vs V
cor.test(egg$mean_blue_shell, egg$V_shell)
BSV<-plot(egg$mean_blue_shell, egg$V_shell, xlab = "Blue Shell", ylab="Shell Value", pch=20, col="blue")
##highly correlated (0.85)
##bluer eggs, higher V value, brighter
BSV<-ggplot() + 
  geom_point(data=egg, aes(x=mean_blue_shell, y=V_shell), color="blue")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_blue_shell, y=V_shell), color="blue")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Value", x = "Blue Shell")
BSV

##blue spot vs V
cor.test(egg$mean_blue_spot, egg$V_spot)
plot(egg$mean_blue_spot, egg$V_spot)
##still postively correlated, not as strong

BSPV<-ggplot() + 
  geom_point(data=egg, aes(x=mean_blue_spot, y=V_shell), color="blue")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_blue_spot, y=V_shell), color="blue")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Spot Brightness", x = "Blue Spot")
BSPV

##Green shell vs saturation
cor.test(egg$mean_green_shell, egg$S_shell)
GSS<-plot(egg$mean_green_shell, egg$S_shell, xlab = "Green Shell", ylab="Shell Saturation", pch=20, col="green")
##highly negative correlation
GSS<-ggplot() + 
  geom_point(data=egg, aes(x=mean_green_shell, y=S_shell), color="green")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_green_shell, y=S_shell), color="green")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Saturation", x = "Green Shell")
GSS

##Green spot vs saturation
cor.test(egg$mean_green_spot, egg$S_spot)
##not signifcantly correlated

GSPS<-ggplot() + 
  geom_point(data=egg, aes(x=mean_green_spot, y=S_spot), color="green")+
 theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Spot Saturation", x = "Green Spot")
GSPS

##Green shell vs V
cor.test(egg$mean_green_shell, egg$V_shell)
##highly correlated
GSV<-plot(egg$mean_green_shell, egg$V_shell,  xlab = "Green Shell", ylab="Shell Brightness", pch=20, col="green")
GSV<-ggplot() + 
  geom_point(data=egg, aes(x=mean_green_shell, y=V_shell), color="green")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_green_shell, y=V_shell), color="green")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Brightness", x = "Green Shell")
GSV

##Green spot vs V
cor.test(egg$mean_green_spot, egg$V_spot)
##high correlation
plot(egg$mean_green_spot, egg$V_spot)

GSPV<-ggplot() + 
  geom_point(data=egg, aes(x=mean_green_spot, y=V_spot), color="green")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=mean_green_spot, y=V_spot), color="green")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Spot Brightness", x = "Green Spot")

GSPV

##Plot shell 
require(gridExtra)
shell<-grid.arrange(BSS, BHS, BSV)
shell<-grid.arrange( arrangeGrob(RSV, GSV, BSV, top="RGB Shell vs Value/Brightness"), arrangeGrob(RSS, GSS, BSS, top="RGB Shell vs Saturation"), ncol=2)

##Plot spot

spot<-grid.arrange( arrangeGrob(RSPV, GSPV, BSPV, top="RGB Spot vs Value/Brightness"), arrangeGrob(RSPS, GSPS, BSPS, top="RGB Spot vs Saturation"), ncol=2)




##Shell Saturation vs Value (v)
cor.test(egg$S_shell, egg$V_shell)
##negatively correlated -0.6
plot(egg$S_shell, egg$V_shell)
##higher saturation, lower brightness
SV<-ggplot() + 
  geom_point(data=egg, aes(x=S_shell, y=V_shell), color="black")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=S_shell, y=V_shell), color="black")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Shell Brightness", x = "Shell Saturation")
SV

##Spot saturation vs value
cor.test(egg$S_spot, egg$V_spot)
plot(egg$S_spot, egg$V_spot)
##significantly positive correlation

SPSV<-ggplot() + 
  geom_point(data=egg, aes(x=S_spot, y=V_spot), color="black")+
  geom_smooth(data=egg, method="lm", se = FALSE, aes(x=S_spot, y=V_spot), color="black")+theme_bw()+
  theme(axis.text=element_text(size=12),panel.grid=element_blank())+
  labs(y="Spot Brightness", x = "Spot Saturation")
SPSV

satvalue<-grid.arrange( arrangeGrob(SV, top="Shell Saturation vs Value/Brightness"), arrangeGrob(SPSV, top="Spot Saturation vs Value/Brightness"), ncol=2)


##so saturation seems to be negatively correlated with RGB values in both shell and spot
##brightness is positively correlated with RGB values in both shell and spot
##however, less so in spot, where Green was not signficantly correlated and correlations
##are generally weaker
##therefore, brightness and blue green may both be good measures to use
##potentially just blue/green as literature mentions that brightness is good for 
##cavity nesting birds, where light is low

##Now Principle component analysis to see whether to use RGB or HSV 
##most of the variation between eggs and therefore should be considered


library("FactoMineR")
res.pca <- PCA(egg2, graph = FALSE)
eig.val <- get_eigenvalue(res.pca) # eigen values
eig.val  
##here you can see that dim. 1 and 2 explain most of the variablilty in the data (92%)
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))



var <- get_pca_var(res.pca) # graph with variables

var





fviz_pca_var(res.pca, col.var = "black")

