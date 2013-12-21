module.exports = function (grunt) {
    require('time-grunt')(grunt);
    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        watch: {
            styles: {
                files: ['app/styles/{,*/}*.{css,less}'],
                tasks: ['styles']
            },
            scripts: {
                files: ['app/scripts/{,*/}*.{js,coffee}'],
                tasks: ['scripts']
            },
            html: {
                files: ['app/html/{,*/}*.{html,coffee}'],
                tasks: ['html']
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
                    src: ['build/*']
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
                  "build/assets/styles/user.css": "app/styles/user.less",
                  "build/assets/styles/main.css": "app/styles/main.less"
                }
            }
        },
        exec: {
            html: {
              command:
                "mkdir -p build/assets/html-ugly; "+
                "for i in user main; do "+
                  "coffee app/html/$i.coffee > build/assets/html-ugly/$i.html;"+
                "done",
              stdout: true
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
        concat: {
          common: {
            src: [
              "bower_components/underscore/underscore.js",
              "bower_components/jquery/jquery.js",
              "bower_components/bootstrap/js/*.js",
              "bower_components/backbone/backbone.js",
              "bower_components/backbone-relational/backbone-relational.js",
              "bower_components/knockout/build/output/knockout-latest.debug.js",
              "build/assets/coffee/common.js"],
            dest: "build/assets/scripts/common.js"
          },
          main: {
            src: [
              "build/assets/scripts/common.js",
              "build/assets/coffee/main.js"],
            dest: "build/assets/scripts/main.js"
          },
          user: {
            src: [
              "build/assets/scripts/common.js",
              "build/assets/coffee/user.js"],
            dest: "build/assets/scripts/user.js"
          }
        },
        copy: {
          dist: {
            files: [
                {expand: true, flatten: true,
                  src: ["build/assets/html/*.html"],
                  dest: "build/dist/html"},
                {expand: true, flatten: true,
                  src: ["build/assets/scripts/main.js","build/assets/scripts/user.js"],
                  dest: "build/dist/static/scripts"},
                {expand: true, flatten: true,
                  src: ["build/assets/styles/main.css","build/assets/styles/user.css"],
                  dest: "build/dist/static/styles"}
            ]
          }
        },
        prettify: {
          all: {
            expand: true,
            cwd: 'build/assets/html-ugly',
            ext: '.html',
            src: ['*.html'],
            dest: 'build/assets/html'
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

    grunt.registerTask("html", ["exec:html","prettify"]);
    grunt.registerTask("scripts", ["coffee","concat:common","concat:main","concat:user"]);
    grunt.registerTask("styles", ["less"]);
    grunt.registerTask('build', ["html", "scripts", "styles"]);
    grunt.registerTask("dist", ["build", "copy:dist"])
    grunt.registerTask('default', ['dist']);
};
