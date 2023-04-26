class EntriesController < ApplicationController
  before_action :set_journal, only: %i[new create show edit update destroy index]

  def new
    @entry = @journal.entries.build
  end

  def create
    @journal = Journal.find(params[:journal_id])
    @entry = @journal.entries.new(entry_params)


    respond_to do |format|
      if @entry.save
        format.turbo_stream
        format.html { redirect_to journal_entries_url(@journal, @entry), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @journal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @entry = @journal.entries.find(params[:id])
  end

  def update
    @entry = @journal.entries.find(params[:id])

    respond_to do |format|
      if @entry.update(entry_params)
        format.turbo_stream
        format.html { redirect_to journal_entries_url(@journal, @entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
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

  def set_journal
    @journal = Journal.find(params[:journal_id])
  end

  def entry_params
    params.require(:entry).permit(:text)
  end
end
