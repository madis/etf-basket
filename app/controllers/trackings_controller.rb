class TrackingsController < ApplicationController
  def edit
    @tracking = Tracking.find(params[:id])
    @etf = @tracking.etf
  end
end
