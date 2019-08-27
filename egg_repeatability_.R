##repeatability for eggs

setwd("~/Jasmine uni/Imperial/Summer project/Jasmine/Eggs/Geolocator eggs")



# R package
library(rptR)
citation(package = "rptR")

# FILES -------------------------------------------------------------------

# 1. spot file
spot = read.csv ('spot_all.csv', head = TRUE, sep=",", na.strings = NA, fileEncoding="UTF-8-BOM") # N = 621
head(spot) 
summary(spot)


# 2. color file
col = read.csv ('col_all.csv',head=T,sep=",", na.strings = NA, fileEncoding="UTF-8-BOM") # N = 21735
head(col) 

summary(col)

## format

# 1. recalculate the egg spotiness PER PICTURE (percentage of the egg covered with spot)
#  divide the area of the spot by the area of the eggshell

spot$spotiness = spot$total_area_spot/spot$total_area_egg
head(spot)

# reduce the data to keep only what you need
spot = spot[,c(1:5,13)]


summary(spot)


# 2. format the color files
# get one value of R, B, G per picture for the spots, shell and background
# ==> calculte the means for the shell using the 5 values

# separate in 9 files

head(col)
length(col$year)

###### Red
red = subset(col, col$label=="Red") # N = 4347

# Red spot
red_sp = subset(red, red$zone=="spot") # N = 621
red_sp = red_sp[,c(1:5,11,12)]
colnames(red_sp)[6]="mean_red_spot"
colnames(red_sp)[7]="stddev_red_spot"
head(red_sp)

# Red background
red_ba = subset(red, red$zone=="background") # N = 621

red_ba = red_ba[,c(5,11,12)]
colnames(red_ba)[2]="mean_red_back"
colnames(red_ba)[3]="stddev_red_back"
head(red_ba)

# Red shell
red_sh = subset(red, red$zone=="shell") # N = 3105
red_sh = red_sh[,c(5,11,12)]
head(red_sh)
# calculate the mean values
t = aggregate(x = red_sh$mean, by = list(red_sh$slice), FUN = "mean") # N = 621
head(t)
colnames(t)[1]="slice"
colnames(t)[2]="mean_red_shell"
# calcule the standard deviation means
tt = aggregate(x = red_sh$stdev, by = list(red_sh$slice), FUN = "mean") # N = 621
colnames(tt)[1]="slice"
colnames(tt)[2]="stddev_red_shell"
head(tt)
red_sh = merge(tt, t, by="slice", all.x=T, all.y=T) # N = 621

head(red_sh)

# merge
red = merge(red_sp, red_ba, by="slice", all.x=T, all.y=T)
red = merge(red, red_sh, by="slice", all.x=T, all.y=T) # N = 621
head(red)

######  Blue
blue = subset(col, col$label=="Blue") # N = 4347

# blue spot
blue_sp = subset(blue, blue$zone=="spot") # N = 621
blue_sp = blue_sp[,c(5,11,12)]
colnames(blue_sp)[2]="mean_blue_spot"
colnames(blue_sp)[3]="stddev_blue_spot"
head(blue_sp)



# blue background
blue_ba = subset(blue, blue$zone=="background") # N = 621

blue_ba = blue_ba[,c(5,11,12)]
colnames(blue_ba)[2]="mean_blue_back"
colnames(blue_ba)[3]="stddev_blue_back"
head(blue_ba)

# blue shell
blue_sh = subset(blue, blue$zone=="shell ") # N = 3105
blue_sh = blue_sh[,c(5,11,12)]
head(blue_sh)
# calculate the mean values
t = aggregate(x = blue_sh$mean, by = list(blue_sh$slice), FUN = "mean") # N = 621
head(t)
colnames(t)[1]="slice"
colnames(t)[2]="mean_blue_shell"
# calcule the standard deviation means
tt = aggregate(x = blue_sh$stdev, by = list(blue_sh$slice), FUN = "mean") # N = 621
colnames(tt)[1]="slice"
colnames(tt)[2]="stddev_blue_shell"
head(tt)
blue_sh = merge(tt, t, by="slice", all.x=T, all.Y=T)
head(blue_sh)

