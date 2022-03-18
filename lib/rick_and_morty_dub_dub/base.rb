module RickAndMortyDubDub
  class Base
    attr_reader :params

    URL = "https://rickandmortyapi.com/api".freeze

    def initialize(params=nil)
      @params = params
    end

    def conn
      @conn ||= Faraday.new(URL) do |f|
        f.request :json
      end
    end

    def all
      request = conn.get(current_resource)
      message_api(request)
    end

    def finder
      ids = params[:id].is_a?(Array) ? params[:id].join(",") : params[:id]
      request = conn.get("#{current_resource}/#{ids}")
      message_api(request)
    end

    def filter
      request = conn.get("#{current_resource}/?#{params.map { |k, v| "#{k}=#{v}" }.join("&")}")
      message_api(request)
    end

    private

    def current_resource
      self.class.name.split("::").last.downcase.to_s
    end

    def message_api(request)
      { body: JSON.parse(request.body), status: request.status }
    end
  end
end
