library(mstate)
library(brcarepred)
load("ERM.RData")
fitted <- msfit(fm, newdata=newdata, trans=tra)

## Predictions ER-

timepoints <- seq(from=0, to=20, by=0.25),
pt <- list()
pt[['DR']] <- getProbsDR(fm, group=1, newdata, timepoints=timepoints)
beta <- coef(m)['TLastSurgery.LR.NEG']
x <- newdata[8,'TLastSurgery.DR.NEG']
LR<- newdata[6,'TLastSurgery.LR.NEG']

pt[['LR']] <- getProbsLR(fm, group=1, newdata, timepoints=timepoints,
beta=beta, LR=LR, x=x, compact=F)

timepoints <- c(seq(from=0, to=15, by=0.25), 16:20)
	beta <- c(coef(m)['TLastSurgery.LR.NEG'], coef(m)['TLastSurgery.DR.NEG'])
	x <- c(newdata[6,'TLastSurgery.LR.NEG'], newdata[8,'TLastSurgery.DR.NEG'])
system.time(pt[['S']] <- getProbsS(m, group=1, newdata, timepoints=timepoints,
x=x, beta=beta, compact=FALSE))

save(pt, file="ERTP_NEG.RData")

## Predictions ER+

timepoints <- seq(from=0, to=20, by=0.25)
pt <- list()
pt[['DR']] <- getProbsDR(m, group=2, newdata, timepoints=timepoints)
	beta <- coef(m)['TLastSurgery.LR.POS']
	x <- newdata[17,'TLastSurgery.DR.POS']
	LR<- newdata[15,'TLastSurgery.LR.POS']

pt[['LR']] <- getProbsLR(m, group=2, newdata, timepoints=timepoints,
beta=beta, LR=LR, x=x, compact=F)

timepoints <- c(seq(from=0, to=15, by=0.25), 16:20)
	beta <- c(coef(m)['TLastSurgery.LR.POS'], coef(m)['TLastSurgery.DR.POS'])
	x <- c(newdata[15,'TLastSurgery.LR.POS'], newdata[17,'TLastSurgery.DR.POS'])
system.time(pt[['S']] <- getProbsS(m, group=2, newdata, timepoints=timepoints,
x=x, beta=beta, compact=FALSE))

save(pt, file="ERTP_POS.RData")