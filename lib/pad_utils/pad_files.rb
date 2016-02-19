require "fileutils"

module PadUtils

  # The following methods are just here for convenience and consistency.
  # Most are wrappers on FileUtils existing methods. Having them here,
  # a user of PadUtils doesn't have to remember names and parameters.

  # Delete a file. If not found, doesn't raise any error.
  def self.delete_file(file_path)
    FileUtils.rm(file_path, force: true)
  end

  # Just a wrapper on File.exist? for consistency.
  def self.file_exist?(file_path)
    File.exist?(file_path)
  end

  # Just a wrapper on FileUtils.cp for consistency.
  # Will override file if it already exists!
  def self.copy_file(file_path, dest_dir)
    FileUtils.cp(file_path, dest_dir)
  end

  # Just a wrapper on FileUtils.mv for consistency.
  # Will not throw an error if original file doesn't exist
  def self.move_file(file_path, dest_file)
    FileUtils.mv(file_path, dest_file, force: true)
  end

  # Copy an array of files
  def self.copy_files(files, dest_dir)
    files.each do |f|
      copy_file(f, dest_dir)
    end
  end

  # Copy all files from a directory to another.
  # Will create destination if it doesn't exist
  def self.copy_all_files(orig_dir, dest_dir)
    FileUtils.copy_entry(orig_dir, dest_dir)
  end

  # Create a directory and subdirectories
  # Won't complain if it already exists. Won't override content.
  def self.create_directory(dir_name)
    FileUtils.mkdir_p(dir_name)
  end

  # Reads content of a file. Method created for consistency.
  def self.get_file_content(filepath)
    File.read(filepath)
  end
  
  # Write content to a file. Create it if it doesn't exist.
  def self.write_to_file(filepath, content)
    File.open(filepath, 'w') { |f| f.write(content)}
  end
  
  # Append content to the end of a file. Create it if it doesn't exist.
  # It will write a newline character first. If you don't want that,
  # set the new_line option to false.
  def self.append_to_file(filepath, content, new_line = true)
    content = "\n#{content}" if new_line
    File.open(filepath, 'a') { |f| f.write("#{content}")}
  end

end
