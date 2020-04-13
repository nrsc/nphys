today = Sys.Date()
dir = "dir"

#expDt <- MD[which(MD$Date==today),]

aGroups <- c("P14f", "P21f", "P28f")
    a <- paste("f_Slices", select.list(aGroups, multiple = FALSE), sep = "/")

tGroups <- c("Control", "EtOH[50mM]", "EtOH[100mM]", "AP5[50uM]", "Ifenprodil[3uM]")
    Group <- paste(a, select.list(tGroups, multiple = FALSE), sep = "-")
    #Group <- paste(a, g, sep = "-")
    print(Group)
wd0 <- file.path(dir, a, Group)#, sep="/")
list.files(wd0)


ls <- mixedsort(list.dirs(wd0))
    ls <- ls[-1]
    ls <- str_split(ls, pattern = "/", simplify = TRUE)
    ls <- ls[,ncol(ls)]


n <- length(ls)
    n <- paste("_", (n+1), sep = "")

Slices <- list.files(wd0, pattern = ".csv", full.names = TRUE)
    s <- list.files(wd0, pattern = ".csv")
    sd <- print(gsub(".csv", n, Slices))
    dir.create(sd)
    s <- print(gsub(".csv", n, s))
    write.table(s, Slices, append = TRUE, row.names = FALSE, col.names = FALSE, quote = FALSE)

file.copy("BasicTemplate.xlsx", paste(sd, "BasicTemplate.xlsx", sep = "/"))
    xlBT <- list.files(sd, pattern = "BasicTemplate.xlsx", full.names = TRUE)
    xl <- gsub("BasicTemplate", s, xlBT)

file.rename(xlBT, xl)

    shell.exec(paste(Home, xl, sep = "/"))

if (select.list(c("Yes", "No"), title = "Select Yes to Run Part 2: ") == "Yes"){

    SI <- function(x){

    HP <-paste(select.list(c("L", "R"), multiple = FALSE), readline(prompt = "Position?:"), sep = "")

    files <- paste(x, "_xxxx", ".abf", sep = "")

    Rig <- select.list(c("Scott", "Luis", "Sunny"), title = "Rig?")

    FirstIO = readline(prompt="First IO (format = xxxx)?: ")
    FirstIO = gsub("xxxx", FirstIO, files)

    StimFile = readline(prompt="Conditioning Stimulus File (format = xxxx)?: ")
    StimFile = gsub("xxxx", StimFile, files)

    StimMag = readline(prompt="Stimulation Magnitude (format = x.xx (mA))?: ")

    Comment = readline(prompt = "Comments?:")
    #Comment = gsub("xxxx", Comment, files)

    df <- rbind(Rig, HP, FirstIO, StimFile, StimMag, Comment)
    return(df)
    }
   SlInfo <- SI(today)
}else{stop()}
print(SlInfo)

setwd(Home)

print(rbind(Slice = s, Group = Group, t(md), SlInfo))
write.table(rbind(Slice = s, Group = Group, t(md), SlInfo), paste(paste(sd, s, sep = "/"), "-SliceMD.csv"),
            sep = ",", quote = FALSE, row.names = TRUE, col.names = FALSE)


