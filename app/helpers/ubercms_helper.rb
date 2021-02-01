module UbercmsHelper
  include Pagy::Frontend

  def full_error_message(obj)
    content_tag(:h3, "There was error(s) saving:")+
    content_tag(:ul) do
      obj.errors.each do |error|
        concat(content_tag :li, error.full_message)
      end
    end
  end

  def ubercms_form(obj,autocomplete:nil,&block)
    form_with(model:[:ubercms,obj],html:{autocomplete:autocomplete===false ? 'off' : autocomplete}) do |f|
      content_tag :div, class:"col-6" do
        concat(full_error_message(obj)) unless obj.errors.blank?
        concat(block.call(f))
      end
    end
  end

  def bs5_text_field(f,method)
    content_tag :div, class:"mb-3" do
      ret = f.label(method,class:'form-label')
      ret += f.text_field(method,class:'form-control')
      ret
    end
  end

  def bs5_textarea_field(f,method)
    content_tag :div, class:"mb-3" do
      ret = f.label(method,class:'form-label')
      ret += f.text_area(method,class:'form-control')
      ret
    end
  end

  def bs5_password_field(f,method)
    content_tag :div, class:"mb-3" do
      ret = f.label(method,class:'form-label')
      ret += f.password_field(method,class:'form-control')
      ret
    end
  end

  def bs5_checkbox_field(f,method,checked:nil)
    content_tag :div, class:"mb-3 form-check" do
      if checked
        ret = f.check_box(method,class:"form-check-input",checked:checked)
      else
        ret = f.check_box(method,class:"form-check-input")
      end
      ret += f.label(method,class:'form-check-label')
      ret
    end
  end

  def bs5_submit(string=nil,&block)
    if block
      content_tag(:button, class:"btn btn-primary",&block)
    else
      content_tag(:button, (string ? string : "Submit"), class:"btn btn-primary")
    end
  end
end