# merge
blue = merge(blue_sp, blue_ba, by="slice", all.x=T, all.y=T) # N = 621
blue = merge(blue, blue_sh, by="slice", all.x=T, all.y=T)
head(blue)


###### Green
green = subset(col, col$label=="Green") # N = 4347

# green spot
green_sp = subset(green, green$zone=="spot") # N = 621
green_sp = green_sp[,c(5,11,12)]
colnames(green_sp)[2]="mean_green_spot"
colnames(green_sp)[3]="stddev_green_spot"
head(green_sp)

# green background
green_ba = subset(green, green$zone=="background") # N = 621
green_ba = green_ba[,c(5,11,12)]
colnames(green_ba)[2]="mean_green_back"
colnames(green_ba)[3]="stddev_green_back"
head(green_ba)

# green shell
green_sh = subset(green, green$zone=="shell ")# N = 4347
green_sh = green_sh[,c(5,11,12)]
head(green_sh)
# calculate the mean values
t = aggregate(x = green_sh$mean, by = list(green_sh$slice), FUN = "mean")
head(t)
colnames(t)[1]="slice"
colnames(t)[2]="mean_green_shell"
# calcule the standard deviation means
tt = aggregate(x = green_sh$stdev, by = list(green_sh$slice), FUN = "mean")
colnames(tt)[1]="slice"
colnames(tt)[2]="stddev_green_shell"
head(tt)

green_sh = merge(tt, t, by="slice", all.x=T, all.Y=T)
head(green_sh)

# merge
green = merge(green_sp, green_ba, by="slice", all.x=T, all.y=T)
green = merge(green, green_sh, by="slice", all.x=T, all.y=T) # N = 621
head(green)


### Merge the 3 files
color = merge(red, blue, by="slice", all.x=T, all.y=T)
color = merge(color, green, by="slice", all.x=T, all.y=T) # N = 621
head(color)
summary(color)




### merge the spot and the color files
head(spot)
spot$slice
color$slice
##spot = spot[,c(5,6)]
egg = merge(color, spot, by="slice", all.x=T, all.y=T) # N = 621
head(egg)
summary(egg) # one line per picture



# 3. Convert the RGB values to HSB

# this is done using the R function "rgb2hsv"
# rgb2hsv(r, g, b, maxColorValue = 255)

#Value (brightness) gives the amount of light in the color.
#Hue describes the dominant wavelength.
#Saturation is the amount of Hue mixed into the color.

### HSV shell
max(egg$mean_red_shell) # GL eggs 167.53814 #all 184.084 all+fake=184.084
max(egg$mean_green_shell) # GL eggs 167.664 #all 180.84 ##180.84
max(egg$mean_blue_shell) # GL eggs 133.802  # all154.194 ##154.194
hsv_sh = as.data.frame(rgb2hsv(r=egg$mean_red_shell, g=egg$mean_green_shell, b=egg$mean_blue_shell
                                 , maxColorValue=184.084))

head(hsv_sh)

# pivot the obtained file
h = as.data.frame(t(hsv_sh))
h

colnames(h)[1]="H_shell"
colnames(h)[2]="S_shell"
colnames(h)[3]="V_shell"

# add these three columns to the egg file
egg = as.data.frame(cbind(egg, h))
head(egg)



### HSV spot
max(egg$mean_red_spot) # 102.45 ##GL eggs 91.61 #all 100.54 ##all+fake 100.54
max(egg$mean_green_spot) # 87.92 ##GL eggs 81.88 #all 87.88 ##all+fake 91.36
max(egg$mean_blue_spot) # 74.05 ##GL eggs 67.3 #all 75.11 ##85.85

hsv_sp = as.data.frame(rgb2hsv(r=egg$mean_red_spot, g=egg$mean_green_spot, b=egg$mean_blue_spot
                               , maxColorValue=100.54))
