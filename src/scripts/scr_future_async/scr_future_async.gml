//! Wrapper functions for common asynchronous tasks.

//# feather use syntax-errors

/// Returns a new [Future] which is accepted if the destination file was
/// loaded correctly, and rejected otherwise.
///
/// @param {String} group
///   The name of the group to match.
///
/// @param {String} path
///   The path of the file to read.
///
/// @param {String} [title]
///   The title used to identify this file. Defaults to "Save File".
///
/// @return {Struct.Future}
function future_file_load_buffer(group, path, title="Save File") {
    var filename = filename_change_ext(filename_name(path), "");
    var future_ = new Future();
    if (os_browser != browser_not_a_browser) {
        // temporary fix
        var buffer_ = buffer_load(group + "/" + path);
        if (buffer_ != -1) {
            // it is the responsibility of the user to delete the buffer
            future_.accept(buffer_);
        } else {
            future_.reject();
            buffer_delete(buffer_);
        }
    } else {
        with (instance_create_depth(0, 0, 0, obj_future_async_load)) {
            future = future_;
            buffer_async_group_begin(group);
            buffer_async_group_option("showdialog", false);
            buffer_async_group_option("slottitle", title);
            buffer_async_group_option("subtitle", filename);
            buffer_load_async(buffer, path, 0, -1);
            idx = buffer_async_group_end();
        }
    }
}

/// Similar to [future_file_load_buffer], except the result is converted
/// into a string value.
///
/// @param {String} group
///   The name of the group to match.
///
/// @param {String} path
///   The path of the file to read.
///
/// @param {String} [title]
///   The title used to identify this file. Defaults to "Save File".
///
/// @return {Struct.Future}
function future_file_load_buffer(group, path, title) {
    var future = future_file_load_buffer(group, path, title);
    return future.andThen(function(buffer) {
        var content = buffer_read(buffer, buffer_string);
        buffer_delete(buffer);
        return content;
    });
}