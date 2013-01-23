require! {
  fs
  child_process
  path
}

# tasks
task \watch, "Watch file changes and trigger other tasks", ->
  invoke \test
  watch = (dir) ->
    fs.watch dir, ->
      invoke \test
    files = fs.readdir-sync dir
    for file in files when file not in [\node_modules, \.git]
      file-path = path.join dir, file
      stat = fs.stat-sync file-path
      if stat.is-directory!
        watch file-path
  watch '.'


task \test, "Run mocha test", ->
  mocha = child_process.spawn \mocha, [],
    stdio: 'inherit'
