describe "Create Todo", ->
  it "it is only added once to the Collection", ->
    expect(Todos.find().size()).toBe(1)