module FrontendUrlHelper
  def base_frontend_url
    if Rails.env.production?
      'http://pos.dsibaja.com/'
    else
      'http://localhost:8080/'
    end
  end

  def inject_params(url, params)
    url + '?' + params.map { |key, value| "#{key}=#{value}" }.join('&')
  end

  def create_frontend_url(extra_url, params)
    url = base_frontend_url + extra_url
    inject_params(url, params)
  end
end
