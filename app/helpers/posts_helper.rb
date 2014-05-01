module PostsHelper

  def sti_post_path(object_type = "post", object = nil, action = nil)
    send "#{format_sti(action, object_type, object)}_path", object
  end

  def format_sti(action, object_type, object)
    action || object ? "#{format_action(action)}#{object_type.underscore}" : "#{object_type.underscore.pluralize}"
  end

  def format_action(action)
    action ? "#{action}_" : ""
  end

end
