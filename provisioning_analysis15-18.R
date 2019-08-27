rm(list=ls())
##Set wd
setwd("~/Jasmine uni/Imperial/Summer project/Jasmine")
prov_data<- read.csv ("Provisioning data 2015-2018.csv")

##Observational recordings of tern chick provisioning by parents during 2015-2018. Chicks had coloured stickers
##placed on their heads prior to observations. Stickers were placed on terns
##by people who were not involved in observational studies. This avoided bias
##as observers had no prior knowledge about chicks.
##One adult out of a pair was also painted, again to avoid bias 
##Observations of provisioning behaviour took place 5 times a week per nest, for two hours per session
##Columns:
##year =year of breeding season
##nest = nest number,corresponding to a particualar island and order of egg laying.
##eg island A = 100, b=200, c=300,d=400,e=500, f=500. The first nest (first egg laid)
##on island A would be 101
##male_ring is ring number, pat_age is male's age. same for female, except mat_age is female age
##date is when provisioning obsevations started. They occur for 2 hours a time, 5 times a week per nest.
##bout_time_start and end = time and end of observation
##time relates to time of an observed provision behaviour
##sticker is the colour of the sticker that was placed on a chick's head before behavioural observations
##apart from parents and nest numbers (eg which chick hatched first/sex/)
##chick ring is ring number of chick. Provided after field observations
##chick fate
##chick sex = 1=male, 2= female. Provided after field observations
##chick HO
##prov_painted is whether the parent bird that was painted gave food to the chick
##bird_painted is the name of the bird that was painted
##parent_prov is the bird that fed chick
##prey is the name of the prey item fed to the chick
##size is the size of the prey item, which is measured by determining
##size of prey relative to adult tern's bill, 
##eg if prey is size 0.5, it is half the length of the bill of the parent tern
##size is always in 0.5 increments
##success = whether eaten. (1=yes, 0=no)
##given = is whether it was given successfully to chick (1=yes, 0=no)
##given_fed_to_partner = if prey was given to partner. 1=yes 0=no
##Observer is observer name



##Experimental birds I need-subset data
#chio<-subset(prov_data, prov_data$parent_prov=="Chio")
#elvira<-subset(prov_data, prov_data$parent_prov=="Elvira")
#august<-subset(prov_data, prov_data$parent_prov=="August")
#lulu<-subset(prov_data, prov_data$parent_prov=="Lulu")
#karlson<-subset(prov_data, prov_data$parent_prov=="Karlson")
#princess<-subset(prov_data, prov_data$parent_prov=="Princess")
#roy<-subset(prov_data, prov_data$parent_prov=="Roy")
#nell<-subset(prov_data, prov_data$parent_prov=="Nell")
#larkin<-subset(prov_data, prov_data$parent_prov=="Larkin")
#kirk<-subset(prov_data, prov_data$parent_prov=="Kirk")
#kayley<-subset(prov_data, prov_data$parent_prov=="Kayley")
#russell<-subset(prov_data, prov_data$parent_prov=="Russell")
#pinelopi<-subset(prov_data, prov_data$parent_prov=="Pinelopi")
#abel<-subset(prov_data, prov_data$parent_prov=="Abel")
#dildo<-subset(prov_data, prov_data$parent_prov=="Dildo")
#cosima<-subset(prov_data, prov_data$parent_prov=="Cosima")
#linneus<-subset(prov_data, prov_data$parent_prov=="Linneus")
#indira<-subset(prov_data, prov_data$parent_prov=="Indira")
#gonzales<-subset(prov_data, prov_data$parent_prov=="Gonzales")
#sarina<-subset(prov_data, prov_data$parent_prov=="Sarina")
#blake<-subset(prov_data, prov_data$parent_prov=="Blake")
#jantje<-subset(prov_data, prov_data$parent_prov=="Jantje")
#lamar<-subset(prov_data, prov_data$parent_prov=="Lamar")
#tetje<-subset(prov_data, prov_data$parent_prov=="Tetje")
#hanno<-subset(prov_data, prov_data$parent_prov=="Hanno")
#rosemarie<-subset(prov_data, prov_data$parent_prov=="Rosemarie")
#finnegan<-subset(prov_data, prov_data$parent_pro=="Finnegan")
#benita<-subset(prov_data, prov_data$parent_prov=="Benita")
#arno<-subset(prov_data, prov_data$parent_prov=="Arno")
#gloria<-subset(prov_data, prov_data$parent_prov=="Gloria")
#luca<-subset(prov_data, prov_data$parent_prov=="Luca")
#anita<-subset(prov_data, prov_data$parent_prov=="Anita")
#satan<-subset(prov_data, prov_data$parent_prov=="Satan")
#melek<-subset(prov_data, prov_data$parent_prov=="Melek")
#no data on melek
#nongeo
#jarvis<-subset(prov_data, prov_data$parent_prov=="Jarvis")
#knuckles<-subset(prov_data, prov_data$parent_prov=="Knuckles")
#viola<-subset(prov_data, prov_data$parent_prov=="Viola")
#hamlet<-subset(prov_data, prov_data$parent_prov=="Hamlet")
#rihanna<-subset(prov_data, prov_data$parent_prov=="Rihanna")
#dilara<-subset(prov_data, prov_data$parent_prov=="Dilara")
#hasso<-subset(prov_data, prov_data$parent_prov=="Hasso")
#cathy<-subset(prov_data, prov_data$parent_prov=="Cathy")
#ismael<-subset(prov_data, prov_data$parent_prov=="Ismael")
#kirsty<-subset(prov_data, prov_data$parent_prov=="Kirsty")
#cupido<-subset(prov_data, prov_data$parent_prov=="Cupido")
#nebula<-subset(prov_data, prov_data$parent_prov=="Nebula")
#amrat<-subset(prov_data, prov_data$parent_prov=="Amrat")
#dory<-subset(prov_data, prov_data$parent_prov=="Dory")
#thies<-subset(prov_data, prov_data$parent_prov=="Thies")
#merula<-subset(prov_data, prov_data$parent_prov=="Merula")
#pinochio<-subset(prov_data, prov_data$parent_prov=="Pinochio")
#eclipse<-subset(prov_data, prov_data$parent_prov=="Eclipse")
#parmesan<-subset(prov_data, prov_data$parent_prov=="Parmesan")
#unnamed1<-subset(prov_data, prov_data$parent_prov=="7932306")
#unnamed2<-subset(prov_data, prov_data$parent_prov=="70003130")
#joanne<-subset(prov_data, prov_data$parent_prov=="Joanne")
#milhouse<-subset(prov_data, prov_data$parent_prov=="Milhouse")
#lisandra<-subset(prov_data, prov_data$parent_prov=="Lisandra")
#alcapone<-subset(prov_data, prov_data$parent_prov=="AlCapone")
#jofi<-subset(prov_data, prov_data$parent_prov=="Jofi")
##kirsty onwards, no provisioning info


