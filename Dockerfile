FROM darthjee/ruby_gems:0.2.3 as base
FROM darthjee/scripts:0.1.2 as scripts

######################################

FROM base as builder

COPY --chown=app ./ /home/app/app/
COPY --chown=app:app --from=scripts /home/scripts/builder/bundle_builder.sh /usr/local/sbin/

ENV HOME_DIR /home/app
RUN bundle_builder.sh

#######################
#FINAL IMAGE
FROM base
RUN mkdir lib/dr_light -p

USER root

COPY --chown=app:app --from=builder /home/app/bundle/gems /usr/local/bundle/gems
COPY --chown=app:app --from=builder /home/app/bundle/cache /usr/local/bundle/cache
COPY --chown=app:app --from=builder /home/app/bundle/specifications /usr/local/bundle/specifications
COPY --chown=app:app --from=builder /home/app/bundle/bin /usr/local/bundle/bin
COPY --chown=app:app --from=builder /home/app/bundle/extensions /usr/local/bundle/extensions

COPY --chown=app ./*.gemspec ./Gemfile /home/app/app/
COPY --chown=app ./lib/dr_light/version.rb /home/app/app/lib/dr_light/
USER app
RUN bundle install
