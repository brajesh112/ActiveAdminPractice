# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     # span I18n.t("active_admin.dashboard_welcome.welcome")
    #     # small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end
    # Here is an example of a simple dashboard with columns and panels.
    #
    div class: "form_end" do
      render partial: 'range'
    end
    br br
    columns do
      column do
        div class: "container" do
          ul do 
            li class: "bold_li" do
              "Admin Users" 
            end
            li class: "count_value" do
              adminusers
            end
          end
        end
      end
      column do
        div class: "container-1" do
          ul do 
            li class: "bold_li" do
              "Posts" 
            end
            li class: "count_value" do
              posts
            end
          end
        end
      end
      column do
        div class: "container" do
          ul do 
            li class: "bold_li" do
              "Sessions" 
            end
            li class: "count_value" do
              sessions
            end
          end
        end
      end
      column do
        div class: "container-1" do
          ul do 
            li class: "bold_li" do
              "Labels" 
            end
            li class: "count_value" do
              labels
            end
          end
        end
      end
    end
    br
    br br
    columns do
      column do
        panel "Session Analytics" do
          pie_chart piesession
        end
      end
      column do
        panel "Post Analytics" do
          pie_chart piepost
        end
      end
    end
    br br br
    tabs do
      tab :Day do
        panel "Post Analytics day wise" do
          line_chart linepostday
        end
      end
      tab :week do
        panel "Post Analytics week wise" do
          line_chart linepostweek
        end
      end
      tab :Month do
        panel "Post Analytics month wise" do
          line_chart linepostmonth
        end
      end
      tab :Year do
        panel "Post Analytics year wise" do
          line_chart linepostyear
        end
      end
    end
  end # content
  controller do
    def index
      val = params[:dashboard].present? ? params[:dashboard][:time] : 0
      all_data
      custom_wise(1.day) if val.eql? "1d"
      custom_wise(1.week) if val.eql? "1w"
      custom_wise(1.month) if val.eql? "1m"
      custom_wise(1.year) if val.eql? "1y"
    end

    private
    def all_data
      @posts = Post.count
      @sessions = Session.count
      @labels = Label.count
      @adminusers = AdminUser.count
      @piepost = Post.group(:title).count
      @piesession = Session.group(:type_of_session).count
      @linepostday = Post.group_by_day(:created_at).count
      @linepostweek = Post.group_by_week(:created_at).count
      @linepostmonth = Post.group_by_month(:created_at).count
      @linepostyear =Post.group_by_year(:created_at).count
    end
    def custom_wise(value)
      @posts = Post.where('created_at > ?' ,DateTime.now - value).count
      @sessions = Session.where('created_at > ?' ,DateTime.now - value).count
      @labels = Label.where('created_at > ?' ,DateTime.now - value).count
      @adminusers = AdminUser.where('created_at > ?' ,DateTime.now - value).count
      @piepost = Post.group(:title).where('created_at > ?' ,DateTime.now - value).count
      @piesession = Session.group(:type_of_session).where('created_at > ?' ,DateTime.now - value).count
      @linepostday = Post.group_by_day(:created_at).where('created_at > ?' ,DateTime.now - value).count
      @linepostweek = Post.group_by_week(:created_at).where('created_at > ?' ,DateTime.now - value).count
      @linepostmonth = Post.group_by_month(:created_at).where('created_at > ?' ,DateTime.now - value).count
      @linepostyear =Post.group_by_year(:created_at).where('created_at > ?' ,DateTime.now - value).count
    end
  end
end