##bind these together

#all<-rbind(chio, elvira,august,lulu, karlson,princess,roy,nell,larkin,kirk,kayley,russell,pinelopi,indira,
#         abel, dildo,cosima,linneus,gonzales,sarina,blake,jantje,lamar,tetje,hanno,rosemarie,finnegan, 
#         benita, dilara, arno, gloria, luca, anita,knuckles, viola,hamlet,jarvis, rihanna,hasso,cathy,ismael)

##years 2017/18 are what I need as these conincide with my egg data

#prov17<-subset(all, all$year=="2017")
#prov18<-subset(all, all$year=="2018")
#write.csv(prov17, "allnestsprovisioning17.csv")
#write.csv(prov18, "allnestsprovisioning18.csv")
##nest obvs hour totals from 2017, all birds 10 hours apart from dildo and cosima who were 8
##reload csv file with this added for both years
prov17<-read.csv("allnestsprovisioning17.csv")
prov18<-read.csv("allnestsprovisioning18.csv")

##find average provisioning rate. then merge this with average egg colour of eggs in a clutch by nest
##prov rate 17
chio17<-subset(prov17, prov17$parent_prov=="Chio")
##0

elvira17<-subset(prov17, prov17$parent_prov=="Elvira")
elvira17$prov_rate_hr=sum(elvira17$given==1)/elvira17$h

august17<-subset(prov17, prov17$parent_prov=="August")
##0

lulu17<-subset(prov17, prov17$parent_prov=="Lulu")
##0

karlson17<-subset(prov17, prov17$parent_prov=="Karlson")
##0

princess17<-subset(prov17, prov17$parent_prov=="Princess")
##0

roy17<-subset(prov17, prov17$parent_prov=="Roy")
roy17$prov_rate_hr=sum(roy17$given==1)/roy17$h

nell17<-subset(prov17, prov17$parent_prov=="Nell")
nell17$prov_rate_hr=sum(nell17$given==1)/nell17$h

larkin17<-subset(prov17, prov17$parent_prov=="Larkin")
larkin17$prov_rate_hr=sum(larkin17$given==1)/larkin17$h

