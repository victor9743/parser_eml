module ApplicationHelper
    def count_incoming_emails(status)
        if status == "all"
            IncomingEmail.count
        elsif status == "pending"
            IncomingEmail.where(status: "pending").count
        elsif status == "processing"
            IncomingEmail.where(status: "processing").count
        elsif status == "failed"
            IncomingEmail.where(status: "failed").count
        elsif status == "success"
            IncomingEmail.where(status: "success").count
        end
    end

    def color_badge(status)
        if status == "pending"
            "black"
        elsif status == "processing"
            "warning"
        elsif status == "failed"
            "danger"
        elsif status == "success"
            "success"
        end
    end

    def bootstrap_class_for(type)
        type = type.to_s

        return 'success' if ['success', 'notice'].include?(type)
        return 'danger'  if ['error', 'alert', 'danger'].include?(type)
        return 'warning' if type == 'warning'
        return 'info'    if type == 'info'

        'secondary'
    end
end
