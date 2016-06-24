require 'net/http'
require 'net/https'
require 'json'

class SearchController < ApplicationController
    def main
    end

    #show the last 10 searches in database
    def show
        #optimal in rails 4 but may be badly implemented in rails 3
        response = Search.last(10).reverse

        responseAggreg = Array.new
        for i in 0..(response.length - 1)
            responseAggreg.push(search_text: response[i]["search_text"], when: response[i]["created_at"])
        end

        render json: {result: responseAggreg, response: response}
    end

    def offset
        create
    end

    #uses my imgur API key
    def create
        #param mapping because of bad db structure
        params[:search_text] = params[:query]
        # create new entry and save it to database
        @searchObj = Search.new(params.permit(:search_text))
        @searchObj.save

        #imgur api key
        # imgur headers
        headers = {
            "Authorization" => "Client-ID " + IMGUR_CLIENT_ID
        }

        #search path
        path = '/3/gallery/search/top/all/' + params[:offset].to_s + '/?q='.concat(params[:query].to_s)
        # print path to rails console for debugging purposes
        p path


        uri = URI("https://api.imgur.com".concat(path))
        request = Net::HTTP::Get.new(path, headers)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        #get and parse json response
        response = http.request(request)
        response = JSON.parse(response.read_body).first[1]

        # collect desired fields
        image = response.collect{ |item| item["link"] }
        alt = response.collect{ |item| item["title"] }
        page = response.collect{ |item| item["link"] }

        #formatting json response
        responseAggreg = Array.new
        for i in 0..response.length
            responseAggreg.push(image_url: image[i], alt: alt[i], full_page: page[i].to_s.partition(/\.\w{2,4}$/)[0])
        end

        render json: {result: responseAggreg}
    end
end
