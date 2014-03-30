assemble: assets
	gradle assemble

compile:
	gradle

assets:
	grunt dist
	
clean:
	rm -Rf build