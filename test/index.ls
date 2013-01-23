require! {
  './support'
  Game: '../src/game'
}
describe 'Validator', (...) ->
  describe 'When any value in input is less than 0', (...) ->
    it 'should throw an error', ->
      fn = ->
        game = new Game [-1, 0, 1001]

      fn.should.throw 'Invalid input value: < 0'

      fn = ->
        game = new Game [1, 0, -1]

      fn.should.throw 'Invalid input value: < 0'

  describe 'When any value in input is greater than 1000', (...) ->
    it 'should throw an error', ->
      fn = ->
        game = new Game [1001, 0, -1]

      fn.should.throw 'Invalid input value: > 1000'

describe 'Game', (...) ->
  describe 'When input is an empty Array', (...) ->
    it 'should output an empty Array', ->
      game = new Game []
      # first round
      game.calculate!
      game.output.should.eql []
      # second round
      game.calculate!
      game.output.should.eql []

  describe 'When more than or equal 90% invester invested', (...) ->
    it 'should pay every invester 10% profit', (...) ->
      # 9 of 10 invested, >= 90%
      game = new Game [1000, 100, 10, 1, 0, 6, 7, 8, 9, 10]
      # first round
      # 0     + 1000 * 1.1 = 1100
      # 900   + 100  * 1.1 = 1010
      # 990   + 10   * 1.1 = 1001
      # 999   + 1    * 1.1 = 1000.1
      # 1000  + 0    * 1.1 = 1000
      # 994   + 6    * 1.1 = 1000.6
      # 993   + 7    * 1.1 = 1000.7
      # 992   + 8    * 1.1 = 1000.8
      # 991   + 9    * 1.1 = 1000.9
      # 990   + 10   * 1.1 = 1001
      game.calculate!
      result = [1100, 1010, 1001, 1000.1, 1000, 1000.6, 1000.7, 1000.8, 1000.9, 1001]
      support.fixed-number-list-compare result, game.output
      # second round
      # 100   + 1000 * 1.1 = 1200
      # 910   + 100  * 1.1 = 1020
      # 991   + 10   * 1.1 = 1002
      # 999.1 + 1    * 1.1 = 1000.2
      # 1000  + 0    * 1.1 = 1000
      # 994.6 + 6    * 1.1 = 1001.2
      # 993.7 + 7    * 1.1 = 1001.4
      # 992.8 + 8    * 1.1 = 1001.6
      # 991.9 + 9    * 1.1 = 1001.8
      # 991   + 10   * 1.1 = 1002
      game.calculate!
      result = [1200, 1020, 1002, 1000.2, 1000, 1001.2, 1001.4, 1001.6, 1001.8, 1002]
      support.fixed-number-list-compare result, game.output

  describe 'When less than 90% invester invested', (...) ->
    it 'should not pay', ->
      # 2 of 3 invested, < 90%
      game = new Game [1000, 100, 0]
      game.calculate!
      game.output.should.eql [0, 900, 1000]

  describe 'When any invester run out of money', (...) ->
    it 'should throw an error', ->
      fn = ->
        game = new Game [1000, 100, 0]
        game.calculate!
        game.output.should.eql [0, 900, 1000]
        game.calculate!

      fn.should.throw 'Someone is run out of money'
