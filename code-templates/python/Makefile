include ./Makefile.template

PY_VER:=
PY_ENV:=env
PIP_FLAGS=--trusted-host pypi.org --trusted-host pypi.python.org

GLOBAL_PYTHON=python$(PY_VER)
GLOBAPL_PIP=pip$(PY_VER)
GLOBAL_PIP_INSTALL=$(GLOBAPL_PIP) install $(PIP_FLAGS)

LOCAL_PIP_INSTALL=$(LOCAL_PIP) install $(PIP_FLAGS)

VIRTUALENV_ARGS?=--python python$(PY_VER)

FIND_METHOD=all
ifeq ($(FIND_METHOD),cached)
	FIND_PY_FILES=git diff --cached --name-only | egrep "\.py\$$"
	FIND_YAML_FILES=git diff --cached --name-only | egrep "\.ya?ml\$$"
else
	FIND_PY_FILES=find . -iname "*.py" | grep -v ".\/$(PY_ENV)"
	FIND_YAML_FILES=find . -iname "*.yml" -or -iname "*.yaml" | grep -v ".\/$(PY_ENV)"
endif

clean: ## Clean Code
	find . -name '*.py[co]' -delete || true
	find . -type d -iname "*__pycache__*" -delete || true

code-analysis: ## Code Analysis

code-analysis--mccabe: # Code Analysis :: Mccabe (http://pypi.python.org/pypi/mccabe)
	@make exec-over-py-files EXEC_COMMAND=python -m mccabe --min 5
	
code-analysis--radon: # Code Analysis :: Radon (https://radon.readthedocs.io/en/latest/)
	@make exec-over-py-files EXEC_COMMAND=radon cc --min B --max E

code-audit: code-audit--flake ## Code Audit

code-audit--flake: # Code Audit :: Flake8 (http://flake8.pycqa.org)
	@make exec-over-py-files EXEC_COMMAND="flake8 $(shell [ -f .flake8 ] && echo '--global-config .flake8')"

code-audit--pylama: # Code Audit :: Pylama (https://github.com/klen/pylama)
	@make exec-over-py-files EXEC_COMMAND="pylama $(shell [ -f .pylama.ini ] && echo '--global-config .pylama.ini')"

code-format: code-format--autopep ## Code Formatter

code-format--autopep: # Code Format :: Autopep8 (https://github.com/hhatto/autopep8)
	@make exec-over-py-files EXEC_COMMAND="autopep8 $(shell [ -f .pep8 ] && echo '--global-config .pep8')"

code-format--black: # Code Format :: Flake8 (http://flake8.pycqa.org)
	@make exec-over-py-files EXEC_COMMAND="black $(shell [ -f .black.toml ] && echo '--config .black.toml')"

code-format--isort: # Code Format :: Isort (https://github.com/timothycrosley/isort)
	@make exec-over-py-files EXEC_COMMAND=isort

code-lint: code-lint--pylint code-lint--pycodestyle ## Code Linting

code-lint--bandit: # Code Linting :: Bandit (https://github.com/PyCQA/bandit)
	@make exec-over-py-files EXEC_COMMAND="bandit $(shell [ -f .bandit ] && echo '--ini .bandit')"

code-lint--mypy: # Code Linting :: MyPy (http://mypy-lang.org/)
	@make exec-over-py-files EXEC_COMMAND="mypy $(shell [ -f .mypy.ini ] && echo '--config-file .mypy.toml')"

code-lint--pycodestyle: # Code Linting :: PyCodeStyle (http://pycodestyle.pycqa.org)
	@make exec-over-py-files EXEC_COMMAND="pycodestyle $(shell [ -f .pycodestylerc ] && echo '--config .pycodestylerc')"

code-lint--pydocstyle: # Code Linting :: Pydocstyle (http://www.pydocstyle.org)
	@make exec-over-py-files EXEC_COMMAND="pydocstyle $(shell [ -f .pydocstylerc ] && echo '--config .pydocstylerc')"

code-lint--pyflakes: # Code Linting :: Pyflakes (https://github.com/PyCQA/pyflakes)
	@make exec-over-py-files EXEC_COMMAND=pyflakes

code-lint--pylint: # Code Linting :: Pylint (https://www.pylint.org/)
	@make exec-over-py-files EXEC_COMMAND="pylint $(shell [ -f .pylintrc ] && echo '--rcfile .pylintrc')"

code-yaml-lint: ## YAML Files Linting
	@make exec-over-yaml-files EXEC_COMMAND="yamllint $(shell [ -f .yamllint ] && echo '-c .yamllint')"

exec-over-py-files:
	@if [ ! -f /tmp/pre-commit-error ]; then $(FIND_PY_FILES) | while read f; do \
		$(EXEC_COMMAND) $$f 2> /tmp/pre-commit-log 1>&2 || ( \
			printf "%-114s" "$(EXEC_COMMAND) $$f"; \
			printf "\033[0;31m[FAIL]\033[0m\n"; \
			cat /tmp/pre-commit-log; \
			echo 1 > /tmp/pre-commit-error; \
		); \
		if [ ! -f /tmp/pre-commit-error ]; then \
			printf "%-116s" "$(EXEC_COMMAND) $$f"; \
			printf "\033[0;32m[OK]\033[0m\n"; \
		fi; \
	done; fi

exec-over-json-files:
	@if [ ! -f /tmp/pre-commit-error ]; then $(FIND_JSON_FILES) | while read f; do echo $(EXEC_COMMAND) $$f; $(EXEC_COMMAND) $$f; done; fi

exec-over-yaml-files:
	@if [ -f /tmp/pre-commit-error ]; then  $(FIND_YAML_FILES) | while read f; do echo $(EXEC_COMMAND) $$f; $(EXEC_COMMAND) $$f; done; fi

dist: clean ## Build Module
	rm -rf dist/*
	$(GLOBAL_PYTHON) setup.py sdist
	$(GLOBAL_PYTHON) setup.py bdist_wheel

dist-upload: ## Upload Module
	twine upload dist/*

pre-commit: code-format code-analysis code-lint #code-yaml-lint #test
	@if [ -f /tmp/pre-commit-error ]; then rm -rf /tmp/pre-commit-error; exit 100; fi
	@git diff --cached --name-only | while read f; do git add $$f; done

pre-commit-init: ## Initialize Git pre-commit hook
	cp .pre-commit .git/hooks/pre-commit
	chmod -x .git/hooks/pre-commit

test: test--unittest-coverage ## Unit Tests

test--pytest: # Unit Tests Test :: Pytest (https://docs.pytest.org/en/latest/)
	python -m pytest \
		-v \
		--cov=pytempl \
		--cov-report=term \
		--cov-report=html:coverage-report \
		tests/

test--unittest: # Unit Tests Test :: Unittest (https://docs.python.org/3.5/library/unittest.html)
	python -m unittest discover -s tests -p "*_test.py"

test--unittest-coverage: # Unittest + Coverage (https://docs.python.org/3.5/library/unittest.html)
	python -m unittest discover -s tests -p "*_test.py"

virtualenv:  ## Create Virtualenv
	$(GLOBAL_PIP_INSTALL) virtualenv
	virtualenv $(VIRTUALENV_ARGS) --prompt '|> pytempl <| ' $(PY_ENV)
	$(LOCAL_PIP) install -r requirements-dev.txt
	# $(LOCAL_PYTHON) setup.py develop
	@echo
	@echo "VirtualENV Setup Complete. Now run: source $(PY_ENV)/bin/activate"
	@echo