kirk17<-subset(prov17, prov17$parent_prov=="Kirk")
#0

kayley17<-subset(prov17, prov17$parent_prov=="Kayley")
#0

russell17<-subset(prov17,prov17$parent_prov=="Russell")
russell17$prov_rate_hr=sum(russell17$given==1)/russell17$h

pinelopi17<-subset(prov17, prov17$parent_prov=="Pinelopi")
pinelopi17$prov_rate_hr=sum(pinelopi17$given==1)/pinelopi17$h

abel17<-subset(prov17, prov17$parent_prov=="Abel")
abel17$prov_rate_hr=sum(abel17$given==1)/abel17$h

dildo17<-subset(prov17, prov17$parent_prov=="Dildo")
dildo17$prov_rate_hr=sum(dildo17$given==1)/dildo17$h

cosima17<-subset(prov17, prov17$parent_prov=="Cosima")
cosima17$prov_rate_hr=sum(cosima17$given==1)/cosima17$h

linneus17<-subset(prov17, prov17$parent_prov=="Linneus")
linneus17$prov_rate_hr=sum(linneus17$given==1)/linneus17$h

indira17<-subset(prov17, prov17$parent_prov=="Indira")
indira17$prov_rate_hr=sum(indira17$given==1)/indira17$h

gonzales17<-subset(prov17, prov17$parent_prov=="Gonzales")
#0
gonzales18<-subset(prov18,prov18$parent_prov=="Gonzales")
#0

sarina17<-subset(prov17, prov17$parent_prov=="Sarina")
#0


blake17<-subset(prov17, prov17$parent_prov=="Blake")
blake17$prov_rate_hr=sum(blake17$given==1)/blake17$h

jantje17<-subset(prov17, prov17$parent_prov=="Jantje")
##0

lamar17<-subset(prov17, prov17$parent_prov=="Lamar")
lamar17$prov_rate_hr=sum(lamar17$given==1)/lamar17$h

tetje17<-subset(prov17, prov17$parent_prov=="Tetje")
tetje17$prov_rate_hr=sum(tetje17$given==1)/tetje17$h

hanno17<-subset(prov17, prov17$parent_prov=="Hanno")
#0
rosemarie17<-subset(prov17, prov17$parent_prov=="Rosemarie")
#0
finnegan17<-subset(prov17, prov17$parent_prov=="Finnegan")
finnegan17$prov_rate_hr=sum(finnegan17$given==1)/finnegan17$h


benita17<-subset(prov17, prov17$parent_prov=="Benita")
#0
arno17<-subset(prov17, prov17$parent_prov=="Arno")
#0
gloria17<-subset(prov17, prov17$parent_prov=="Gloria")
#0
luca17<-subset(prov17, prov17$parent_prov=="Luca")
luca17$prov_rate_hr=sum(luca17$given==1)/luca17$h

anita17<-subset(prov17, prov17$parent_prov=="Anita")
anita17$prov_rate_hr=sum(anita17$given==1)/anita17$h

##nongeo
jarvis17<-subset(prov17, prov17$parent_prov=="Jarvis")
#0
knuckles17<-subset(prov17, prov17$parent_prov=="Knuckles")
#0
viola17<-subset(prov17, prov17$parent_prov=="Viola")
#0
hamlet17<-subset(prov17, prov17$parent_prov=="Hamlet")
#0
rihanna17<-subset(prov17, prov17$parent_prov=="Rihanna")
#0
hasso17<-subset(prov17, prov17$parent_prov=="Hasso")
#0
cathy17<-subset(prov17, prov17$parent_prov=="Cathy")
#0
ismael17<-subset(prov17, prov17$parent_prov=="Ismael")
ismael17$prov_rate_hr=sum(ismael17$given==1)/ismael17$h

##no satan sata 2017

#no prov for dilara


apr17<-rbind(chio17, elvira17,august17,lulu17, karlson17,princess17,roy17,nell17,larkin17,kirk17,kayley17,russell17,pinelopi17,
         abel17, dildo17,cosima17,linneus17,gonzales17, indira17, sarina17,blake17,jantje17,lamar17,tetje17,hanno17,rosemarie17,finnegan17, 
         benita17, arno17, gloria17, luca17, anita17, jarvis17, knuckles17,viola17,hamlet17,
         rihanna17, hasso17, cathy17, ismael17)

write.csv(apr17, "average_provisioning_rategeoandnon17.csv")

##provisioning 2018
chio18<-subset(prov18, prov18$parent_prov=="Chio")
chio18$prov_rate_hr=sum(chio18$given==1)/chio18$h


