module Admin
  # DownloadsController
  class DownloadsController < AdminController
    before_action :set_download, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :set_attachments

    # GET /downloads
    def index
      @q = Download.ransack(params[:q])
      downloads = @q.result(distinct: true)
      @objects = downloads.page(@current_page).order(position: :desc)
      @total = downloads.size
      @downloads = @objects.order(:position)
      if !@objects.first_page? && @objects.size.zero?
        redirect_to downloads_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /downloads/1
    def show
    end

    # GET /downloads/new
    def new
      @download = Download.new
      authorize @download
    end

    # GET /downloads/1/edit
    def edit
      authorize @download
    end

    # POST /downloads
    def create
      @download = Download.new(download_params)

      if @download.save
        redirect(@download, params)
      else
        render :new
      end
    end

    # PATCH/PUT /downloads/1
    def update
      if @download.update(download_params)
        redirect(@download, params)
      else
        render :edit
      end
      authorize @download
    end

    def clone
      @download = Download.clone_record params[:download_id]

      if @download.save
        redirect_to admin_downloads_path
      else
        render :new
      end
      authorize @download
    end

    # DELETE /downloads/1
    def destroy
      @download.destroy
      redirect_to admin_downloads_path, notice: actions_messages(@download)
      authorize @download
    end

    def destroy_multiple
      Download.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_downloads_path(page: @current_page, search: @query),
        notice: actions_messages(Download.new)
      )
      authorize @download
    end

    def import
      Download.import(params[:file])
      redirect_to(
        admin_downloads_path(page: @current_page, search: @query),
        notice: actions_messages(Download.new)
      )
      authorize @download
    end

    def download
      @downloads = Download.all
      respond_to do |format|
        format.html
        format.xls { send_data(@downloads.to_xls) }
        format.json { render :json => @downloads }
      end
      authorize @downloads
    end

    def reload
      @q = Download.ransack(params[:q])
      downloads = @q.result(distinct: true)
      @objects = downloads.page(@current_page).order(position: :desc)
    end

    def sort
      Download.sorter(params[:row])
      render :index
    end

    private

    def set_attachments
      @attachments = ['logo', 'brand', 'photo', 'avatar', 'cover', 'image',
                      'picture', 'banner', 'attachment', 'pic', 'file']
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def download_params
      params.require(:download).permit(:title, :description, :file, :position)
    end

    def show_history
      get_history(Download)
    end
  end
end
