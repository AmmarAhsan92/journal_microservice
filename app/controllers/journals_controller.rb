class JournalsController < ApplicationController
  def index
    @journals = Journal.all
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)

    respond_to do |format|
      if @journal.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            'journals', partial: 'journals/journal', locals: { journal: @journal }
          )
          render turbo_stream: turbo_stream.replace(
            'new-journal-form', partial: 'journals/new', locals: { journal: Journal.new }
          )
        end
      else
        format.html { render :index }
      end
    end
  end

  def edit
    @journal = Journal.find(params[:id])
  end

  def update
    @journal = Journal.find(params[:id])

    respond_to do |format|
      if @journal.update(journal_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@journal) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @journal = Journal.find(params[:id])
    @journal.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@journal) }
    end
  end

  private

  def journal_params
    params.require(:journal).permit(:name)
  end
end
