class Admin::NoticesController < ApplicationController
  # GET /admin/notices
  # GET /admin/notices.json
  def index
    @notices = Notice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notices }
    end
  end

  # GET /admin/notices/1
  # GET /admin/notices/1.json
  def show
    @notice = Notice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notice }
    end
  end

  # GET /admin/notices/new
  # GET /admin/notices/new.json
  def new
    @notice = Notice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notice }
    end
  end

  # GET /admin/notices/1/edit
  def edit
    @notice = Notice.find(params[:id])
  end

  # POST /admin/notices
  # POST /admin/notices.json
  def create
    binding.pry
    @notice = Notice.new({
                             close_at: closed_at_to_date
                         })


    respond_to do |format|
      if @notice.save
        format.html { redirect_to admin_notice_path(id: @notice.id), notice: 'Notice was successfully created.' }
        format.json { render json: @notice, status: :created, location: @notice }
      else
        format.html { render action: "new" }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/notices/1
  # PUT /admin/notices/1.json
  def update
    @notice = Notice.find(params[:id])

    respond_to do |format|
      if @notice.update_attributes(params[:admin_notice])
        format.html { redirect_to @notice, notice: 'Notice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/notices/1
  # DELETE /admin/notices/1.json
  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy

    respond_to do |format|
      format.html { redirect_to admin_notices_url }
      format.json { head :no_content }
    end
  end

  private

  def closed_at_to_date
    Time::local(params[:notices]['closed_at(1i)'], params[:notices]['closed_at(2i)'],params[:notices]['closed_at(3i)'], params[:notices]['closed_at(4i)'], params[:notices]['closed_at(5i)'])
  end
end
