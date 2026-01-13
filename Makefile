
test:  lint documentation examples pytest


pytest: clean
	pytest --cov -v


documentation: sphinx


sphinx:
	cd docs; make -s html > /dev/null


examples: clean g2e_test calc_test


g2e_test:
	cd examples/g2e; make -s clean test
	cd examples/g2e; make -s clean


calc_test:
	cd examples/calc; make -s clean test


lint: ruff ty mypy


ruff:
	ruff check -q --preview --fix tatsu tests examples


mypy:
	mypy --install-types --exclude dist --exclude parsers .


ty:
	ty check --exclude parsers


clean:
	find . -name "__pycache__" | xargs rm -r
	rm -rf tatsu.egg-info dist build .tox


checks: clean documentation
	hatch run --force-continue test:checks
	@echo version `python -m tatsu --version`


build: clean
	hatch build


test_publish: build
	hatch publish --repo test


publish: checks build
	hatch publish
