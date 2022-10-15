future_file_write_string("Test", "file.txt", "owo").andThen(function() {
    show_message("success");
}).andCatch(function(err) {
    show_message("failure");
});