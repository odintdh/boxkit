ARG FEDORA_MAJOR_VERSION=38
ARG BASE_IMAGE_URL=registry.fedoraproject.org/fedora-toolbox

FROM ${BASE_IMAGE_URL}:${FEDORA_MAJOR_VERSION}

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="odintdh@gmail.com"

COPY scripts /tmp/scripts

COPY --from=cgr.dev/chainguard/kubectl:latest /usr/bin/kubectl /usr/bin/kubectl
COPY --from=cgr.dev/chainguard/flux:latest /usr/bin/flux /usr/bin/flux
COPY --from=cgr.dev/chainguard/helm:latest /usr/bin/helm /usr/bin/helm
COPY --from=cgr.dev/chainguard/ko:latest /usr/bin/ko /usr/bin/ko
COPY --from=cgr.dev/chainguard/minio-client:latest /usr/bin/mc /usr/bin/mc
COPY extra-packages /
RUN chmod +x /tmp/scripts/pre.sh && \
        /tmp/scripts/pre.sh && \
        grep -v '^#' /extra-packages | xargs dnf install -y && \
        chmod +x /tmp/scripts/post.sh && \
        /tmp/scripts/post.sh 
        
RUN rm /extra-packages
RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree
     
