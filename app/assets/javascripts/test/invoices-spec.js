/* DO NOT MODIFY. This file was compiled Sat, 13 Aug 2011 22:26:01 GMT from
 * /Users/tesla/code/rails/rally/test/test-js/invoices-spec.coffee
 */

(function() {
  describe("InvoiceEntry", function() {
    return describe("constructor", function() {
      beforeEach(function() {
        this.project = new Project('Test Project', 30);
        return this.entry = new InvoiceEntry(this.project, '1:30', 'Making tests');
      });
      it("extracts title", function() {
        return (expect(this.entry.description)).toEqual('Making tests');
      });
      it("extracts total time", function() {
        (expect(this.entry.totalHours())).toEqual(1.5);
        (expect(this.entry.totalMinutes())).toEqual(90);
        (expect(this.entry.minutes)).toEqual('30');
        return (expect(this.entry.hours)).toEqual('1');
      });
      return it("extracts total price", function() {
        (expect(this.entry.totalPrice())).toEqual(45);
        (expect(this.entry.price.cents)).toEqual(4500);
        return (expect(this.entry.price.toString())).toEqual('$45.0');
      });
    });
  });
  describe("Invoice", function() {
    beforeEach(function() {
      this.project = new Project('Test Project', 30);
      this.entry = new InvoiceEntry(this.project, '3:30', 'Making tests');
      this.entry2 = new InvoiceEntry(this.project, '0:30', 'Making tests');
      return this.entries = [this.entry, this.entry2];
    });
    return describe("starting blank", function() {
      beforeEach(function() {
        return this.invoice = new Invoice;
      });
      it("Adds a single entry", function() {
        (expect(this.invoice.entries.length)).toEqual(0);
        this.invoice.add(this.entry);
        (expect(this.invoice.entries.length)).toEqual(1);
        return (expect(this.invoice.grandTotal().cents)).toEqual(this.entry.price.cents);
      });
      it("adds a list of dishes", function() {
        this.invoice.add(this.entry, this.entry2);
        return (expect(this.invoice.entries.length)).toEqual(2);
      });
      return it("updates total price when a new dish is added", function() {
        (expect(this.invoice.entries.length)).toEqual(0);
        this.invoice.add(this.entry);
        (expect(this.invoice.entries.length)).toEqual(1);
        (expect(this.invoice.grandTotal().cents)).toEqual(this.entry.price.cents);
        this.invoice.add(this.entry2);
        (expect(this.invoice.entries.length)).toEqual(2);
        return (expect(this.invoice.grandTotal().cents)).toEqual(this.entry.price.cents + this.entry2.price.cents);
      });
    });
  });
}).call(this);
