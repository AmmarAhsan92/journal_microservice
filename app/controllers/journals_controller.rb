class JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  def index

    @journals = Journal.all
  end

  def show
  end

  def new
    @journal = Journal.new
  end

  def edit
  end

  def create
    @journal = Journal.new(journal_params)

    if @journal.save
      redirect_to @journal, notice: 'Journal was successfully created.'
    else
      render :new
    end
  end

  def update
    if @journal.update(journal_params)
      redirect_to @journal, notice: 'Journal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @journal.destroy
    redirect_to journals_url, notice: 'Journal was successfully destroyed.'
  end

  private
    def set_journal
      @journal = Journal.find(params[:id])
    end

    def journal_params
      params.require(:journal).permit(:name)
    end
end