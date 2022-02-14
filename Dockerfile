FROM chocolatey/choco

# Pass in your API Key
ARG CHOCO_API_KEY

# Pass in your nupgk Package Name
ARG CHOCO_PACKAGE_NAME

# Copy over the package directory
COPY . /package

# Work in the package directory
WORKDIR /package

# Create the package
RUN choco pack

# Set API key and push package
RUN choco apikey -k $CHOCO_API_KEY -source https://push.chocolatey.org/
RUN choco push $CHOCO_PACKAGE_NAME -s https://push.chocolatey.org/