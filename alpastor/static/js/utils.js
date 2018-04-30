/*
* Extend JavaScript String object with printf() like functionality
* "{0} is dead, but {1} is alive!".format("This", "that");
*/
String.prototype.format = function() {
    var formatted = this;
    var replace = "";
    var re = null;
    for(arg in arguments) {
        replace = "\\{" + arg + "\\}";
        re = new RegExp(replace, "g");
        formatted = formatted.replace(re, arguments[arg]);
    }
    return formatted;
};

/*

 */
var delay = (function() {
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();