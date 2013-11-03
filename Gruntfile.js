// Generated on 2013-11-03 using generator-webapp 0.4.3
'use strict';

module.exports = function (grunt) {
    // show elapsed time at the end
    require('time-grunt')(grunt);
    // load all grunt tasks
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        watch: {
            compass: {
                files: ['app/styles/{,*/}*.{scss,sass}'],
                tasks: ['compass:server', 'autoprefixer']
            },
            styles: {
                files: ['app/styles/{,*/}*.css'],
                tasks: ['copy:styles', 'autoprefixer']
            }
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
                    src: ['dist/*']
                }]
            },
            server: '.tmp'
        },
        less: {
            development: {
                options: {
                    paths: ["app/styles","app/bower_components/bootstrap/less"]
                },
                files: {
                    "dist/styles/main.css": "app/styles/main.less"
                }
            }
        },
        coffeecup: {
            main: {
                files: {
                    "dist/main.html": "app/html/main.coffee",
                }
            }
        },
        bower: {
            options: {
                exclude: ['modernizr']
            },
            all: {
                rjsConfig: 'app/scripts/main.js'
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
        "coffeecup"
    ]);

    grunt.registerTask('default', [
        'build'
    ]);
};
