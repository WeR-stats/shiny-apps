pkgs <- readLines(file('r_packages_app.lst'))
pkgs.not <- pkgs[!sapply(pkgs, require, char = TRUE)]
if(length(pkgs.not) > 0) install.packages(pkgs.not)
message(sum(sapply(pkgs, require, char = TRUE)) == length(pkgs))
