-- Configuration
function love.conf(t)
  t.title = "Scroll-N-Shoot"
  t.version = "0.11.3"
  t.window.width = 480
  t.window.height = 800

  -- For debugging
  t.console = false

  -- love-release info
  t.releases = {
    version = "0.2.0",
    author = "Ian S. Pringle",
    email = "ian@dapringles.com",
    description = "Scroll and shoot!",
    homepage = "https://github.com/pard68/love.games",
    excludeFileList = {},     -- File patterns to exclude. (string list)
  }
end
