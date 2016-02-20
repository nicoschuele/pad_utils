# PadUtils

PadUtils is a simple gem containing common utilities and shortcuts. It is used in the [Padstone](http://padstone.io) app builder but can be embedded in any other Ruby project.

## Installation

It's a Ruby gem. Install it like any other gem!

`gem install pad_utils`

## Usage

Just `require 'pad_utils'` within your code to access the following methods.

### Build CLI menus

#### 1. Yes/No menu

Prompt user with a cli yes/no menu. Returns `true` or `false`.
`question`: the question to ask
`default`: the default answer

`PadUtils.yes_no_menu(question: "Question?", default: "y")`

#### 2. Open question menu

Prompt user with a cli open question menu. Returns a `string`.

`PadUtils.question_menu(question)`

#### 3. Multiple choice menu

Prompt user with a multiple choice menu. Returns a `symbol`.

`question`: the question to ask
`choices`: hash of choices (e.g. `{b: "blue", r: "red"}`)
`default`: symbol representing the default value. If none provided, last value in choices hash will be used.

`PadUtils.choice_menu(question: "Question?", choices: {}, default: nil)`


### Work with text

#### 1. Convert a string to a Rubified name

Convert a string into a proper "rubified" name. For example, 'app_name' will be converted to 'AppName'. Returns a `string`.

`PadUtils.convert_to_ruby_name(value)`

#### 2. Sanitize a string

Sanitize a string by replacing special characters (including spaces) with underscores. Returns a `string`.

`PadUtils.sanitize(value)`

#### 3. Replace a string in a file

Replace text within a file. `old_text` can either be a `string` or a `regex`. Doesn't return anything, overwrites `file`.

`PadUtils.replace_in_file(file, old_text, new_text)`

#### 4. Insert text before first occurence

Insert text in a string or a file before the first occurence of a string. Returns a `string`. If `is_file` is `true`, overwrites `original` file.

`original`: the original string or filename
`tag`: occurence of string to find
`text`: string to insert
`is_file`: `true` if `original` is a filename (default), `false` if it's a `string`

`PadUtils.insert_before_first(original: nil, tag: nil, text: nil, is_file: true)`

#### 5. Insert text before last occurence

Insert text in a string or a file before the last occurence of a string. Returns a `string`. If `is_file` is `true`, overwrites `original` file.

`original`: the original string or filename
`tag`: occurence of string to find
`text`: string to insert
`is_file`: `true` if `original` is a filename (default), `false` if it's a `string`

`PadUtils.insert_before_last(original: nil, tag: nil, text: nil, is_file: true)`

#### 6. Insert text after first occurence

Insert text in a string or a file after the first occurence of a string. Returns a `string`. If `is_file` is `true`, overwrites `original` file.

`original`: the original string or filename
`tag`: occurence of string to find
`text`: string to insert
`is_file`: `true` if `original` is a filename (default), `false` if it's a `string`

`PadUtils.insert_after_first(original: nil, tag: nil, text: nil, is_file: true)`

#### 7. Insert text after last occurence

Insert text in a string or a file after the last occurence of a string. Returns a `string`. If `is_file` is `true`, overwrites `original` file.

`original`: the original string or filename
`tag`: occurence of string to find
`text`: string to insert
`is_file`: `true` if `original` is a filename (default), `false` if it's a `string`

`PadUtils.insert_after_last(original: nil, tag: nil, text: nil, is_file: true)`

### Work with files

Mostly, these are convenience methods aliasing existing Ruby methods. Implemented for consistency.

#### 1. Delete a file

Delete a file. If not found, doesn't raise any error.

`delete_file(file_path)`

#### 2. Does a file exist?

Returns `true` or `false`.

`PadUtils.file_exist?(file_path)`

#### 3. Copy a file

**Will override file if it already exists!**

`PadUtils.copy_file(file_path, dest_dir)`

#### 4. Move a file

**Will not throw an error if original file doesn't exist!**

`PadUtils.move_file(file_path, dest_file)`

#### 5. Copy multiple files

`PadUtils.copy_files(files_array, dest_dir)`

#### 6. Copy all files

Copy all files from a directory to another. *Will create destination if it doesn't exist*.

`PadUtils.copy_all_files(source_dir, dest_dir)`

#### 7. Create a directory

Create a directory and subdirectories. **Won't complain if it already exists. Won't override content**.

`PadUtils.create_directory(dir_name)`

#### 8. Read content of a file

Returns a `string`.

`PadUtils.get_file_content(filepath)`

#### 9. Write to a file

Write content to a file. Create it if it doesn't exist. **Overwrites it if it already exists!**.

`PadUtils.write_to_file(filepath, content)`

Append content to the end of a file. Create it if it doesn't exist.

**It will write a newline character first. If you don't want that,
set the `new_line` option to `false`**.

`PadUtils.append_to_file(filepath, content, new_line = true)`

### Logging

By default, logs will go to `~/pad_logs/logs.txt`.

Change default path: `PadUtils.log_path = "/new/path/to/logs"`
Change default file name: `PadUtils.log_file = "my_logs.txt"`

To log a message, you call `log` and pass it a `message` string. Optionally, you can also pass an `Exception` object in the parameters:

`PadUtils.log(message, e = nil)`

### Some time methods

#### 1. Time to string timestamp

Returns a `string` timestamp with the format `YYYYMMDDHHmmss` from a `Time` object.

`PadUtils.time_to_stamp(val)`

#### 2. String to time

Returns a `Time` object from a timestamp with the format `YYYYMMDDHHmmss`

`PadUtils.stamp_to_time(val)`

#### 3. Time to readable string

Returns a `string` readable timestamp with format `YYYY-MM-DD HH:mm:ss` from a `Time` object.

`PadUtils.time_to_readable_stamp(val)`

#### 4. Readable timestamp to time

Returns a `Time` object from a readable timestamp `string` with format `YYYY-MM-DD HH:mm:ss`

`PadUtils.readable_stamp_to_time(val)`

## Contribute

[Get in touch](https://twitter.com/nicoschuele) before submitting a pull request, I don't want to waste your time by rejecting it!

## License

Copyright 2016 - Nico Schuele

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
