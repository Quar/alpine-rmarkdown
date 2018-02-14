FROM conoria/alpine-pandoc:latest AS build

WORKDIR /usr/share/doc/R/html

RUN apk add R R-dev alpine-sdk

RUN Rscript -e 'install.packages(c("rmarkdown", "dplyr", "ggplot2", "ggpubr", "codetools"), repos="http://cloud.r-project.org/")'

RUN Rscript -e 'install.packages(c("mlbench", "expm", "magic", "kernlab"), repos="http://cloud.r-project.org/")'


FROM conoria/alpine-pandoc:latest

MAINTAINER Winchell Qian <winchell.qian@mail.com>

RUN apk add R

COPY --from=build /usr/lib/R /usr/lib/R

CMD ["/usr/bin/R"]
