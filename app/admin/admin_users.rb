ActiveAdmin.register AdminUser do
  role_changeable
  permit_params :email, :password, :password_confirmation, :role

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at do|item|
      item.created_at.strftime('%Y/%m/%d')
    end
    actions do
      link_to('Comments',"", class: "link_button")
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end

end
