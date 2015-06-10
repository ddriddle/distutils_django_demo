
all: dist

dist: $(SRCS)
	python setup.py bdist_rpm

tar:
	python setup.py bdist_dumb

spec:
	python setup.py bdist_rpm --spec-only

fix:
	-chgrp -R $(SERVICE_USER) dist
	-chgrp $(SERVICE_USER) -R .
	-chmod g+w src src/db.sqlite3

coverage:
	coverage run --source=src runtests.py

pep8:
	pep8 --exclude=migrations src

pyflakes:
	pyflakes src

test: pyflakes pep8 coverage
	python setup.py test

clean:
	-rm -rf dist build *.egg-info src/*.egg-info .coverage
