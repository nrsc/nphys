
<!-- README.md is generated from README.Rmd. Please edit that file -->

# The nphys package

The nphys package provides a means to import, manage, and analyze your
neurophysiology data collected during electrophysiology experiments. It
is geared towards developing robust and portable data management tools
and analysis methods. It also serves as a tool that encourages regularly
revisiting data by helping to manage large datasets and present
comprehensive summaries that can be rapidly updated and opvserved from
many different angles. This project is currently geared towards field
long-term depression experiments and whole cell patch clamp experiments,
but will continue to be updated as more datasets and methods of analysis
become available.

## The project directory

Typical project builds are templates for certain types of projects being
run, and contents will vary based upon the needs of the project.

Projects and project directories are labeled `proj` followed by letter
identifiers that are short and easy to reference. `e.g. projEXA`. It is
optimal to maintain project directories downstream from where your tilde
is assigned `e.g. "~/projEXA`. To find out what directory your tilde is
assigned to type `setwd("~")` in your console, followed by `getwd()`.
Reassigning your working directory to your project directory will then
be as simple as

> WARNING\! This will change your working directory and if you do not
> change it back, you may encounter errors when trying to work within
> the project.

All examples outlined in this work reference the project directory

# The experiments

Tools and features of the nphys package

## the .rda file

The rda file contains contains all the metadata, data, and information
for running project. You can name your rda whatever you’d like, but you
must update your what allows you to loop over large datasets and be able
to address multiple factors (i.e Baseline data, stimulus data, various
channels etc.). It purpose is to generate workable dataset for your
projects to easily read and apply functions to.

This .rda file includes a workding directory that is relative to the dir
project folder.

This package currently utilizes the `field` dataset.

``` r
data(field)
```

## Importing data

> currently supports abf file format import that depends on the readABF
> package and .dat files that are exported as .mat format from
> patchmaster.

Import functions focus on building a single .rda file for each piece of
data added to the project. You can name that rda file whatever you like.
I generally save the slice or patch code ()

his project folder can be the source of your raw data that are often
made up of large files that are incompatible with git, making your
.gitignore only need to ignore the dir folder.

<!---
>The dir folder is a symlink crafted to your project directory that points to the source of your raw data files. This can be a local drive or a server. I find this useful because I find it easiest to build the package around the data source, therefore wherever you clone your repo, all scripts or loops can source "~/proj/dir" as long as you keep your project directory in your home folder (generally UNIX: /usr/<username>/home == "~" or Win: C:/Users/<username>/Doccuments == "~")  or simply "dir" when working in your project directory. 

> Patterns allow for pathways for analysis to develop. 
## Long-term depression

Field recordings at the medial perforant path in the DG.


```r

#field$LTD <- nphys::field_LTD(field)

```
--->

## License

This package is free and open source software, licensed under GPL-3.
