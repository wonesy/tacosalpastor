/*
* Extend JavaScript String object with printf() like functionality
* "{0} is dead, but {1} is alive!".format("This", "that");
*/
String.prototype.format = function() {
    let formatted = this;
    let replace = "";
    let re = null;
    for(arg in arguments) {
        replace = "\\{" + arg + "\\}";
        re = new RegExp(replace, "g");
        formatted = formatted.replace(re, arguments[arg]);
    }
    return formatted;
};

/*

 */
let delay = (function() {
    let timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();


function parseGET() {
    let get = {};

    let query = document.location
        .toString()
        // get the query string
        .replace(/^.*?\?/, '')
        // and remove any existing hash string (thanks, @vrijdenker)
        .replace(/#.*$/, '')
        .split('&');

    for (let i = 0, l=query.length; i<l; i++) {
        let aux = decodeURIComponent(query[i]).split('=');
        get[aux[0]] = aux[1]
    }

    return get;
}


