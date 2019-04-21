class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item_found = false
      @@items.each do |item|
        if item.name == item_name
          item_found = true
          resp.write "Price: #{item.price}"
        end
      end
      if !item_found
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
