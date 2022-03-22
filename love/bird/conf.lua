function love.conf(t)
  t.title = "bird"
  t.version = "11.3"
  t.window.width = 300
  t.window.height = 388

  -- For debugging
  t.console = false

  -- love-release info
  t.releases = {
    version = "0.2.0",
    author = "Ian S. Pringle",
    email = "ian@dapringles.com",
    description = "A flappy bird clone",
    homepage = "https://github.com/pard68/love.games",
    excludeFileList = {},     -- File patterns to exclude. (string list)
  }
end
