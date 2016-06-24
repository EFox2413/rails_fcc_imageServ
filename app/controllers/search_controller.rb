require 'net/http'
require 'net/https'
require 'json'

class SearchController < ApplicationController
    def main
    end

    def offset
        create
    end

    #uses my imgur API key
    def create
        imgurKey = 'a548b7eee990427'
        headers = {
            "Authorization" => "Client-ID " + imgurKey
        }
        path = '/3/gallery/top/all/' + params[:offset].to_s + '/search?q='.concat(params[:query].to_s)
        p path
        uri = URI("https://api.imgur.com".concat(path))
        request = Net::HTTP::Get.new(path, headers)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        response = http.request(request)
        response = JSON.parse(response.read_body).first[1]

        image = response.collect{ |item| item["link"] }
        alt = response.collect{ |item| item["title"] }
        page = response.collect{ |item| item["link"] }

        responseAggreg = Array.new

        for i in 0..response.length
            responseAggreg.push(image_url: image[i], alt: alt[i], full_page: page[i].to_s.partition(/\.\w{2,4}$/)[0])
        end

        render json: {result: responseAggreg}
    end
end
