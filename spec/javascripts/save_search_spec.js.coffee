# use require to load any .js file available to the asset pipeline
#= require jquery
#= require application/save_search

setUpHTMLFixture = ->
  loadFixtures "home_page"

describe "save_search", ->
  beforeEach ->
    setUpHTMLFixture()

  it "should get the list of friends and insert it in the page", ->
    addEvent()
    spyOn jQuery, "ajax"
    $("#save-search").click()
    expect($.ajax.mostRecentCall.args[0]["url"]).toEqual("/searches/save_search")
    expect($.ajax.mostRecentCall.args[0]["data"]["draggables"]).toEqual('{"0":{"left":5,"top":88,"parent_id":"jasmine-fixtures"},"1":{"left":5,"top":106,"parent_id":"jasmine-fixtures"}}')

    # This debugging statement adds the response object to console lvh.me:3000/jasmine
    # console.log $.ajax.mostRecentCall.args[0]

