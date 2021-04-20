FROM gradle:jdk11

RUN apt-get update \
    && apt-get install -y --no-install-recommends less groff \
    && rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY release.sh /

WORKDIR /

ENTRYPOINT ["/release.sh"]

