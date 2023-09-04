ActiveAdmin.register Session do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :title, :type_of_session, labels: []

   form do |f|
    f.inputs do 
      li class: "string input optional stringish" do
        label :type_of_session, class: "label"
        f.select :type_of_session, ["Private", "Public"],{ :prompt => "Please select"}
      end
      f.input :title
      li class: "string input optional stringish" do
        f.input :labels, as: :select, collection: Label.all.map {|label| [ label.name, label.id]},:multiple => true
      end
    end
    f.actions
  end

  controller do
    def create 
      params[:session][:label_ids].compact_blank!
      @labels = Label.find(params[:session][:label_ids])
      @session = Session.new(title: params[:session][:title], type_of_session: params[:session][:type_of_session])
      @labels.each do |label| 
        unless Session.includes(:labels).where("type_of_session" => "#{params[:session][:type_of_session]}", "labels.id" => "#{label.id}").present?
          @session.labels << label
        end
      end
      if @session.labels.present?
        @session.save
        redirect_to admin_sessions_path
      end
    end

    def update
      params[:session][:label_ids].compact_blank!
      @labels = Label.find(params[:session][:label_ids])
      @session = Session.find(params[:id])
      @session.update(title: params[:session][:title], type_of_session: params[:session][:type_of_session])
      @session.labels.clear
      @session.labels << @labels
      redirect_to admin_sessions_path
    end
  end


  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  show do
    attributes_table do
      row :Label do |ad|
        ad.labels
      end
      row :title
      row :type_of_session
    end
    active_admin_comments
  end
  
end
