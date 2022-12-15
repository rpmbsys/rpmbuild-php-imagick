ARG os=8.7.20221112
ARG image=php-7.4

FROM aursu/pearbuild:${os}-${image}

RUN dnf -y install \
        ImageMagick-devel \
    && dnf clean all && rm -rf /var/cache/dnf

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER

ENTRYPOINT ["/usr/bin/rpmbuild", "php-pecl-imagick.spec"]
CMD ["-ba"]
