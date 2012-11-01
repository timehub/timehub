describe "Projects Filters", ->
  beforeEach ->
    loadFixtures("projects.html")
    ($ ".project").hide()

  describe "#all", ->
    it "shows all the projects", ->
      ($ "#filters #all a").click()
      expect($(".project")).toBeVisible()

  describe "#public", ->
    it "shows all the public projects", ->
      ($ "#filters #public a").click()
      expect($(".project.public")).toBeVisible()
      
    it "hides all the private projects", ->
      ($ "#filters #public a").click()
      expect($(".project.private")).toBeHidden()
      
  describe "#private", ->
    it "shows all the private projects", ->
      ($ "#filters #private a").click()
      expect($(".project.private")).toBeVisible()

    it "hides all the public projects", ->
      ($ "#filters #private a").click()
      expect($(".project.public")).toBeHidden()