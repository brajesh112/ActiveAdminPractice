ActiveAdmin.register Session do
  # menu priority: 5
  menu parent: 'Sessions',priority: 1
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
        f.input :labels, as: :select, collection: Label.all.map {|label| [ label.name, label.id]},:input_html => {:id => "selectElement",:multiple => true}
      end
    end
    f.actions
  end

  controller do
    
    def create 
      add_label(new_admin_session_path)
    end

    def update
      add_label(edit_admin_session_path)
    end

    def add_label(path)
      params[:session][:label_ids].compact_blank!
      return redirect_to path, alert: "label must be present" unless params[:session][:label_ids].present?

      if path == new_admin_session_path
        @labels = Label.where(id: params[:session][:label_ids])
        @session = Session.new(title: params[:session][:title], type_of_session: params[:session][:type_of_session])
      else
        @session = Session.find_by(id: params[:id])
        @session.update(title: params[:session][:title], type_of_session: params[:session][:type_of_session])
        @labels = Label.where(id: params[:session][:label_ids].map(&:to_i).excluding(@session.labels.ids))
        arr = @session.labels.ids.excluding(params[:session][:label_ids].map(&:to_i))
        @session.labels.delete(@session.labels.where(id: arr)) if arr.present?
      end

      ar = Label.includes(:sessions).where("sessions.type_of_session" => "#{params[:session][:type_of_session]}", "labels.id" => params[:session][:label_ids].map(&:to_i)).excluding(@session.labels)

      return redirect_to path, alert: "#{Label.where(id: ar.ids).pluck(:name)} is already present" if ar.present?
        
      @session.labels << @labels
      redirect_to admin_sessions_path if @session.save
    end
  end

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
