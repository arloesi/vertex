module.exports = function (grunt) {
    require('time-grunt')(grunt);
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        watch: {
            styles: {
                files: ['app/styles/{,*/}*.{css,less}'],
                tasks: ['less']
            },
            scripts: {
                files: ['app/scripts/{,*/}*.{js,coffee}'],
                tasks: ['requirejs']
            },
            html: {
                files: ['app/html/{,*/}*.{html,coffee}'],
                tasks: ['coffeecup']
            },
        },
        connect: {
            server: {
                options: {
                    port: 9090,
                    base: "./app"
                }
            }
        },
        clean: {
            dist: {
                files: [{
                    dot: true,
                    src: ['build/assets/*']
                }]
            },
            server: '.tmp'
        },
        less: {
            development: {
                options: {
                    paths: ["app/styles","bower_components/bootstrap/less"]
                },
                files: {
                    "build/assets/styles/main.css": "app/styles/main.less"
                }
            }
        },
        coffeecup: {
            main: {
            	expand: true,
            	cwd: "app/html",
                src: ["user.coffee","main.coffee"],
                dest: "build/assets",
                ext: ".html"
            }
        },
        bower: {
            options: {
                exclude: ['modernizr']
            },
            all: {
                rjsConfig: 'app/scripts/config.js',
                
                options: {
                	baseUrl: 'build/assets/scripts'
                }
            }
        },
        coffee: {
        	compile: {
	    	    expand: true,
	    	    flatten: true,
	    	    src: ['app/scripts/*.coffee'],
	    	    dest: 'build/assets/coffee',
	    	    ext: '.js'
        	}
        },
        requirejs: {
        	compile: {
        		options: {
        			baseUrl: "build/assets/coffee",
        			mainConfigFile: "app/scripts/config.js",
        			dir: "build/assets/scripts",
        			
        			modules: [
			            {name: "common"},
		        		{name: "main", deps: ["common"]},
        				{name: "user", deps: ["common"]}
		        	]
        		}
        	}
        },
        copy: {
        	main: {
        	}
        }
    });

    grunt.registerTask('server', function (target) {
        if (target === 'dist') {
            return grunt.task.run(['build', 'connect:dist:keepalive']);
        }

        grunt.task.run([
            'clean:server',
            'watch'
        ]);
    });

    grunt.registerTask('test', [
        'clean:server',
    ]);
    
    grunt.registerTask("html", ["coffeecup"]);
    grunt.registerTask("scripts", ["coffee","requirejs"]);
    grunt.registerTask("styles", ["less"]);
    grunt.registerTask('build', ["html", "scripts", "styles"]);

    grunt.registerTask('default', [
        'build'
    ]);
};
