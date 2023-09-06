ActiveAdmin.register_page "CustomPage" do
	menu parent: 'Sessions',priority: 2
 content do
    para "Hello World"
  end
end