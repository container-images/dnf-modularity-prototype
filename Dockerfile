FROM baseruntime/baseruntime

MAINTAINER "James Antill <james.antill@redhat.com>"

ADD server.repo /etc/yum.repos.d
ADD _copr_rpmsoftwaremanagement-dnf-nightly.repo /etc/yum.repos.d

RUN mkdir /dnf-repo
ADD dnf-repo /dnf-repo
ADD local-dnf.repo /etc/yum.repos.d

RUN microdnf install -y dnf && microdnf clean all

# RUN microdnf install -y git && microdnf clean all

# https://github.com/mhatina/dnf/commits/modules_install
# RUN git clone --branch modules_install https://github.com/mhatina/dnf
RUN dnf install https://kojipkgs.fedoraproject.org//packages/modulemd/1.2.0/1.fc26/noarch/python3-modulemd-1.2.0-1.fc26.noarch.rpm https://kojipkgs.fedoraproject.org//packages/PyYAML/3.12/3.fc26/x86_64/python3-PyYAML-3.12-3.fc26.x86_64.rpm https://kojipkgs.fedoraproject.org//packages/libyaml/0.1.7/2.fc26/x86_64/libyaml-0.1.7-2.fc26.x86_64.rpm && dnf clean all

RUN echo "" >> /etc/yum.repos.d/_copr_rpmsoftwaremanagement-dnf-nightly.repo
RUN echo "exclude = dnf dnf-automatic dnf-conf dnf-yum python3-dnf" >> /etc/yum.repos.d/_copr_rpmsoftwaremanagement-dnf-nightly.repo
ADD _copr_mhatina-dnf.repo /etc/yum.repos.d

# RUN mkdir /dnf
# ADD dnf /dnf

# RUN cp -a /dnf/dnf /usr/lib/python3.6/site-packages/
RUN cp -a /etc/dnf/dnf.conf.rpmnew /etc/dnf/dnf.conf
RUN dnf distro-sync -y dnf python3-dnf dnf-conf && dnf clean all

ADD modmd.patch /
RUN microdnf install -y patch && microdnf clean all
RUN patch -p0 < modmd.patch

# For debugging... (disabled by default)
ADD rawhide.repo /etc/yum.repos.d

COPY ./boltron-compose.repo /etc/yum.repos.d/
