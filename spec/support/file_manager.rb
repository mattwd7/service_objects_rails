module FileManager
  # TODO: move this constant somewhere more central to the gem
  RAILS_SERVICE_DIRECTORIES = [
    "app/namespaces/services",
    "spec/namespaces/services"
  ]

  def remove_files_and_directories(*additional_files_and_directories)
    FileUtils.rm_rf(
      RAILS_SERVICE_DIRECTORIES.map { |path| "#{Rails.root}/#{path}" }
    )

    additional_files_and_directories.each do |file_or_directory|
      FileUtils.remove_file(file_or_directory) if File.file?(file_or_directory)
      FileUtils.rmdir(file_or_directory) if File.directory?(file_or_directory)
    end
  end
end
