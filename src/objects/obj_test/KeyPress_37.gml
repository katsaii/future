future_file_read_string("Test", "file.txt").andThen(function(content) {
    show_message(content);
}).andCatch(function(err) {
    show_message(err);
});