ActiveAdmin.register Post do
  menu priority: 4
  active_admin_import
  action_item :view, only: :index do
    link_to 'Button text', "#"
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :body, :admin_user_id, :active, images:[]

  form do |f|
    f.inputs do 
    	li class: "string input optional stringish" do
    		label :admin_user_id, class: "label"
    		f.collection_select :admin_user_id, AdminUser.all, :id, :email
    	end
      f.input :title
      f.input :body
      f.input :active
      if f.object.images.attached?
      	f.input :images, as: :file, input_html: { multiple: true },hint: image_tag(f.object.images.first, size: "100")
      else
      	f.input :images, as: :file, input_html: { multiple: true }
      end 
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :admin_user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end 
  show do
    attributes_table do
    	row :user_email do |ad|
    		ad.admin_user.email
    	end
      row :title
      row :images do |ad|
        ad.images.map{|image| image_tag url_for(image), size: "100"}
      end
      row :body
    end
    active_admin_comments
  end
end
