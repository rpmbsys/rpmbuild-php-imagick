ARG os=10.0.20250606
ARG image=php-8.4

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