hsv_sp

# pivot the obtained file
h = as.data.frame(t(hsv_sp))
h

colnames(h)[1]="H_spot"
colnames(h)[2]="S_spot"
colnames(h)[3]="V_spot"

# add these three columns to the egg file
egg = as.data.frame(cbind(egg, h))
head(egg)



### HSV background
max(egg$mean_red_back) # 232.61 ##gl eggs 228.56 +all, allfake=229.09
max(egg$mean_green_back) # 232.65 ##gl eggs 229.11+all, all+fake=229.52
max(egg$mean_blue_back) # 233.42  ##40 eggs 233.33+all +233.33
hsv_ba = as.data.frame(rgb2hsv(r=egg$mean_red_back, g=egg$mean_green_back, b=egg$mean_blue_back
                               , maxColorValue=233.33))
hsv_ba

# pivot the obtained file
h = as.data.frame(t(hsv_ba))
h

colnames(h)[1]="H_back"
colnames(h)[2]="S_back"
colnames(h)[3]="V_back"

# add these three columns to the egg file
egg = as.data.frame(cbind(egg, h))
head(egg)


# 4. calculate the standardized HSV values for spots and shells
# following Holveck et al 2012:
#standardized value of H of each spot from one picture was equal to
#''H of each spot of the focal picture'' minus the deviation, which
#was the absolute value of |''H mean of the back reference of all
#pictures'' minus ''H of the back reference of the focal picture''|.

###### standardized H shell
# calculate the mean H_back
m = mean(egg$H_back)
m # 0.6678587  ###40 eggs 0.6602584 ##GL eggs 0.6617423 ##all 0.6610923 ##0.6616715 allfake
# formula
egg$H_shell_std = egg$H_shell - (m-egg$H_back)
head(egg)

###### standardized H spot
# calculate the mean H_back
m = mean(egg$H_back)
m # 0.6678587 ##40 eggs 0.6602584 GL eggs 0.6617423
# formula
egg$H_spot_std = egg$H_spot - (m-egg$H_back)
head(egg)

###### standardized S shell
# calculate the mean S_back
m = mean(egg$S_back)
m # 0.004798686 ##40 eggs 0.01293327 #GL 0.01788223 ##all 0.0179802 ##al+fake=0.01594411
# formula
egg$S_shell_std = egg$S_shell - (m-egg$S_back)
head(egg)

###### standardized S spot
# calculate the mean S_back
m = mean(egg$S_back)
m # 0.004798686 ## 40 eggs 0.01293327 #gl 0.01788223
# formula
egg$S_spot_std = egg$S_spot - (m-egg$S_back)
head(egg)

###### standardized V shell
# calculate the mean V_back
m = mean(egg$V_back)
m # 0.9843737 ##40 eggs 0.9911885 ##0.9847975 ##0.9796989 all ##allfake 0.9798389
# formula
egg$V_shell_std = egg$V_shell - (m-egg$V_back)
head(egg)

###### standardized V spot
# calculate the mean V_back
m = mean(egg$V_back)
m # 0.9843737 ##0.9911885
# formula
egg$V_spot_std = egg$V_spot - (m-egg$V_back)
head(egg)



write.table(egg, "alleggsnew2019_hsv.csv", row.names=F, sep=",")



# ANALYSES ----------------------------------------------------------------

# file
#40 eggs
setwd("~/Jasmine uni/Imperial/Summer project/Jasmine/egg_methods/40 egg pictures")
jas=read.csv("egg_40_hsv.csv")
egg = read.csv("eggcombinedall.csv")
#egg = read.csv ('alleggsnew2019_hsv.csv',h=T,sep=",", na.strings = NA)  # N = 621
##20 - don't average yet
head(egg)
summary(egg)

##### format file

# change the egg number when it is o1, o2 or o3

summary(jas$egg_nr)