elvira18<-subset(prov18, prov18$parent_prov=="Elvira")
elvira18$prov_rate_hr=sum(elvira18$given==1)/elvira18$h

august18<-subset(prov18, prov18$parent_prov=="August")
august18$prov_rate_hr=sum(august18$given==1)/august18$h

lulu18<-subset(prov18, prov18$parent_prov=="Lulu")
lulu18$prov_rate_hr=sum(lulu18$given==1)/lulu18$h

karlson18<-subset(prov18, prov18$parent_prov=="Karlson")
karlson18$prov_rate_hr=sum(karlson18$given==1)/karlson18$h

princess18<-subset(prov18, prov18$parent_prov=="Princess")
princess18$prov_rate_hr=sum(princess18$given==1)/princess18$h

roy18<-subset(prov18, prov18$parent_prov=="Roy")
roy18$prov_rate_hr=sum(roy18$given==1)/roy18$h

nell18<-subset(prov18, prov18$parent_prov=="Nell")
nell18$prov_rate_hr=sum(nell18$given==1)/nell18$h

larkin18<-subset(prov18, prov18$parent_prov=="Larkin")
larkin18$prov_rate_hr=sum(larkin18$given==1)/larkin18$h

kirk18<-subset(prov18, prov18$parent_prov=="Kirk")
kirk18$prov_rate_hr=sum(kirk18$given==1)/kirk18$h

kayley18<-subset(prov18, prov18$parent_prov=="Kayley")
kayley18$prov_rate_hr=sum(kayley18$given==1)/kayley18$h

russell18<-subset(prov18,prov18$parent_prov=="Russell")
russell18$prov_rate_hr=sum(russell18$given==1)/russell18$h

pinelopi18<-subset(prov18, prov18$parent_prov=="Pinelopi")
pinelopi18$prov_rate_hr=sum(pinelopi18$given==1)/pinelopi18$h

abel18<-subset(prov18, prov18$parent_prov=="Abel")
abel18$prov_rate_hr=sum(abel18$given==1)/abel18$h

dildo18<-subset(prov18, prov18$parent_prov=="Dildo")
dildo18$prov_rate_hr=sum(dildo18$given==1)/dildo18$h

cosima18<-subset(prov18, prov18$parent_prov=="Cosima")
cosima18$prov_rate_hr=sum(cosima18$given==1)/cosima18$h

linneus18<-subset(prov18, prov18$parent_prov=="Linneus")
linneus18$prov_rate_hr=sum(linneus18$given==1)/linneus18$h

indira18<-subset(prov18, prov18$parent_prov=="Indira")
indira18$prov_rate_hr=sum(indira18$given==1)/indira18$h

gonzales18<-subset(prov18,prov18$parent_prov=="Gonzales")
#0

sarina18<-subset(prov18, prov18$parent_prov=="Sarina")
sarina18$prov_rate_hr=sum(sarina18$given==1)/sarina18$h

blake18<-subset(prov18, prov18$parent_prov=="Blake")
blake18$prov_rate_hr=sum(blake18$given==1)/blake18$h

jantje18<-subset(prov18, prov18$parent_prov=="Jantje")
jantje18$prov_rate_hr=sum(jantje18$given==1)/jantje18$h


lamar18<-subset(prov18, prov18$parent_prov=="Lamar")
lamar18$prov_rate_hr=sum(lamar18$given==1)/lamar18$h

tetje18<-subset(prov18, prov18$parent_prov=="Tetje")
tetje18$prov_rate_hr=sum(tetje18$given==1)/tetje18$h

hanno18<-subset(prov18, prov18$parent_prov=="Hanno")
hanno18$prov_rate_hr=sum(hanno18$given==1)/hanno18$h

rosemarie18<-subset(prov18, prov18$parent_prov=="Rosemarie")
#0

finnegan18<-subset(prov18, prov18$parent_prov=="Finnegan")
finnegan18$prov_rate_hr=sum(finnegan18$given==1)/finnegan18$h


benita18<-subset(prov18, prov18$parent_prov=="Benita")
benita18$prov_rate_hr=sum(benita18$given==1)/benita18$h

arno18<-subset(prov18, prov18$parent_prov=="Arno")
arno18$prov_rate_hr=sum(arno18$given==1)/arno18$h

gloria18<-subset(prov18, prov18$parent_prov=="Gloria")
gloria18$prov_rate_hr=sum(gloria18$given==1)/gloria18$h

luca18<-subset(prov18, prov18$parent_prov=="Luca")
luca18$prov_rate_hr=sum(luca18$given==1)/luca18$h

