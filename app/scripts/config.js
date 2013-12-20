
var ROOT = "../../../";
var BOWER = ROOT + "/bower_components";
var BOOTSTRAP = BOWER + "/bootstrap";

var prefix = function(i) {
  var x = {};

  for(var k in i) {
    x[k] = p + i[k];
  }

  return x;
};

require.config({
    paths: _.extend(
    prefix(ROOT, {
      app: "app/scripts"}),
        prefix(BOWER, {
          jquery: 'query/jquery',
        'backbone-relational': 'backbone-relational/backbone-relational',
          backbone: 'backbone/backbone',
          bootstrap: 'bootstrap/dist/js/bootstrap',
          requirejs: 'requirejs/require',
          underscore: 'underscore/underscore'}),
        prefix(BOOTSTRAP, {
          bootstrapAffix: 'bootstrap/js/affix',
          bootstrapAlert: 'bootstrap/js/alert',
          bootstrapButton: 'bootstrap/js/button',
          bootstrapCarousel: 'bootstrap/js/carousel',
          bootstrapCollapse: 'bootstrap/js/collapse',
          bootstrapDropdown: 'bootstrap/js/dropdown',
          bootstrapModal: 'bootstrap/js/modal',
          bootstrapPopover: 'bootstrap/js/popover',
          bootstrapScrollspy: 'bootstrap/js/scrollspy',
          bootstrapTab: 'bootstrap/js/tab',
          bootstrapTooltip: 'bootstrap/js/tooltip',
          bootstrapTransition: 'bootstrap/js/transition'}))
    },
    shim: {
        bootstrapAffix: {
            deps: [
                'jquery'
            ]
        },
        bootstrapAlert: {
            deps: [
                'jquery',
                'bootstrapTransition'
            ]
        },
        bootstrapButton: {
            deps: [
                'jquery'
            ]
        },
        bootstrapCarousel: {
            deps: [
                'jquery',
                'bootstrapTransition'
            ]
        },
        bootstrapCollapse: {
            deps: [
                'jquery',
                'bootstrapTransition'
            ]
        },
        bootstrapDropdown: {
            deps: [
                'jquery'
            ]
        },
        bootstrapModal: {
            deps: [
                'jquery',
                'bootstrapTransition'
            ]
        },
        bootstrapPopover: {
            deps: [
                'jquery',
                'bootstrapTooltip'
            ]
        },
        bootstrapScrollspy: {
            deps: [
                'jquery'
            ]
        },
        bootstrapTab: {
            deps: [
                'jquery',
                'bootstrapTransition'
            ]
        },
        bootstrapTooltip: {
            deps: [
                'jquery',
                'bootstrapTransition'
            ]
        },
        bootstrapTransition: {
            deps: [
                'jquery'
            ]
        }
    }
});