egg$egg_nr2 = egg$egg_nr
egg$egg_nr2 = ifelse(egg$egg_nr=="o1", 1, egg$egg_nr2)
egg$egg_nr2 = ifelse(egg$egg_nr=="o2", 2, egg$egg_nr2)
egg$egg_nr2 = ifelse(egg$egg_nr=="o3", 3, egg$egg_nr2)

summary(egg$egg_nr2)

# get the date of the pictures
egg2$date = as.factor(substr((as.character(egg$slice)), 1, 10))

# get the egg id
egg$egg_id = as.factor(paste(egg$nest_nr, egg$egg_nr2, sep="_"))

# get the picture id
egg$picture_id = as.factor(paste(egg$date, egg$egg_id, sep="_"))

summary(egg)
egg2<-aggregate(.~egg_id, FUN=mean, data=egg)
egg2<-egg2[-c(2,4,5, 44:47 )]
write.csv(egg2, "finaleggspernest.csv")

egg<-read.csv("alleggs2photos_hsv.csv")

egg
# 1. REPEATABILITY --------------------------------------------------------

# R package
library(rptR)


# 1.1 Repeatability between the two pictures taken in a same day -----------
egg<-
###### spotiness
require(rptR)
# the repeatability function
# so here the variable which is repeated and on which you want to calculate repetability is
# the picture id (i.e. date + egg number) 
##looking at spottiness measurement and repeatability between pics (1 and 2 of same egg)
rep_spot= rpt(spotiness ~ (1 | nest_nr), grname = "egg_id"
                      , data =egg, nboot = 1000, npermut = 1000)
rep_spot
summary(rep_spot)


##GL eggs 2019 = 0.948 between pics for spottiness ##0.957 all

###### H VALUES

### H SPOTS

head(egg)

# the repeatability function. H Spot per pic ID

rep_H_spot= rpt(H_spot ~ (1 | picture_id), grname = "picture_id"
                      , data = egg, nboot = 1000, npermut = 1000)
rep_H_spot
summary(rep_H_spot)
##GL eggs 2019= 0.972 ##all 0.971

### H SHELL

head(egg)

# the repeatability function. H Shell per pic ID

rep_H_shell= rpt(H_shell ~ (1 | picture_id), grname = "picture_id"
                        , data = jas, nboot = 1000, npermut = 1000)
rep_H_shell
summary(rep_H_shell)
##for gl eggs 2019 = 0.99 #all 0.991



###### S VALUES

### S SPOTS

head(egg)

# the repeatability function #S spot per pic ID

rep_S_spot= rpt(S_spot ~ (1 | picture_id), grname = "picture_id"
                        , data = egg, nboot = 1000, npermut = 1000) # it can take time...

rep_S_spot

summary(rep_S_spot)
##0.976 GL eggs 2019 ##0.963 all




### S SHELL

head(egg)

# the repeatability function S Shell per pic ID

rep_S_shell= rpt(S_shell ~ (1 | picture_id), grname = "picture_id"
                         , data = jas, nboot = 1000, npermut = 1000)
rep_S_shell
summary(rep_S_shell)

##0.988 GL eggs 2019 ##0.983

###### V VALUES

### V SPOTS

head(egg)

# the repeatability function

rep_V_spot= rpt(V_spot ~ (1 | picture_id), grname = "picture_id"
                , data = egg, nboot = 1000, npermut = 1000) # it can take time...

rep_V_spot
summary(rep_V_spot)

##0.926 for GL 2019 ##0.952 all

### V SHELL

head(egg)

# the repeatability function

rep_V_shell= rpt(V_shell ~ (1 | picture_id), grname = "picture_id"
                 , data = jas, nboot = 1000, npermut = 1000)
rep_V_shell
summary(rep_V_shell)
##0.929 GL eggs 2019 ##0.92 all

# OUR METHOD IS VALIDATED SINCE THE MEASURES GIVEN BY THE TWO PICTURES ARE HIGHLY REPEATABLE


