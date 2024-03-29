#####################################

# scott's addition
cerc <- readxl::read_xlsx("data/religionGender.xlsx", na = "NA")


###############     formal education moderated mediation         ###############
############################################################################


#H12- Women are less exposed to secularizing forces via formal education. 
#As a result, years of formal education should predict less religiosity in both men and women. 
#Gender differences in exposure to formal education should mediate the relationship between gender and religiosity.
#This effect will not be moderated by need for social resources, material security or specific beliefs about the 
#nature of big or local gods. 

##

#1) Material insecurity
#2) children
#3) BGDIE
#4) Reward




#             Formal education
#           -                      -      - mmat/children/die/reward
#          -                        -  -
#         -                          -
#     Gender    ----------------->    Religiosity (commitment/ ritual/ prayer)


#### need to scale the moderators

#
cerc$MMAT.C <- scale(cerc$MMAT, center = TRUE, scale = FALSE)[,] # 1
cerc$CHILDREN.C <- scale(cerc$CHILDREN, center = TRUE, scale = FALSE)[,] # 2
cerc$BGDIE.C <- scale(cerc$BGDIE, center = TRUE, scale = FALSE)[,] # 3
cerc$BGREWARD.C <- scale(cerc$BGREWARD, center = TRUE, scale = FALSE)[,] # 4


######

### high and low mod

########################


low.mat.c = mean(cerc$MMAT.C, na.rm=T)-sd(cerc$MMAT.C, na.rm=T)
high.mat.c = mean(cerc$MMAT.C, na.rm=T)+sd(cerc$MMAT.C, na.rm=T)

low.children.c = mean(cerc$CHILDREN.C, na.rm=T)-sd(cerc$CHILDREN.C, na.rm=T)
high.children.c = mean(cerc$CHILDREN.C, na.rm=T)+sd(cerc$CHILDREN.C, na.rm=T)

### do at 0 or 1
low.bgdie.c = 0
high.bgdie.c = 1

low.bgreward.c = mean(cerc$BGREWARD.C, na.rm=T)-sd(cerc$BGREWARD.C, na.rm=T)
high.bgreward.c = mean(cerc$BGREWARD.C, na.rm=T)+sd(cerc$BGREWARD.C, na.rm=T)

##########################################


##  MMAT

############################################

## mediation regression- Does SEX have an effect on years of formal education, controlling for material insecurity and site
med.fit = lmer (FORMALED~  SEX + MMAT.C + (1|SITE), data = cerc)
summary(med.fit)

# outcome regression- effect of iv and mediatior w interactions, on religiosity
out.fit = lmer (PRAY ~ FORMALED + SEX + FORMALED*MMAT.C + (1|SITE) , data=cerc)
summary(out.fit)

### run mod med 
Mod.Med.Low.mat.c <- mediate(med.fit, out.fit,    
                             covariates = list(MMAT.C = low.mat.c),   
                             boot.ci.type = "bca", sims = 10, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.Low.mat.c)

Mod.Med.High.mat.c <- mediate(med.fit, out.fit,    
                              covariates = list(MMAT.C = high.mat.c),   
                              boot.ci.type = "bca", sims = 10, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.High.mat.c)
######################################


##########################################


##  Children

############################################

## mediation regression- Does SEX have an effect on years of formal education, controlling for material insecurity and site
med.fit = lmer (FORMALED~  SEX + CHILDREN.C + (1|SITE), data = cerc)
summary(med.fit)

# outcome regression- effect of iv and mediatior w interactions, on religiosity
out.fit = lmer (PRAY ~ FORMALED + SEX + FORMALED*CHILDREN.C + (1|SITE) , data=cerc)
summary(out.fit)

### run mod med 
Mod.Med.Low.mat.c <- mediate(med.fit, out.fit,    
                             covariates = list(CHILDREN.C= low.children.c),   
                             boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.Low.mat.c)

Mod.Med.High.mat.c <- mediate(med.fit, out.fit,    
                              covariates = list(CHILDREN.C = high.children.c),   
                              boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.High.mat.c)



##########################################


##  rewarding
############################################

## mediation regression- Does SEX have an effect on years of formal education, controlling for material insecurity and site
med.fit = lmer (FORMALED~  SEX + BGREWARD.C + (1|SITE), data = cerc)
summary(med.fit)

# outcome regression- effect of iv and mediatior w interactions, on religiosity
out.fit = lmer (PRAY ~ FORMALED + SEX + FORMALED*BGREWARD.C + (1|SITE) , data=cerc)
summary(out.fit)

### run mod med 
Mod.Med.Low.mat.c <- mediate(med.fit, out.fit,    
                             covariates = list(BGREWARD.C= low.bgreward.c),   
                             boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.Low.mat.c)

Mod.Med.High.mat.c <- mediate(med.fit, out.fit,    
                              covariates = list(BGREWARD.C = high.bgreward.c),   
                              boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.High.mat.c)



##########################################


##  BGDIE
############################################

## mediation regression- Does SEX have an effect on years of formal education, controlling for material insecurity and site
med.fit = lmer (FORMALED~  SEX + BGDIE + (1|SITE), data = cerc)
summary(med.fit)

# outcome regression- effect of iv and mediatior w interactions, on religiosity
out.fit = lmer (PRAY ~ FORMALED + SEX + FORMALED*BGDIE + (1|SITE) , data=cerc)
summary(out.fit)

### run mod med 
Mod.Med.Low.mat.c <- mediate(med.fit, out.fit,    
                             covariates = list(BGDIE= 0),   
                             boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.Low.mat.c)