anita18<-subset(prov18, prov18$parent_prov=="Anita")
anita18$prov_rate_hr=sum(anita18$given==1)/anita18$h

##nongeo
jarvis18<-subset(prov18, prov18$parent_prov=="Jarvis")
jarvis18$prov_rate_hr=sum(jarvis18$given==1)/jarvis18$h

knuckles18<-subset(prov18, prov18$parent_prov=="Knuckles")
knuckles18$prov_rate_hr=sum(knuckles18$given==1)/knuckles18$h

viola18<-subset(prov18, prov18$parent_prov=="Viola")
viola18$prov_rate_hr=sum(viola18$given==1)/viola18$h

hamlet18<-subset(prov18, prov18$parent_prov=="Hamlet")
hamlet18$prov_rate_hr=sum(hamlet18$given==1)/hamlet18$h

rihanna18<-subset(prov18, prov18$parent_prov=="Rihanna")
rihanna18$prov_rate_hr=sum(rihanna18$given==1)/rihanna18$h

hasso18<-subset(prov18, prov18$parent_prov=="Hasso")
hasso18$prov_rate_hr=sum(hasso18$given==1)/hasso18$h

cathy18<-subset(prov18, prov18$parent_prov=="Cathy")
cathy18$prov_rate_hr=sum(cathy18$given==1)/cathy18$h

ismael18<-subset(prov18, prov18$parent_prov=="Ismael")
ismael18$prov_rate_hr=sum(ismael18$given==1)/ismael18$h

dilara18<-subset(prov18, prov18$parent_prov=="Dilara")
dilara18$prov_rate_hr=sum(dilara18$given==1)/dilara18$h

apr18<-rbind(chio18, elvira18,august18,lulu18, karlson18,princess18,roy18,nell18,larkin18,kirk18,kayley18,russell18,pinelopi18,
             abel18, dildo18,cosima18,linneus18,gonzales18, indira18, sarina18,blake18,jantje18,lamar18,tetje18,hanno18,rosemarie18,finnegan18, 
             benita18, arno18, gloria18, luca18, anita18, jarvis18, knuckles18,viola18,hamlet18,
             rihanna18, hasso18, cathy18, ismael18, dilara18)

write.csv(apr17, "average_provisioning_rategeoandnon17.csv")



##provisioning data 19

p<-read.csv("provisioning2019.csv")
chio<-subset(p, p$prov_name=="Chio")
elvira<-subset(p, p$prov_name=="Elvira")
august<-subset(p, p$prov_name=="August")
lulu<-subset(p, p$prov_name=="Lulu")
karlson<-subset(p, p$prov_name=="Karlson")
princess<-subset(p, p$prov_name=="Princess")
roy<-subset(p, p$prov_name=="Roy")
nell<-subset(p, p$prov_name=="Nell")
larkin<-subset(p, p$prov_name=="Larkin")
kirk<-subset(p, p$prov_name=="Kirk")
kayley<-subset(p, p$prov_name=="Kayley")
russell<-subset(p, p$prov_name=="Russel")
pinelopi<-subset(p, p$prov_name=="Pinelopi")
abel<-subset(p, p$prov_name=="Abel")
dildo<-subset(p, p$prov_name=="Dildo")
cosima<-subset(p, p$prov_name=="Cosima")
linneus<-subset(p, p$prov_name=="Linneus ")
indira<-subset(p, p$prov_name=="Indira")
gonzales<-subset(p, p$prov_name=="Gonzales")
sarina<-subset(p, p$prov_name=="Sarina")
blake<-subset(p, p$prov_name=="Blake ")
jantje<-subset(p, p$prov_name=="Jantje")
lamar<-subset(p, p$prov_name=="Lamar")
tetje<-subset(p, p$prov_name=="Tetje")
hanno<-subset(p, p$prov_name=="Hanno")
rosemarie<-subset(p, p$prov_name=="Rosemarie")
finnegan<-subset(p, p$prov_name=="Finnegan")
benita<-subset(p, p$prov_name=="Benita")
arno<-subset(p, p$prov_name=="Arno")
gloria<-subset(p, p$prov_name=="Gloria")
luca<-subset(p, p$prov_name=="Luca")
anita<-subset(p, p$prov_name=="Anita")
unringed1<-subset(p, p$prov_name=="Unringed1")
unringed2<-subset(p, p$prov_name=="Unringed2")

