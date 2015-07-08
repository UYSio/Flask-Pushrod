.PHONY: all clean test dist pypi pypitest publish publishtest

all:	clean test

test:
	tox

clean:
	-find . -name "__pycache__" | xargs rm -rf
	-find . -name "*.pyc" | xargs rm -f
	-find . -name '*.egg-info' -type d | xargs rm -rf
	-find . -name '*.egg' -type d | xargs rm -rf
	-rm -rf build
	-rm -rf dist
	-rm -rf docs/_build
	-rm -rf htmlcov
	-rm -rf .coverage
	-rm -rf .tox
	-rm -rf examples/pushrodr/pushrodr.db

dist:
	python setup.py sdist bdist_wheel

pypitest:
	twine upload -r pypitest dist/*

pypi:
	twine upload dist/*

publishtest: clean dist pypitest

publish: clean dist pypi

coverage:
	  coverage run --source application -m py.test && coverage report

coveralls:
	  py.test --cov application tests/ --cov-report=term --cov-report=html

flake8:
	  flake8 flask_pushrod examples setup.py 
