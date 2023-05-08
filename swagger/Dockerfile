FROM node:16-alpine as converter
RUN npm i -g postman-to-openapi
WORKDIR /opt
COPY . .
RUN echo '{"pathDepth": 1}' >> options.json
RUN p2o ./api/swagger.json -f ./api/swagger.yml -o options.json


FROM swaggerapi/swagger-ui:v4.18.3
ENV SWAGGER_JSON=/opt/swagger.yml
COPY --from=converter /opt/api/swagger.yml /opt/swagger.yml