##non geo
jarvis<-subset(p, p$prov_name=="Jarvis")
knuckles<-subset(p, p$prov_name=="Knuckles")
viola<-subset(p, p$prov_name=="Viola")
hamlet<-subset(p, p$prov_name=="Hamlet")
rihanna<-subset(p, p$prov_name=="Rihanna")
hasso<-subset(p, p$prov_name=="Hasso")
cathy<-subset(p, p$prov_name=="Cathy")
ismael<-subset(p, p$prov_name=="Ismael")
kirsty<-subset(p, p$prov_name=="Kirsty")
cupido<-subset(p, p$prov_name=="Cupido")
dilara<-subset(p, p$prov_name=="Dilara")
nebula<-subset(p, p$prov_name=="Nebula")
amrat<-subset(p, p$prov_name=="Amrat")
dory<-subset(p, p$prov_name=="Dory")
thies<-subset(p, p$prov_name=="Thies")
merula<-subset(p, p$prov_name=="Merula")
pinochio<-subset(p, p$prov_name=="Pinochio")
eclipse<-subset(p, p$prov_name=="Eclipse")
parmesan<-subset(p, p$prov_name=="Parmesan")
unnamed1<-subset(p, p$prov_name=="7932306")
unnamed2<-subset(p, p$prov_name=="70003130")
joanne<-subset(p, p$prov_name=="Joanne")
milhouse<-subset(p, p$prov_name=="Milhouse")
lisandra<-subset(p, p$prov_name=="Lisandra")
alcapone<-subset(p, p$prov_name=="AlCapone")
jofi<-subset(p, p$prov_name=="Jofi")

##none for lisandra

chio19<-subset(p, p$prov_name=="Chio")
chio19$prov_rate_hr=sum(chio19$success==1)/chio19$h

elvira19<-subset(p, p$prov_name=="Elvira")
elvira19$prov_rate_hr=sum(elvira19$success==1)/elvira19$h

august19<-subset(p, p$prov_name=="August")
august19$prov_rate_hr=sum(august19$success==1)/august19$h

lulu19<-subset(p, p$prov_name=="Lulu")
lulu19$prov_rate_hr=sum(lulu19$success==1)/lulu19$h

karlson19<-subset(p, p$prov_name=="Karlson")
karlson19$prov_rate_hr=sum(karlson19$success==1)/karlson19$h

princess19<-subset(p, p$prov_name=="Princess")
princess19$prov_rate_hr=sum(princess19$success==1)/princess19$h

roy19<-subset(p, p$prov_name=="Roy")
roy19$prov_rate_hr=sum(roy19$success==1)/roy19$h

nell19<-subset(p, p$prov_name=="Nell")
nell19$prov_rate_hr=sum(nell19$success==1)/nell19$h

larkin19<-subset(p, p$prov_name=="Larkin")
larkin19$prov_rate_hr=sum(larkin19$success==1)/larkin19$h

kirk19<-subset(p, p$prov_name=="Kirk")
kirk19$prov_rate_hr=sum(kirk19$success==1)/kirk19$h

kayley19<-subset(p, p$prov_name=="Kayley")
kayley19$prov_rate_hr=sum(kayley19$success==1)/kayley19$h

russell19<-subset(p, p$prov_name=="Russel")
russell19$prov_rate_hr=sum(russell19$success==1)/russell19$h

pinelopi19<-subset(p, p$prov_name=="Pinelopi")
pinelopi19$prov_rate_hr=sum(pinelopi19$success==1)/pinelopi19$h

abel19<-subset(p, p$prov_name=="Abel")
abel19$prov_rate_hr=sum(abel19$success==1)/abel19$h

dildo19<-subset(p, p$prov_name=="Dildo")
dildo19$prov_rate_hr=sum(dildo19$success==1)/dildo19$h

cosima19<-subset(p, p$prov_name=="Cosima")
cosima19$prov_rate_hr=sum(cosima19$success==1)/cosima19$h

linneus19<-subset(p, p$prov_name=="Linneus ")
linneus19$prov_rate_hr=sum(linneus19$success==1)/linneus19$h

indira19<-subset(p, p$prov_name=="Indira")
indira19$prov_rate_hr=sum(indira19$success==1)/indira19$h

gonzales19<-subset(p, p$prov_name=="Gonzales")
gonzales19$prov_rate_hr=sum(gonzales19$success==1)/gonzales19$h

sarina19<-subset(p, p$prov_name=="Sarina")
sarina19$prov_rate_hr=sum(sarina19$success==1)/sarina19$h

blake19<-subset(p, p$prov_name=="Blake ")
blake19$prov_rate_hr=sum(blake19$success==1)/blake19$h

