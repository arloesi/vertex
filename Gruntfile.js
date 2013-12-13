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
                rjsConfig: 'app/scripts/common.js',
                
                options: {
                	baseUrl: 'app/scripts'
                }
            }
        },
        requirejs: {
        	compile: {
        		options: {
        			baseUrl: "app/scripts",
        			mainConfigFile: "app/scripts/config.js",
        			dir: "build/assets/scripts",
        			
        			modules: [
		        		{
		        			name: "main"
        				}
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
        'requirejs',
        "coffeecup"
    ]);

    grunt.registerTask('default', [
        'build'
    ]);
};
