require! {
  _: \underscore
}
class Game
  (@input) ->
    @validate!
    # initialize @current
    @output = []
    for i in @input
      @output.push 1000.0

  validate: ->
    count = 0
    @input.for-each (value) ->
      if value < 0
        throw new Error 'Invalid input value: < 0'
      else if value > 1000
        throw new Error 'Invalid input value: > 1000'
      else if value > 0
        count := count + 1

    @length = @input.length
    @invested = count
    @not-invested = @length - @invested
    @success = count >= @length * 0.9 # whether have profit


  calculate: ->
    @output = _(@output).map (value, index) ~>
      value = value - @input[index]
      if @success
        value += @input[index] * 1.1

      if value < 0
        throw new Error 'Someone is run out of money'
      value

  print: ->
    console.log 'Current balance: ', @output
    console.log "#@invested people invested, #@not-invested people didn't"

exports = module.exports = Game
