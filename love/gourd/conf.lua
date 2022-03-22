function love.conf(t)
  t.title = "Gourd"
  t.version = "11.4"
  t.window.width = 800
  t.window.height = 600

  -- For debugging
  t.console = false

  -- love-release info
  t.releases = {
    version = "0.1.0",
    author = "Ian S. Pringle",
    email = "ian@dapringles.com",
    description = "Gourd is Pong + Squash",
    homepage = "https://github.com/pard68/love.games",
    excludeFileList = {},     -- File patterns to exclude. (string list)
  }
end