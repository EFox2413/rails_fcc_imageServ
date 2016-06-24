class ShorturlController < ApplicationController
    def create
        @url = ShortUrl.new(shorturl_params)

        @url.save

        render json: { origin: @url.original, short: 'http://www.protected-lowlands-68279.herokuapp.com/l/'.concat(@url.id.to_s) }
    end

    def forward
        shorturl = ShortUrl.find_by_id(params[:ident])
        redirect_to shorturl.original
    end

    private
    def shorturl_params
        url = params[:original]
        url = url.concat('.' + params[:format])
        urlArr = url.split('/')
        params[:original] = urlArr[0] + '//' + urlArr[1]
        params.permit(:original, :ident)
    end
end