Mod.Med.High.mat.c <- mediate(med.fit, out.fit,    
                              covariates = list(BGDIE =1),   
                              boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="FORMALED", dropobs = T)

summary(Mod.Med.High.mat.c)










######################################

#H14- The mediating effect of workforce participation on the gender gap will be strongest for gods 
#believed to be more rewarding and perceived to be able to influence life after death.


#            work     reward/die
#         -     -   -
#       -         -  
#      -            -
#   gender ----------->rel
#               |
#               |
#             reward/die


## moderators have to be centered? maybe not for the ACME method.
# do it anyway

cerc$BGREWARD.C
cerc$BGDIE.C
#####

######################


####    BGRWARD

###########################
## mediation regression- Does SEX have an effect on years of labour participation, controlling for bgreward
med.fit = lmer (labour~  SEX + BGREWARD.C + (1|SITE), data = cerc)
summary(med.fit)

# outcome regression- effect of iv and mediatior w interactions, on religiosity
out.fit = lmer (PRAY ~ labour + SEX*BGREWARD.C + labour*BGREWARD.C +(1|SITE) , data=cerc)
summary(out.fit)


low.bgreward.c = mean(cerc$BGREWARD.C, na.rm=T)-sd(cerc$BGREWARD.C, na.rm=T)
high.bgreward.c = mean(cerc$BGREWARD.C, na.rm=T)+sd(cerc$BGREWARD.C, na.rm=T)

###
### run mod med 
Mod.Med.Low.mat.c <- mediate(med.fit, out.fit,    
                             covariates = list(BGREWARD.C= low.bgreward.c),   
                             boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="labour", dropobs = T)

summary(Mod.Med.Low.mat.c)

Mod.Med.High.mat.c <- mediate(med.fit, out.fit,    
                              covariates = list(BGREWARD.C = high.bgreward.c),   
                              boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="labour", dropobs = T)

summary(Mod.Med.High.mat.c)


#####


######################


####    BGDIE

###########################
cerc$BGDIE.f = as.factor(cerc$BGDIE)

## mediation regression- Does SEX have an effect on years of labour participation, controlling for BGDIE
med.fit = lmer (labour~  SEX + BGDIE.f + (1|SITE), data = cerc)
summary(med.fit)

# outcome regression- effect of iv and mediatior w interactions, on religiosity
out.fit = lmer (PRAY ~ labour + SEX*BGDIE.f + labour*BGDIE.f +(1|SITE) , data=cerc)
summary(out.fit)


low.bgdie.f = 0
high.bgdie.f = 1
###
### run mod med 
Mod.Med.Low.mat.c <- mediate(med.fit, out.fit,    
                             covariates = list(BGDIE.f= low.bgdie.f),   
                             boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="labour", dropobs = T)

summary(Mod.Med.Low.mat.c)

Mod.Med.High.mat.c <- mediate(med.fit, out.fit,    
                              covariates = list(BGDIE.f= high.bgdie.f),   
                              boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="labour", dropobs = T)

summary(Mod.Med.High.mat.c)


###

#H17b- If we do not find support for H17a, one reason for this may be that religious participation
#and commitment are highly effective as allaying perceived food insecurity, 
#even among the poorest individuals in a group with limited ability to weather fluctuations in resource ability.
#Under this scenario, any mediating effect of income on the gender gap in perceived food insecurity should be 
#moderated by ritual participation and personal commitment to one’s deity.



#            income     rel
#         -     -   -
#       -         -  
#      -            -
#   gender ----------->mat insec
#               |
#               |
#             rel


### center moderators?

## mediation regression- Does SEX have an effect on years of labour participation, controlling for bgreward
med.fit = lmer (TOTALANNINC.USD_log~  SEX + PRAY + (1|SITE), data = cerc)
summary(med.fit)

# outcome regression- effect of iv and mediatior w interactions, on religiosity
out.fit = lmer (MMAT ~ TOTALANNINC.USD_log + SEX*PRAY + TOTALANNINC.USD_log*PRAY +(1|SITE) , data=cerc)
summary(out.fit)

####


######

### high and low mod

########################


low.BGINT = mean(cerc$BGINT, na.rm=T)-sd(cerc$BGINT, na.rm=T)
##high.BGINT = mean(cerc$BGINT, na.rm=T)+sd(cerc$BGINT, na.rm=T)
high.BGINT = 1

low.BGRIT = mean(cerc$BGRIT_std, na.rm=T)-sd(cerc$BGRIT_std, na.rm=T)
high.BGRIT = mean(cerc$BGRIT_std, na.rm=T)+sd(cerc$BGRIT_std, na.rm=T)

low.PRAY = mean(cerc$PRAY, na.rm=T)-sd(cerc$PRAY, na.rm=T)
#high.PRAY = mean(cerc$PRAY, na.rm=T)+sd(cerc$PRAY, na.rm=T)
high.PRAY =4



### run mod med 
Mod.Med.Low.mat.c <- mediate(med.fit, out.fit,    
                             covariates = list(PRAY= low.PRAY),   
                             boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="TOTALANNINC.USD_log", dropobs = T)

summary(Mod.Med.Low.mat.c)

Mod.Med.High.mat.c <- mediate(med.fit, out.fit,    
                              covariates = list(PRAY= high.PRAY),   
                              boot.ci.type = "bca", sims = 5000, treat="SEX", mediator="TOTALANNINC.USD_log", dropobs = T)

summary(Mod.Med.High.mat.c)
