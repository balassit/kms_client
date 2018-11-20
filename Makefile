PIP_INSTALL         := pipenv install
PIP_RUN             := pipenv run

.PHONY: _venv
_venv:
	$(PIP_INSTALL)

.PHONY: _venv_dev
_venv_dev:
	$(PIP_INSTALL) --dev

.PHONY: install
install: _venv
	$(PIP_RUN) python setup.py sdist bdist_wheel

.PHONY: clean
clean:
	pipenv --rm && \
	rm -rf build dist kms_client.egg-info

.PHONY: test
test: _venv_dev run-test

.PHONY: run-test
run-test:
	$(PIP_RUN) pytest tests/unit_tests && \
	$(PIP_RUN) coverage run -m --source=tests/unit_tests/ unittest discover && \
	$(PIP_RUN) coverage report

.PHONY: clean-unit-test
clean-unit-test:
	rm -rf __pycache__ && \
	rm -rf .pytest_cache && \
	rm -rf tests/unit_tests/__pycache__

.PHONY: upload-test
upload-test: install
	$(PIP_RUN) twine upload --repository-url https://test.pypi.org/legacy/ dist/*

.PHONY: deploy-test
deploy-test: clean upload-test

.PHONY: upload
upload: install
	$(PIP_RUN) twine upload dist/*

.PHONY: deploy
deploy: clean upload
