guard :shell do
  watch(%r{^(app|lib)/*}) do
    puts("\ncake build\n")
    system('cake build')
  end
end
