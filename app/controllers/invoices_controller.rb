class InvoicesController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :invoice, :through => :project, :shallow => true

  def index
    # @project = Project.find params[:project_id] if params[:project_id]
    # 
    # authorize! :read, @project if @project
    # authorize! :index, Invoice
    @invoices = @project ? @project.invoices : current_user.invoices
  end

  def new
    @invoice = @project.invoices.new(:rate => @project.rate.to_f)
    @invoice.build_entries_from_commits(params[:commit_ids]) if params[:commit_ids]
  end

  def show
    @project ||= @invoice.project
    respond_to do |format|
      format.html
      format.pdf do
        html = render_to_string(:file => "invoices/show.pdf.erb")
        kit = PDFKit.new(html)
        send_data(kit.to_pdf, :filename => "invoice.pdf", :type => 'application/pdf')
      end
    end
  end
  
  def edit
    @project ||= @invoice.project
  end

  def create
    @invoice = @project.invoices.new(params[:invoice])
    if @invoice.save
      redirect_to([@project, @invoice], :notice => "Your invoice has been created.")
    else
      render :action => :new
    end
  end

  def update
    if @invoice.update_attributes(params[:invoice])
      redirect_to([@project, @invoice], :notice => "Your invoice has been saved.")
    else
      render :action => :edit
    end
  end
  
  def destroy
    @invoice.destroy
    if @project
      redirect_to project_invoices_path(@project), :notice => "The invoice was destroyed."
    else
      redirect_to invoices_path, :notice => "The invoice was destroyed."
    end
  end

end
