
delayFuture = new Future();

future_ok(1).andThen(function() {
    return delayFuture;
}).andThen(function(a) {
    show_message(a);
});

event_user(-8);