##calculate the means - nest level means.
egg<-(read.csv("eggcombinedall.csv"))

summary(egg)
egg2<-aggregate(.~nest_nr, FUN=mean, data=egg)
egg2<-egg2[-c(2,4,5, 44:47 )]
write.csv(egg2, "finaleggsplusfakenestlevel.csv")


# 1.2 Repeatability between the egg parameters analysed by different persons -----------

# use the data obtained from the 40 pictures
# calculate the means between the two picture of a same egg (your data should have 20 lines)


egg2<-aggregate(.~nest_nr, FUN=mean, data=egg)
egg2<-egg2[-c(2,4,5, 44:47 )]

###### spotiness
# the repeatability function
# so here the variable which is repeated and on which you want to calculate repetability is
# the picture id (i.e. date + egg number)

# you shoud have 

rep_spot= rpt(spotiness ~ (1 | picture_id), grname = "picture_id"
              , data = egg, nboot = 1000, npermut = 1000)
rep_spot
summary(rep_spot)
##for 40eggs= R0.981, SE 0.00912, 2.5-97.5% = 0.957- and 0.991

##H spot

rep_H_spot= rpt(H_spot ~ (1 | picture_id), grname = "picture_id"
                , data = eggl, nboot = 1000, npermut = 1000)
rep_H_spot
summary(rep_H_spot)

##Repeatability for picture_id R  = 0.994 SE = 0.003 CI = [0.987, 0.997] P  = 4e-40 [LRT]0.001 [Permutation]



### H SHELL

# the repeatability function. H Shell per pic ID

rep_H_shell= rpt(H_shell ~ (1 | picture_id), grname = "picture_id"
                 , data = egg, nboot = 1000, npermut = 1000)
rep_H_shell
summary(rep_H_shell)

##Repeatability for picture_id R  = 0.986 SE = 0.007  CI = [0.966, 0.994] P  = 1.01e-32 [LRT]0.001 [Permutation]


###### S VALUES

### S SPOTS

head(egg)

# the repeatability function #S spot per pic ID

rep_S_spot= rpt(S_spot ~ (1 | picture_id), grname = "picture_id"
                , data = eggcombinedall, nboot = 1000, npermut = 1000) # it can take time...

rep_S_spot

##R  = 0.998 SE = 0.001 CI = [0.994, 0.999] P  = 4.52e-48 [LRT] 0.001 [Permutation]


summary(rep_S_spot)



### S SHELL

head(egg)

# the repeatability function S Shell per pic ID

rep_S_shell= rpt(S_shell ~ (1 | picture_id), grname = "picture_id"
                 , data = egg, nboot = 1000, npermut = 1000)
rep_S_shell
summary(rep_S_shell)

##Repeatability for picture_id R  = 0.983 SE = 0.008 CI = [0.96, 0.992] P  = 7.12e-32 [LRT] 0.001 [Permutation]



###### V VALUES

### V SPOTS

# the repeatability function

rep_V_spot= rpt(V_spot ~ (1 | picture_id), grname = "picture_id"
                , data = eggcombinedall, nboot = 1000, npermut = 1000) # it can take time...

rep_V_spot
summary(rep_V_spot)
##Repeatability for picture_id R  = 0.986 SE = 0.006 CI = [0.968, 0.993]P  = 9.63e-33 [LRT] 0.001 [Permutation]



### V SHELL

head(egg)

# the repeatability function

rep_V_shell= rpt(V_shell ~ (1 | picture_id), grname = "picture_id"
                 , data = egg, nboot = 1000, npermut = 1000)
rep_V_shell
summary(rep_V_shell)

##R  = 0.927 SE = 0.03 CI = [0.849, 0.963] P  = 1.72e-19 [LRT] 0.001 [Permutation]



### you should find a high repeatability meaning that the method is not "observer dependant"



# 1.3 Repeatability between the eggs of a same clutch -----------


### here you should use the whole data you have



head(egg)

# we have to calculate the mean values for each nest
# and we have to add the nest number

