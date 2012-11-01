describe "InvoiceEntry", ->
  describe "constructor", ->
    beforeEach ->
      @project = new Project('Test Project', 30)
      @entry = new InvoiceEntry @project, '1:30', 'Making tests'
      
    it "extracts title", ->
      (expect @entry.description).toEqual('Making tests')

    it "extracts total time", ->
      (expect @entry.totalHours()).toEqual 1.5
      (expect @entry.totalMinutes()).toEqual 90
      (expect @entry.minutes).toEqual '30'
      (expect @entry.hours).toEqual '1'
    
    it "extracts total price", ->
      (expect @entry.totalPrice()).toEqual 45
      (expect @entry.price.cents).toEqual 4500
      (expect @entry.price.toString()).toEqual '$45.0'

describe "Invoice", ->
  beforeEach ->
    @project  = new Project('Test Project', 30)
    @entry    = new InvoiceEntry @project, '3:30', 'Making tests'
    @entry2   = new InvoiceEntry @project, '0:30', 'Making tests'
    @entries  = [@entry, @entry2]
  
  describe "starting blank", ->
    beforeEach ->
      @invoice = new Invoice
    
    it "Adds a single entry", ->
      (expect @invoice.entries.length).toEqual(0)
      @invoice.add @entry
      (expect @invoice.entries.length).toEqual(1)
      (expect @invoice.grandTotal().cents).toEqual(@entry.price.cents)
    
    it "adds a list of dishes", ->
      @invoice.add @entry, @entry2
      (expect @invoice.entries.length).toEqual 2
    
    it "updates total price when a new dish is added", ->
      (expect @invoice.entries.length).toEqual(0)
      @invoice.add @entry
      (expect @invoice.entries.length).toEqual(1)
      (expect @invoice.grandTotal().cents).toEqual(@entry.price.cents)
      @invoice.add @entry2
      (expect @invoice.entries.length).toEqual(2)
      (expect @invoice.grandTotal().cents).toEqual(@entry.price.cents + @entry2.price.cents)
  
