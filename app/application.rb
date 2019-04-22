class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match("/items/")
      item_name = req.path.split("/items/").last
      search = Item.all.find {|item| item.name == item_name}
      if Item.all.include?(search)
        resp.write search.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
