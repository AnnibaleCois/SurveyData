---
  class: hide_logo

## Sampling strategies: *disproportionate* sampling

.center[
  ```{r survey_3c, echo=FALSE}
  qtm(PROV, fill = "prov_code") + 
    qtm(POINTS[[1]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[2]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[3]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[4]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[5]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[6]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[7]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[8]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[9]], symbols.size = 0.5, symbols.col = "red") + 
    qtm(POINTS[[10]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[11]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[12]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[13]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[14]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[15]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[16]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[17]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[18]], symbols.size = 0.5, symbols.col = "red") + 
    tm_layout(legend.show = FALSE, frame = FALSE)  + tmap_options(max.categories = 53)  
  ```
]

???
  Disproportionate sampling 
PPS (probability proportional to size and self-weighting)

---
  class: hide_logo

## Sampling strategies: *disproportionate* sampling 

.center[
  ```{r survey_3d, echo=FALSE}
  
  set.seed(1234)
  SELECTED_DIST <- NULL
  SELECTED_PROV <- NULL
  DIST1 <- subset(DIST, !dist_code %in% c("CBDC2", "CBDC3", "CBDC4", "CBDC8"))
  
  for (p in unique(PROV$prov_code)) {
    D <- subset(DIST1, prov_code == p)
    SDIST <- D$dist_code[sample(nrow(D),2)]
    SELECTED_DIST <- c(SELECTED_DIST,SDIST)
    SELECTED_PROV <- c(SELECTED_PROV,p)
  }
  SELECTED_PROV <- rep(SELECTED_PROV, each = 2)
  
  PP <- POP2016
  PP$pop <- round(PP$pop/sum(PP$pop)*100/2,0)
  
  SELECTED_POINTS <- rep(NA, 18)
  for (i in c(1:18)) {
    SELECTED_POINTS[i] <- PP[PP$geo1 == SELECTED_PROV[i],]$pop
  }
  
  NP <- data.frame(SELECTED_DIST,SELECTED_POINTS)
  
  CDIST <- subset(DIST, dist_code %in% SELECTED_DIST)
  DIST$SELECTED <- DIST$dist_code %in% SELECTED_DIST
  POINTS <- rep(list(NA),18)
  
  for (i in c(1:18)) {
    dis <- unique(CDIST$dist_code)[i]
    D <- subset(CDIST, dist_code == dis)
    POINTS[[i]] <- spsample(as_Spatial(D), NP[NP$SELECTED_DIST == dis,]$SELECTED_POINTS, type = "random")
  }
  
  qtm(PROV, fill = "prov_code") + 
    qtm(POINTS[[1]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[2]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[3]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[4]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[5]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[6]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[7]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[8]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[9]], symbols.size = 0.5, symbols.col = "red") + 
    qtm(POINTS[[10]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[11]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[12]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[13]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[14]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[15]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[16]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[17]], symbols.size = 0.5, symbols.col = "red") +
    qtm(POINTS[[18]], symbols.size = 0.5, symbols.col = "red") + 
    tm_layout(legend.show = FALSE, frame = FALSE)  + tmap_options(max.categories = 53)  
  
  ```
]



---
  class: hide_logo

## A few notes (reality vs examples in a lecture...)

.pull-left[
  .content-box-red[
    .center[<img src = "images/enumeration.png"></img>]
  ]  
]

.pull-right[
  .content-box-blue[
    **Multiple**, nested, levels of clustering and stratification
  ]
  <br/>
    .content-box-green[
      *Finite populations*
    ]  
]

???
  Statistics South Africa enumeration areas (Free State) -> *large* number of clusters
Remember that (most of) statistical procedures rely on *asymptotic* properties... (at least in the frequentist approach)
*Combination* of different levels of clustering and stratification
*Finite populations* (sample is not  negligible compared to the population)
