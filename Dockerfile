FROM conoria/alpine-pandoc:latest AS build

WORKDIR /usr/share/doc/R/html

RUN apk add R R-dev alpine-sdk

RUN Rscript -e 'install.packages(c("rmarkdown", "dplyr", "ggplot2", "ggpubr", "codetools"), repos="http://cloud.r-project.org/")'

RUN Rscript -e 'install.packages(c("mlbench", "expm", "magic", "kernlab"), repos="http://cloud.r-project.org/")'


FROM alpine:latest

MAINTAINER Winchell Qian <winchell.qian@mail.com>

RUN apk --no-cache add R

COPY --from=build /usr/lib/R /usr/lib/R
COPY --from=build /usr/bin/pandoc /usr/bin/pandoc
COPY --from=build /usr/share/pandoc /usr/share/pandoc
COPY --from=build /usr/share/pandoc-citeproc /usr/share/pandoc-citeproc
COPY --from=build /usr/lib/libgmp.so.10 /usr/lib/libgmp.so.10


ENV PATH="/usr/local/texlive/2016/bin/x86_64-linux:${PATH}"

CMD ["/usr/bin/R"]
