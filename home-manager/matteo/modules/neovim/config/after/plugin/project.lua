require("project_nvim").setup {
  detection_methods = {"patterns"},
  patterns = {
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
    "package.json",
    "Cargo.lock",
  },
  show_hidden = true,
}