jantje19<-subset(p, p$prov_name=="Jantje")
jantje19$prov_rate_hr=sum(jantje19$success==1)/jantje19$h

lamar19<-subset(p, p$prov_name=="Lamar")
lamar19$prov_rate_hr=sum(lamar19$success==1)/lamar19$h

tetje19<-subset(p, p$prov_name=="Tetje")
tetje19$prov_rate_hr=sum(tetje19$success==1)/tetje19$h

hanno19<-subset(p, p$prov_name=="Hanno")
hanno19$prov_rate_hr=sum(hanno19$success==1)/hanno19$h

rosemarie19<-subset(p, p$prov_name=="Rosemarie")
rosemarie19$prov_rate_hr=sum(rosemarie19$success==1)/rosemarie19$h

finnegan19<-subset(p, p$prov_name=="Finnegan")
finnegan19$prov_rate_hr=sum(finnegan19$success==1)/finnegan19$h

benita19<-subset(p, p$prov_name=="Benita")
benita19$prov_rate_hr=sum(benita19$success==1)/benita19$h

arno19<-subset(p, p$prov_name=="Arno")
arno19$prov_rate_hr=sum(arno19$success==1)/arno19$h

gloria19<-subset(p, p$prov_name=="Gloria")
gloria19$prov_rate_hr=sum(gloria19$success==1)/gloria19$h

luca19<-subset(p, p$prov_name=="Luca")
luca19$prov_rate_hr=sum(luca19$success==1)/luca19$h
#0
anita19<-subset(p, p$prov_name=="Anita")
anita19$prov_rate_hr=sum(anita19$success==1)/anita19$h
#0

#luca and anita no provisions (chicks died)

unringed119<-subset(p, p$prov_name=="Unringed1")
unringed119$prov_rate_hr=sum(unringed119$success==1)/unringed119$h

unringed219<-subset(p,p$prov_name=="Unringed2")
unringed219$prov_rate_hr=sum(unringed219$success==1)/unringed219$h
##nongeo
jarvis19<-subset(p, p$prov_name=="Jarvis")
jarvis19$prov_rate_hr=sum(jarvis19$success==1)/jarvis19$h

dilara19<-subset(p, p$prov_name=="Dilara")
dilara19$prov_rate_hr=sum(dilara19$success==1)/dilara19$h

knuckles19<-subset(p, p$prov_name=="Knuckles")
knuckles19$prov_rate_hr=sum(knuckles19$success==1)/knuckles19$h

viola19<-subset(p, p$prov_name=="Viola")
viola19$prov_rate_hr=sum(viola19$success==1)/viola19$h

hamlet19<-subset(p, p$prov_name=="Hamlet")
hamlet19$prov_rate_hr=sum(hamlet19$success==1)/hamlet19$h

rihanna19<-subset(p, p$prov_name=="Rihanna")
rihanna19$prov_rate_hr=sum(rihanna19$success==1)/rihanna19$h

hasso19<-subset(p, p$prov_name=="Hasso")
hasso19$prov_rate_hr=sum(hasso19$success==1)/hasso19$h

cathy19<-subset(p, p$prov_name=="Cathy")
cathy19$prov_rate_hr=sum(cathy19$success==1)/cathy19$h

ismael19<-subset(p, p$prov_name=="Ismael")
ismael19$prov_rate_hr=sum(ismael19$success==1)/ismael19$h

kirsty19<-subset(p, p$prov_name=="Kirsty ")
kirsty19$prov_rate_hr=sum(kirsty19$success==1)/kirsty19$h

cupido19<-subset(p, p$prov_name=="Cupido")
cupido19$prov_rate_hr=sum(cupido19$success==1)/cupido19$h

nebula19<-subset(p, p$prov_name=="Nebula")
nebula19$prov_rate_hr=sum(nebula19$success==1)/nebula19$h

amrat19<-subset(p, p$prov_name=="Amrat")
amrat19$prov_rate_hr=sum(amrat19$success==1)/amrat19$h

dory19<-subset(p, p$prov_name=="Dory")
dory19$prov_rate_hr=sum(dory19$success==1)/dory19$h

thies19<-subset(p, p$prov_name=="Thies")
thies19$prov_rate_hr=sum(thies19$success==1)/thies19$h

merula19<-subset(p, p$prov_name=="Merula")
merula19$prov_rate_hr=sum(merula19$success==1)/merula19$h

pinochio19<-subset(p, p$prov_name=="Pinochio")
pinochio19$prov_rate_hr=sum(pinochio19$success==1)/pinochio19$h

