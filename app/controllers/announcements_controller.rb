class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.includes(:galleries).for_index.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    @announcements = Announcement.for_index
    
    @announcements.each_with_index do |announcement, index|
      @index_of_record = index if announcement == @announcement
    end
    
    @announcements[@index_of_record+1] ? @next_announcement = @announcements[@index_of_record+1] : @next_announcement = nil
    if @index_of_record == 0
      @previous_announcement = nil
    else
      @announcements[@index_of_record-1] ? @previous_announcement = @announcements[@index_of_record-1] : @previous_announcement = nil
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end
end
