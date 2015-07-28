module WikisHelper
  def public_or_private
    if @wiki.public?
      content_tag :span, 'Public', class: 'badge glyphicon glyphicon-pencil'
    else
      content_tag :span, 'Private', class: 'badge glyphicon glyphicon-lock'
    end
  end

  def has_collaborators
    if @collaborators.nil?
      content_tag :span, 'No', class: 'badge glyphicon glyphicon-pencil'
    else
      content_tag :span, 'Yes', class: 'badge glyphicon glyphicon-pencil'
    end
  end
end