###### SPOTINESS

egg<-read.csv("finaleggspernest.2.csv")

t_spot = aggregate(x = egg$spotiness, by = list(egg$egg_id) # N = 266 = number of different eggs we have
head(t_spot)

colnames(t_spot)[1] = "egg_id"
colnames(t_spot)[2] = "spotiness"

t_spot$nest_id = as.factor(substr((as.character(t_spot$egg_id)), 1, 3))
summary(t_spot)

# keep the nests for which we have more than one egg
t_spot2 = as.data.frame(table(t_spot$nest_id))
t_spot2 = subset(t_spot2, t_spot2$Freq>1)
t_spot2 # N = 98
colnames(t_spot2)[1]="nest_id"

t_spot3 = merge(t_spot, t_spot2, by="nest_id", all.x=F, all.y=T) # N = 251
head(t_spot3)

# repeatability
require(rptR)
rep_spot_nest= rpt(spotiness ~ (1 | nest_id), grname = "nest_id",                  
                   data = egg, nboot = 1000, npermut = 1000)


rep_spot_nest
summary(rep_spot_nest)
####Repeatability for nest_id
#R  = 0.552
#SE = 0.065
#CI = [0.415, 0.664]
#P  = 2.38e-15 [LRT]
#0.001 [Permutation]



###for H shell

rep_H_nest= rpt(H_shell ~ (1 | nest_id), grname = "nest_id",                  
                   data = egg, nboot = 1000, npermut = 1000)



rep_H_nest
summary(rep_H_nest)
#Repeatability for nest_id
#R  = 0.752
#SE = 0.041
#CI = [0.661, 0.818]
#P  = 5.92e-31 [LRT]
#0.001 [Permutation]

##S shell

rep_S_nest= rpt(S_shell ~ (1 | nest_id), grname = "nest_id",                  
                data = egg, nboot = 1000, npermut = 1000)


rep_S_nest
summary(rep_S_nest)

#Repeatability for nest_id
#R  = 0.552
#SE = 0.064
#CI = [0.415, 0.662]
#P  = 8.26e-15 [LRT]
#0.001 [Permutation]


##Vshell

rep_V_nest= rpt(V_shell ~ (1 | nest_id), grname = "nest_id",                  
                data = egg, nboot = 1000, npermut = 1000)



rep_V_nest
summary(rep_V_nest)

#Repeatability for nest_id
#R  = 0.585
#SE = 0.063
#CI = [0.454, 0.694]
#P  = 4.41e-17 [LRT]
#0.001 [Permutation]



##spottiness 0.664 GL eggs 2019 ##0.62 for all eggs

### ==> by including the egg number (= laying order)
# get the egg number
t_spot3$egg_nr = as.factor(substr((as.character(t_spot3$egg_id)), 5, 5))
summary(t_spot3)

# delete the egg nr = 4
t_spot3 = subset(t_spot3, t_spot3$egg_nr!="4") # N = 250

# repeatability
rep_spot_nest2= rpt(spotiness ~ (1 | nest_id) + egg_nr, grname = "nest_id"
                    , data = t_spot3, nboot = 1000, npermut = 1000)
rep_spot_nest2
summary(rep_spot_nest2)

##0.676 GL eggs 2019 ##0.617

##t_spot3
##### H VALUES

head(egg)

### H SHELL

t_H = aggregate(x = egg$H_shell, by = list(egg$egg_id), FUN = "mean") # N = 266
head(t_H)

colnames(t_H)[1] = "egg_id"
colnames(t_H)[2] = "H_shell"

t_H$nest_id = as.factor(substr((as.character(t_H$egg_id)), 1, 3))

# keep the nests for which we have more than one egg
t_H2 = merge(t_H, t_spot2, by="nest_id", all.x=F, all.y=T) # N = 251

# repeatability
rep_H_shell_nest= rpt(H_shell ~ (1 | nest_id), grname = "nest_id"
                      , data = t_H2, nboot = 1000, npermut = 1000)
rep_H_shell_nest
summary(rep_H_shell_nest)
##0.834 geo 2019 ##0.804

### ==> by including the egg number (= laying order)
# get the egg number
t_H2$egg_nr = as.factor(substr((as.character(t_H2$egg_id)), 5, 5))
summary(t_H2)

# delete the egg nr = 4
t_H3 = subset(t_H2, t_H2$egg_nr!="4") # N = 250

# repeatability
rep_H_shell_nest2= rpt(H_shell ~ (1 | nest_id) + egg_nr, grname = "nest_id"
                       , data = t_H3, nboot = 1000, npermut = 1000)
rep_H_shell_nest2
summary(rep_H_shell_nest2)
##0.827 gl eggs 2019
##t_H3

### H SPOT

t_H = aggregate(x = egg$H_spot, by = list(egg$egg_id), FUN = "mean") # N = 266
head(t_H)

colnames(t_H)[1] = "egg_id"
colnames(t_H)[2] = "H_spot"

t_H$nest_id = as.factor(substr((as.character(t_H$egg_id)), 1, 3))

# keep the nests for which we have more than one egg
t_H2 = merge(t_H, t_spot2, by="nest_id", all.x=F, all.y=T) # N = 251

# repeatability
rep_H_spot_nest= rpt(H_spot ~ (1 | nest_id), grname = "nest_id"
                     , data = t_H2, nboot = 1000, npermut = 1000)
rep_H_spot_nest
summary(rep_H_spot_nest)

##0.598 gl eggs 2019
### ==> by including the egg number (= laying order)
# get the egg number
t_H2$egg_nr = as.factor(substr((as.character(t_H2$egg_id)), 5, 5))
summary(t_H2)

# delete the egg nr = 4
t_H3 = subset(t_H2, t_H2$egg_nr!="4") # N = 250

# repeatability
rep_H_spot_nest2= rpt(H_spot ~ (1 | nest_id) + egg_nr, grname = "nest_id"
                      , data = t_H3, nboot = 1000, npermut = 1000)
rep_H_spot_nest2
summary(rep_H_spot_nest2)

##0.759 gl eggs
##t_H3 

##### S VALUES

head(egg)

### S SHELL

t_S = aggregate(x = egg$S_shell, by = list(egg$egg_id), FUN = "mean") # N = 266
head(t_S)

colnames(t_S)[1] = "egg_id"
colnames(t_S)[2] = "S_shell"

t_S$nest_id = as.factor(substr((as.character(t_S$egg_id)), 1, 3))
summary(t_S)

# keep the nests for which we have more than one egg
t_S2 = merge(t_S, t_spot2, by="nest_id", all.x=F, all.y=T) # N = 251

# repeatability
rep_S_shell_nest= rpt(S_shell ~ (1 | nest_id), grname = "nest_id"
                      , data = t_S2, nboot = 1000, npermut = 1000)
rep_S_shell_nest
summary(rep_S_shell_nest)

##0.747
### ==> by including the egg number (= laying order)
# get the egg number
t_S2$egg_nr = as.factor(substr((as.character(t_S2$egg_id)), 5, 5))
summary(t_S2)

# delete the egg nr = 4
t_S3 = subset(t_S2, t_H2$egg_nr!="4") # N = 250


# repeatability
rep_S_shell_nest2= rpt(S_shell ~ (1 | nest_id) + egg_nr, grname = "nest_id"
                       , data = t_S3, nboot = 1000, npermut = 1000)
rep_S_shell_nest2
summary(rep_S_shell_nest2)

##0.743

### S SPOT

t_S = aggregate(x = egg$S_spot, by = list(egg$egg_id), FUN = "mean") # N = 266
head(t_S)

colnames(t_S)[1] = "egg_id"
colnames(t_S)[2] = "S_spot"

t_S$nest_id = as.factor(substr((as.character(t_S$egg_id)), 1, 3))

# keep the nests for which we have more than one egg
t_S2 = merge(t_S, t_spot2, by="nest_id", all.x=F, all.y=T) # N = 251

# repeatability
rep_S_spot_nest= rpt(S_spot ~ (1 | nest_id), grname = "nest_id"
                     , data = t_S, nboot = 1000, npermut = 1000)
rep_S_spot_nest
summary(rep_S_spot_nest)

##S spot - less repeatable - 0.322

### ==> by including the egg number (= laying order)
# get the egg number
t_S2$egg_nr = as.factor(substr((as.character(t_S2$egg_id)), 5, 5))
summary(t_S2)

# delete the egg nr = 4
t_S3 = subset(t_S2, t_H2$egg_nr!="4") # N = 250

# repeatability
rep_S_spot_nest2= rpt(S_spot ~ (1 | nest_id) + egg_nr, grname = "nest_id"
                      , data = t_S3, nboot = 1000, npermut = 1000)
rep_S_spot_nest2
summary(rep_S_spot_nest2)
##0.352

##### V VALUES

head(egg)

### V SHELL

t_V = aggregate(x = egg$V_shell, by = list(egg$egg_id), FUN = "mean") # N = 266
head(t_V)

colnames(t_V)[1] = "egg_id"
colnames(t_V)[2] = "V_shell"

t_V$nest_id = as.factor(substr((as.character(t_V$egg_id)), 1, 3))
summary(t_V)

# keep the nests for which we have more than one egg
t_V2 = merge(t_V, t_spot2, by="nest_id", all.x=F, all.y=T) # N = 251

# repeatability
rep_V_shell_nest= rpt(V_shell ~ (1 | nest_id), grname = "nest_id"
                      , data = t_V2, nboot = 1000, npermut = 1000)
rep_V_shell_nest
summary(rep_V_shell_nest)

### ==> by including the egg number (= laying order)
# get the egg number
t_V2$egg_nr = as.factor(substr((as.character(t_V2$egg_id)), 5, 5))
summary(t_V2)

##0.59

# delete the egg nr = 4
t_V3 = subset(t_V2, t_V2$egg_nr!="4") # N = 250

# repeatability
rep_V_shell_nest2= rpt(V_shell ~ (1 | nest_id) + egg_nr, grname = "nest_id"
                       , data = t_V3, nboot = 1000, npermut = 1000)
rep_V_shell_nest2
summary(rep_V_shell_nest2)
##0.61

### V SPOT

t_V = aggregate(x = egg$V_spot, by = list(egg$egg_id), FUN = "mean") # N = 266
head(t_V)

colnames(t_V)[1] = "egg_id"
colnames(t_V)[2] = "V_spot"

t_V$nest_id = as.factor(substr((as.character(t_V$egg_id)), 1, 3))
summary(t_V)

# keep the nests for which we have more than one egg
t_V2 = merge(t_V, t_spot2, by="nest_id", all.x=F, all.y=T) # N = 251

# repeatability
rep_V_spot_nest= rpt(V_spot ~ (1 | nest_id), grname = "nest_id"
                     , data = t_V2, nboot = 1000, npermut = 1000)
rep_V_spot_nest
summary(rep_V_spot_nest)

##0.549
### ==> by including the egg number (= laying order)
# get the egg number
t_V2$egg_nr = as.factor(substr((as.character(t_V2$egg_id)), 5, 5))
summary(t_V2)

# delete the egg nr = 4
t_V3 = subset(t_V2, t_V2$egg_nr!="4") # N = 250

# repeatability
rep_V_spot_nest2= rpt(V_spot ~ (1 | nest_id) + egg_nr, grname = "nest_id"
                      , data = t_V3, nboot = 1000, npermut = 1000)

rep_V_spot_nest2
summary(rep_V_spot_nest2)
##0.542


##repeatability between eggs within a clutch for hsv for SHELL is between 0.59-0.82. V is less repeatable
##repeatability for hsv for SPOTs is between 0.35-0.82. spots are less repeatable.






