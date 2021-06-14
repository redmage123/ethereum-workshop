var json_string = '{"foo":"bar", "baz":"blech", "meh":"feh" }';

var parsed = JSON.parse(json_string);
console.log('Foo: ' + parsed['foo']);


