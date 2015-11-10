defmodule Pedro.Cli.View.Node do
  def status response, params do
    # Response is always a complex data structure composed of
    # tuples and lists and so on. There is a implicit contract
    # created here between a response data and the rendering of 
    # this data to the user. Unit tests are crucial here to get
    # it managed. 
    # All this also means that a view rendering must handle different
    # data coming from different endpoints (http api versions vs native erlang
    # data structures). The more the data structure changes in the future
    # the more code and changes will be needed in every view output
    # management. But let's consider that oukej.
    # We can easyly to differentiate from the params[:api] or params[:response_type]
    # or look at the responder origin.
    IO.puts "               "
    IO.puts "* Node status"
    IO.puts "* ------------------------------"
    IO.puts "* Running.."
    IO.puts "* Uptime 6 days 7 hours"
    IO.puts "* Found 0 projects, 0 tasks"
    IO.puts "* Registered 0 links to upstream"
  end

  def list response, params do
    IO.inspect response
    IO.inspect params
  end
end
