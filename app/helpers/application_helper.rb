module ApplicationHelper
    def bootstrap_class_for_flash(flash_type)
        case flash_type
        when 'notice' then 'success'
        when 'alert'  then 'danger'
        else flash_type.to_s
        end
      end
end
