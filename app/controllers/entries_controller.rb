class EntriesController < ApplicationController
  before_action :set_journal
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = @journal.entries
  end

  def show
  end

  def new
    @entry = @journal.entries.build
  end

  def edit
  end

  def create
    @entry = @journal.entries.build(entry_params)

    if @entry.save
      redirect_to @journal, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  def update
    if @entry.update(entry_params)
      redirect_to [@journal, @entry], notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to @journal, notice: 'Entry was successfully destroyed.'
  end

  private
    def set_journal
      @journal = Journal.find(params[:journal_id])
    end

    def set_entry
      @entry = @journal.entries.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:text)
    end
end
