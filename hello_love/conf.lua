function love.conf(t)
  t.title = "Hello, Löve!"
  t.version = "0.11.3"
  t.window.width = 800
  t.window.height = 600

  -- For debugging
  t.console = false

  -- love-release info
  t.releases = {
    version = "0.1.0",
    author = "Ian S. Pringle",
    email = "ian@dapringles.com",
    description = "Hello world, in Löve2d!",
    homepage = "https://github.com/pard68/love.games",
    excludeFileList = {},     -- File patterns to exclude. (string list)
  }
end
