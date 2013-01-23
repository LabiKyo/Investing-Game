require! {
  _: \underscore
  \should
}

self = exports = module.exports =
  fixed-number-list-compare: (x, y) ->
    x.for-each (value, index) ->
      value.to-fixed 1 .should.equal y[index].to-fixed 1
