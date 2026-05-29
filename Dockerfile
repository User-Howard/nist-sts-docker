# build
FROM alpine:3.21 AS builder

RUN apk add --no-cache gcc make musl-dev

WORKDIR /build
COPY sts-2.1.2/ .
RUN make -f makefile && \
    gcc -static -o assess obj/*.o -lm

# runtime
FROM alpine:3.21 AS runtime

WORKDIR /nist

COPY --from=builder /build/assess .
COPY sts-2.1.2/templates/ templates/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# /results can be mounted by the user to persist output
VOLUME ["/results"]

ENTRYPOINT ["/entrypoint.sh"]
# Default stream length: 1 000 000 bits
CMD ["1000000"]
