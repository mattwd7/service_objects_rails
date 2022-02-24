module FileManager
  def remove_files_and_directories(file_and_directories)
    file_and_directories.each do |file_or_directory|
      FileUtils.remove_file(file_or_directory) if File.file?(file_or_directory)
      FileUtils.rmdir(file_or_directory) if File.directory?(file_or_directory)
    end
  end
end