eclipse19<-subset(p, p$prov_name=="Eclipse")
eclipse19$prov_rate_hr=sum(eclipse19$success==1)/eclipse19$h

parmesan19<-subset(p, p$prov_name=="Parmesan")
parmesan19$prov_rate_hr=sum(parmesan19$success==1)/parmesan19$h

unnamed1<-subset(p, p$prov_name=="7932306")
unnamed1$prov_rate_hr=sum(unnamed1$success==1)/unnamed1$h

unnamed219<-subset(p, p$prov_name=="70003130")
unnamed219$prov_rate_hr=sum(unnamed219$success==1)/unnamed219$h

joanne19<-subset(p, p$prov_name=="Joanne")
joanne19$prov_rate_hr=sum(joanne19$success==1)/joanne19$h

milhouse19<-subset(p, p$prov_name=="Milhouse")
milhouse19$prov_rate_hr=sum(milhouse19$success==1)/milhouse19$h

lisandra19<-subset(p, p$prov_name=="Lisandra")
lisandra19$prov_rate_hr=sum(lisandra19$success==1)/lisandra19$h
#0
alcapone19<-subset(p, p$prov_name=="AlCapone")
alcapone19$prov_rate_hr=sum(alcapone19$success==1)/alcapone19$h

jofi19<-subset(p, p$prov_name=="Jofi")
jofi19$prov_rate_hr=sum(jofi19$success==1)/jofi19$h

satan19<-subset(p, p$prov_name=="Satan")
satan19$prov_rate_hr=sum(satan19$success==1)/satan19$h

melek19<-subset(p, p$prov_name=="Melek")
melek19$prov_rate_hr=sum(melek19$success==1)/melek19$h


apr19<-rbind(chio19, elvira19,august19,lulu19, karlson19,princess19,roy19,nell19,larkin19,kirk19,kayley19,russell19,pinelopi19,
                     abel19, dildo19,cosima19,linneus19, gonzales19, indira19, sarina19,blake19,jantje19,lamar19,tetje19,hanno19,rosemarie19,finnegan19, 
                     benita19, arno19, gloria19, luca19, anita19, satan19, melek19, jarvis19,knuckles19,viola19, hamlet19,
             rihanna19,hasso19, dilara19, cathy19,ismael19,kirsty19,cupido19,nebula19,amrat19,dory19,thies19,merula19,
             pinochio19,eclipse19,parmesan19,unnamed119,unnamed219,joanne19,
             unringed119, unringed219, milhouse19,lisandra19,alcapone19,jofi19)

##remove the columns where success = '0'
apr19<- apr19[ ! apr19$success %in% "0", ]
colnames(apr19)[1]="nest"
apr19$year=2019

write.csv(apr19, "average_provisioning_rategeoandnon19.csv")
##make each year into 1 row per adult (delete other rows)
##year, nest, adult, prov rate,

avperparent17<-apr17[,c(2,3,21,29)]
avperparent17<-unique(avperparent17)

avperparent18<-apr18[,c(2,3,21,29)]
avperparent18<-unique(avperparent18)

avperparent19<-apr19[,c(21,1, 9, 20)]
colnames(avperparent19)[3]="parent_prov"
avperparent19<-unique(avperparent19)

##add broodsize, sex and age, plus brood_type and nest to cross check which brood
##used in provisioning

adults<-read.csv("adults_info_1718.csv")
adults2<-adults[,c(3,4,6,7,12)]
adults2$age<-2019-adults2$birth_year
colnames(adults2)[1]="parent_prov"
##for 2017
adults17<-subset(adults2, adults2$year=="2017")
adults17<-adults17[-c(4)]
p17<-merge(avperparent17,adults17, by ="parent_prov")
##remove the brood sizes of zero (normally second clutches, but check to make sure on main file)
p17<- p17[ ! p17$max_brood_size %in% "0", ]

write.csv(p17, "finaladult17.csv")
##for 2018
#adults18<-subset(adults2, adults2$year=="2018")
#adults18<-adults18[-c(4)]
#p18<-merge(avperparent18,adults18, by ="parent_prov")
#p18<- p18[ ! p18$max_brood_size %in% "0", ]
##remove duplicates after saving to check with main file(brood size of 2 or 3)

#write.csv(p18, "finaladult18.csv")

#2019 age and sex
#adults19<-adults18[-c(4)]
#p19<-merge(adults19, avperparent19, by ="parent_prov")
#p19<-unique(p19)
#write.csv(p19, "finaladult19.csv")

##remember to add BROOD_SIZE and 2 unringed birds data



