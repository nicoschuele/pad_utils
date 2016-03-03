require "fileutils"

module PadUtils

  # The following methods are just here for convenience and consistency.
  # Most are wrappers on FileUtils existing methods. Having them here,
  # a user of PadUtils doesn't have to remember names and parameters.

  # Deletes a file.
  #
  # @param file_path [String] the file path and name
  # @return [Void] nothing
  # @example
  #   PadUtils.delete("path/to/file.txt")
  def self.delete_file(file_path)
    FileUtils.rm(file_path, force: true)
  end

  # Checks if a file exists.
  #
  # @param file_path [String] the file path and name
  # @return [Boolean]
  # @example
  #   PadUtils.file_exist?("path/to/file.txt")
  def self.file_exist?(file_path)
    File.exist?(file_path)
  end

  # Copies a file.
  #
  # @param file_path [String] the source file name and path
  # @param dest_dir [String] the destination directory
  # @return [Void] nothing
  # @example
  #   PadUtils.copy_file("test.txt", "path/to/destination/directory")
  def self.copy_file(file_path, dest_dir)
    FileUtils.cp(file_path, dest_dir)
  end


  # Moves a file.
  #
  # @param file_path [String] the source file path and name
  # @param dest_file [String] the destination path and name
  # @return [Void] nothing
  # @example
  #   PadUtils.move_file("source.txt", "path/to/destination/renamed.txt")
  def self.move_file(file_path, dest_file)
    FileUtils.mv(file_path, dest_file, force: true)
  end

  # Copies an array of files.
  #
  # @param files [Array<String>] the array of files paths and names to copy
  # @param dest_dir [String] the destination path
  # @return [Void] nothing
  # @example
  #   files = ["file1.txt", "path/to/file2.txt", "path/to/files/file3.txt"]
  #   PadUtils.copy_files(files, "path/to/destination")
  def self.copy_files(files, dest_dir)
    files.each do |f|
      copy_file(f, dest_dir)
    end
  end

  # Copies all files from a directory.
  #
  # @note Will create the destination if it doesn't exist.
  #   Files existing on destination but not on source won't be overwritten.
  #
  # @param orig_dir [String] the path to source directory
  # @return [Void] nothing
  # @example
  #   PadUtils.copy_all_files("path/to/source", "path/to/destination")
  def self.copy_all_files(orig_dir, dest_dir)
    FileUtils.cp_r(orig_dir, dest_dir)
  end

  # Creates a directory.
  #
  # @note Won't override directory content if it already exists.
  #
  # @param dir_name [String] the directory path and name
  # @return [Void] nothing
  # @example
  #   PadUtils.create_directory("path/to/dir")
  def self.create_directory(dir_name)
    dirname = File.dirname(dir_name)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  # Deletes a directory and its content
  #
  # @param dir_name [String] the directory path and name
  # @return [Void] nothing
  # @example
  #   PadUtils.delete_directory("path/to/dir")
  def self.delete_directory(dir_name)
    FileUtils.rm_r(dir_name)
  end

  # Reads the whole content of a file into a string.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param filepath [String] the file path and name
  # @return [String] the content of the file
  # @example
  #   PadUtils.get_file_content("path/to/file.txt")
  def self.get_file_content(filepath)
    File.read(filepath)
  rescue Exception => e
    PadUtils.log("Error in get_file_content", e)
  end

  # Writes content to a file.
  #
  # @note Will create destination file if it doesn't exist.
  #   Will also overwrite the file if it already exists.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param  filepath [String] the file path and name
  # @param  content [String] the content to be written
  # @return [Void] nothing
  # @example
  #   PadUtils.write_to_file("path/to/file", "Hello\nThis is a test")
  def self.write_to_file(filepath, content)
    self.create_directory(filepath)
    File.open(filepath, 'w') { |f| f.write(content)}
  rescue Exception => e
    PadUtils.log("Error in write_to_file", e)
  end


  # Appends content to a file.
  #
  # @note Will create the destination file if it doesn't exist.
  #   It also prepends a newline character. Set new_line to false to change this.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param filepath [String] the file path and name
  # @param content [String] the content to append
  # @param new_line [Boolean] prepends a newline character
  # @return [Void] nothing
  # @example
  #   PadUtils.append_to_file("path/to/file.txt", "Append this!", false)
  def self.append_to_file(filepath, content, new_line = true)
    self.create_directory(filepath)
    content = "\n#{content}" if new_line
    File.open(filepath, 'a') { |f| f.write("#{content}")}
  rescue Exception => e
    PadUtils.log("Error in append_to_file", e)
  end

end
