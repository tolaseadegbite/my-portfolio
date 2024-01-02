module ApplicationHelper

    # returns base title if page title is blank
    def full_title(page_title="")
        base_title = "Tolase Kelvin Adegbite"
        if page_title.blank?
            base_title
        else
            "#{page_title} | #{base_title}"
        end
    end
end
