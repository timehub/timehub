window.Money = class Money
  constructor: (rawString) ->
    @cents = @parseCents rawString

  parseCents: (rawString="") ->
    [dollars, cents] = rawString.match(/(\d+)/g) ? [0,0]
    cents = 0  if cents == undefined
    cents = 99 if cents > 99
    +cents + 100*dollars

  toString: ->
    "$#{Math.floor(@cents / 100)}.#{@cents % 100}"


window.Project = class Project
  constructor:(name, rate) ->
    @name = name
    @rate = rate


window.InvoiceEntry = class InvoiceEntry
  constructor: (project, time='', description='') ->
    [all, @hours, colon, @minutes] = @parseTime(time)
    @description  = description
    @project      = project
    @price        = new Money(@totalPrice() + '')

  totalHours:   -> +@hours + (@minutes/60.0)

  totalMinutes: -> @totalHours() * 60

  totalPrice: -> @project.rate * @totalHours()

  toJSON: ->
    totalPrice:   @totalPrice()
    totalHours:   @totalHours()
    totalMinutes: @totalMinutes()

  parseTime: (rawTime='') ->
    pattern = ///
      (\d+) # Hours
      (:)   # :
      (\d+) # Minutes
    ///
    result = rawTime.match pattern
    if result
      r.trim() for r in result
    else
      ['', rawTime, '', '']

window.Invoice = class Invoice
  constructor: (rawDescription='') ->
    @entries  = []

  resetEntries: -> @entries = []

  add: (entries...) ->
    @entries.push entries...

  grandTotal: ->
    total = new Money
    total.cents = total.cents + entry.price.cents for entry in @entries
    total


