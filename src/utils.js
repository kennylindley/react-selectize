(function(){
  var ref$, filter, map, objToPairs, Str, createElement, cancelEvent, classNameFromObject, createFactory, out$ = typeof exports != 'undefined' && exports || this;
  ref$ = require('prelude-ls'), filter = ref$.filter, map = ref$.map, objToPairs = ref$.objToPairs, Str = ref$.Str;
  createElement = require('react').createElement;
  out$.cancelEvent = cancelEvent = function(e){
    e.preventDefault();
    e.stopPropagation();
    false;
  };
  out$.classNameFromObject = classNameFromObject = function(it){
    return Str.join(' ')(
    map(function(it){
      return it[0];
    })(
    filter(function(it){
      return !!it[1];
    })(
    objToPairs(
    it))));
  };
  out$.createFactory = createFactory = function(type){
    return createElement.bind(null, type);
  };
}).call(this);
