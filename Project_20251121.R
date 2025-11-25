animal_data = data.frame(
  animal = c("dog", "cat", "sea cucumber", "sea urchin"),
  feel = c("furry", "squishy", "squishy" ,"spiny"),
  weight = c(45, 8, 1.1, 0.8)
)

country_climate <- data.frame(
  country = c("Canada", "Panama", "South Africa", "Australia"),
  climate = c("cold", "hot", "temperate", "hot/temperate"),
  temperature = c(10, 30, 18, "15"),
  northern_hemisphere = c(TRUE, TRUE, FALSE, "FALSE"),
  has_kangaroo = c(FALSE, FALSE, FALSE, 1)
)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
surveys <- na.omit(surveys)
surveys$taxa <- factor(surveys$taxa)
surveys$genus <- factor(surveys$genus)
surveys$sex <- factor(surveys$sex)
surveys$species <- factor(surveys$species)
summary(surveys)

(n <- nlevels(surveys$genus)) # number of genera
(lev <- levels(surveys$genus)) # different genera
col_vec <- hcl.colors(n, palette = "Dark 3")
names(col_vec) <- lev
plot(weight ~ hindfoot_length, data=surveys,
     col=col_vec[genus], main="Scatter plot")
legend("topleft", legend=lev, pch=21, pt.bg=col_vec[lev])

op <- par(mar=c(5,8,4,2)) # increase left margin
plot(weight ~ genus, data=surveys, horizontal=TRUE, las=1, 
     col=col_vec[lev], main="Boxplot", xlab="")

ggplot(surveys, aes(x = weight, y = genus, fill = col_vec[genus])) +
  geom_density_ridges() +
  theme_ridges()

t.test(hindfoot_length ~ sex, data=surveys)
wilcox.test(weight ~ sex, data=surveys)

t.test(hindfoot_length ~ sex, data=surveys[surveys$genus=="Perognathus", ])

wilcox.test(hindfoot_length ~ sex, data=surveys[surveys$genus=="Perognathus", ])

plot(hindfoot_length ~ sex, data=surveys[surveys$genus=="Perognathus", ])

x_samples <- 50
x_mean <- 1
x_sd <- 1
y_samples <- 50
y_mean <- 1.2
y_sd <- 1

x <- rnorm(x_samples, mean = x_mean, sd = x_sd)
y <- rnorm(y_samples, mean = y_mean, sd = y_sd)
plot(density(x), ylim=c(0, 0.6))
rug(x)
lines(density(y), col="red")
rug(y, col="red")

my_date <- ymd("2015-01-01")
str(my_date)

# sep indicates the character to use to separate each component
my_date <- ymd(paste("2015", "1", "1", sep = "-")) 
str(my_date)

missing_dates <- surveys[is.na(surveys$date), c("year", "month", "day")]

head(missing_dates)
