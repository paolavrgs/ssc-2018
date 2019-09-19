module Admin
  # BannersController
  class BannersController < AdminController
    before_action :set_banner, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :set_attachments

    # GET /banners
    def index
      @q = Banner.ransack(params[:q])
      banners = @q.result(distinct: true)
      @objects = banners.page(@current_page).order(position: :desc)
      @total = banners.size
      @banners = @objects.order(:position)
      if !@objects.first_page? && @objects.size.zero?
        redirect_to banners_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /banners/1
    def show
    end

    # GET /banners/new
    def new
      @banner = Banner.new
      authorize @banner
    end

    # GET /banners/1/edit
    def edit
      authorize @banner
    end

    # POST /banners
    def create
      @banner = Banner.new(banner_params)

      if @banner.save
        redirect(@banner, params)
      else
        render :new
      end
    end

    # PATCH/PUT /banners/1
    def update
      if @banner.update(banner_params)
        redirect(@banner, params)
      else
        render :edit
      end
      authorize @banner
    end

    def clone
      @banner = Banner.clone_record params[:banner_id]

      if @banner.save
        redirect_to admin_banners_path
      else
        render :new
      end
      authorize @banner
    end

    # DELETE /banners/1
    def destroy
      @banner.destroy
      redirect_to admin_banners_path, notice: actions_messages(@banner)
      authorize @banner
    end

    def destroy_multiple
      Banner.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_banners_path(page: @current_page, search: @query),
        notice: actions_messages(Banner.new)
      )
      authorize @banner
    end

    def import
      Banner.import(params[:file])
      redirect_to(
        admin_banners_path(page: @current_page, search: @query),
        notice: actions_messages(Banner.new)
      )
      authorize @banner
    end

    def download
      @banners = Banner.all
      respond_to do |format|
        format.html
        format.xls { send_data(@banners.to_xls) }
        format.json { render :json => @banners }
      end
      authorize @banners
    end

    def reload
      @q = Banner.ransack(params[:q])
      banners = @q.result(distinct: true)
      @objects = banners.page(@current_page).order(position: :desc)
    end

    def sort
      Banner.sorter(params[:row])
      render :index
    end

    private

    def set_attachments
      @attachments = ['logo', 'brand', 'photo', 'avatar', 'cover', 'image',
                      'picture', 'banner', 'attachment', 'pic', 'file']
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def banner_params
      params.require(:banner).permit(:banner, :title, :description)
    end

    def show_history
      get_history(Banner)
    end
  end
end
