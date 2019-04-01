# Start up
print("Start up")

Home <- getwd()

b0 = as.numeric(menu(c("Yes", "No"), title = "Run Compile?"))

if (b0 == 1){
    print("Compiling Data")
    source("R/newCompile.R")
}



b1 = as.numeric(menu(c("Yes", "No"), title = "Experimental Day??"))
if (b1 == 1){
    print("Good Luck")
    source("R/ExpDay.R")
}
