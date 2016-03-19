require 'zip'
require 'fileutils'

module PadUtils

  def self.extract_zip(filename, target_path)
    # Unzip the content
    Zip::File.open(filename) do |zip_file|
      zip_file.each do |f|
        f_path=File.join(target_path, f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exist?(f_path)
      end
    end
    # Get rid of these filthy OS X files
    PadUtils.delete_directory "#{target_path}/__MACOSX" if PadUtils.file_exist?("#{target_path}/__MACOSX")
    PadUtils.delete_recursive("#{target_path}", ".DS_Store")
  end

end
