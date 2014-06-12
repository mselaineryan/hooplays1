module ApplicationHelper
	# Returns the full title on a per-page basis
	# Methods, like this one, in helper modules are automagically avaialable in all our views
	# We don't have to include the module explicitly, as you do in ordinary Ruby
	def full_title(page_title)
		base_title = "Hooplays"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end
