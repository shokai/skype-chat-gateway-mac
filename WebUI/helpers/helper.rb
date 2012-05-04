
def app_root
  "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
end

def mobile?
  request.user_agent =~ /mobile/i ? true : false
end
