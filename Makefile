# Update this to give whichever name you want. This may be set on the command line:
# > make build OUT_FILE=./outfile.zip
OUT_FILE?=./deliverable.zip

### Below this point it should not need to be changed
# get absolute path of zipfile to deliver
DELIVERABLE=$(abspath $(OUT_FILE))

# Install all the libs locally
install:
	pipenv install --three

# Destroy the virtualenv
uninstall:
	pipenv --rm

# Run the import
run:
	pipenv run python ./hello_lambda.py

# Clean delivrable
clean:
	rm -f ${DELIVERABLE}

# Rebuild the delivrable
# Compress Packages by removing *.so
# https://serverlesscode.com/post/deploy-scikitlearn-on-lamba/
build:
	$(eval VENV = $(shell pipenv --venv))
	find "${VENV}/lib/python3.6/site-packages" -name "*.so" | xargs strip
	pushd "${VENV}/lib/python3.6/site-packages"
	cd ${VENV}/lib/python3.6/site-packages && zip -r9 ${DELIVERABLE} ./*
	zip -r9 ${DELIVERABLE} *.py
