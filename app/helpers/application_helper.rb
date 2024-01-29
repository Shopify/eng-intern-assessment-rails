module ApplicationHelper
    def bootstrap_class_for_flash(type)
        case type
        when 'notice' then 'alert-info'
        when 'success' then 'alert-success'
        when 'error' then 'alert-danger'
        when 'alert' then 'alert-warning'
        else type.to_s
        end
    end
end
