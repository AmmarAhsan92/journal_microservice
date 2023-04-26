class EntriesController < ApplicationController
  def create
    @journal = Journal.find(params[:journal_id])
    @entry = @journal.entries.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            'journal-entries', partial: 'entries/entry', locals: { entry: @entry }
          )
          render turbo_stream: turbo_stream.replace(
            'new-entry-form', partial: 'entries/new', locals: { journal: @journal, entry: Entry.new }
          )
        end
      else
        format.html { render 'journals/show' }
      end
    end
  end

  def edit
    @journal = Journal.find(params[:journal_id])
    @entry = @journal.entries.find(params[:id])
  end

  def update
    @journal = Journal.find(params[:journal_id])
    @entry = @journal.entries.find(params[:id])

    respond_to do |format|
      if @entry.update(entry_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@entry) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @journal = Journal.find(params[:journal_id])
    @entry = @journal.entries.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@entry) }
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:text)
  end
end
