module App
  # FrontsController
  class FrontController < AppController
    layout 'layouts/templates/application'

    def index
      @downloads = Download.all
      @banners = Banner.all
    end

    def about
    end

    def contact
      @message = Message.new
    end

    def thanks
      @message = Message.find(params[:id])
    end

    def censoexitoso
      @censo = Censu.find(params[:id])
    end

    def censo
      @censos = Censu.new
    end
  end
end
