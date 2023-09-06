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
    columns do
        column do
            div class: "container" do
                ul do 
                    li "Admin Users" 
                    li class: "count_value" do
                        "#{AdminUser.count}"
                    end
                end
            end
        end
        column do
            div class: "container" do
                ul do 
                    li "Posts" 
                    li class: "count_value" do
                        "#{Post.count}"
                    end
                end
            end
        end
        column do
            div class: "container" do
                ul do 
                    li "Sessions" 
                    li class: "count_value" do
                        "#{Session.count}"
                    end
                end
            end
        end
        column do
            div class: "container" do
                ul do 
                    li "Labels" 
                    li class: "count_value" do
                        "#{Label.count}"
                    end
                end
            end
        end
    end
    br
    columns do
        column do
            panel "Session Analytics" do
                pie_chart Session.group(:type_of_session).count
            end
        end
        column do
            panel "Post Analytics" do
                pie_chart Post.group(:title).count
            end
        end
    end
    br
    tabs do
        tab :Day do
            panel "Post Analytics day wise" do
                line_chart Post.group_by_day(:created_at).count
            end
        end
        tab :week do
            panel "Post Analytics week wise" do
                line_chart Post.group_by_week(:created_at).count
            end
        end
        tab :Month do
            panel "Post Analytics month wise" do
                line_chart Post.group_by_month(:created_at).count
            end
        end
        tab :Year do
            panel "Post Analytics year wise" do
                line_chart Post.group_by_year(:created_at).count
            end
        end
    end
  end # content
end
