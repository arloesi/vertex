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
                files: {
                    "build/assets/main.html": "app/html/main.coffee",
                }
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
		        		{name: "main"},
        				{name: "user"}
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

    grunt.registerTask('build', [
        'clean:dist',
        'less',
        'coffee',
        'requirejs',
        "coffeecup"
    ]);

    grunt.registerTask('default', [
        'build'
    ]);
};
