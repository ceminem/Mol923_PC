

duplicates <- duplicated(FAP_all)
sum(duplicates)  # This tells you HOW MANY duplicates
#4 duplicates






Option 1: Use Midpoint Rooting (Recommended for Your Report)

Since you don't have species information readily available, the most practical approach is to use midpoint rooting. This is completely acceptable and commonly used in phylogenetic analyses when outgroup information is unavailable.

​

r
library(phangorn)

# Midpoint root your tree
tree_rooted <- midpoint(fit$tree)

# Plot with bootstrap filtering
plotBS(tree_rooted, 
       trees = fit$bs,
       p = 70,              # Only show bootstrap > 70%
       type = "phylogram",
       cex = 0.6,           # Adjust label size
       main = "Maximum Likelihood Tree of FAP Sequences")

add.scale.bar()


head(mt, 5)
 Model df    logLik      AIC
1        WAG 63 -18678.95 37483.90
2      WAG+I 64 -18581.27 37290.54
3   WAG+G(4) 64 -18333.38 36794.76
4 WAG+G(4)+I 65 -18320.26 36770.52
5        JTT 63 -18899.60 37925.19
           AICw     AICc         AICcw
1 1.231348e-155 37499.23 2.074524e-155
2 1.197702e-113 37306.39 1.558333e-113
3  5.452270e-06 36810.61  7.093960e-06
4  9.999945e-01 36786.89  9.999929e-01
5 1.845146e-251 37940.52 3.108624e-251
       BIC
1 37759.85
2 37570.87
3 37075.09
4 37055.23
5 38201.14









# 1. Open the SVG device
svg("fig/my_tree_final.svg", width = 10, height = 8)

# 2. Run your plotting code
plotBS(tree_rooted, 
       trees = fit$bs, 
       p = 70, 
       type = "phylogram",
       main = "Maximum Likelihood Tree",
       cex = 0.6)

add.scale.bar()

# 3. Close the device
dev.off()
