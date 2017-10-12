class ThingsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show
    @thing = Thing.where(external_key: params[:key]).first unless params[:key].blank?
  end

  def update_description
    @thing = Thing.where(external_key: params[:key]).first
    @thing.description = params[:description]
    @thing.save
    render json: {message: 'success'}
  end

  def update_attribute
    @thing = Thing.where(external_key: params[:key]).first
    att = @thing.atts.where(name: params[:attribute]).first
    att.value = params[:value]
    att.save
    render json: {message: 'success'}
  end

  def update_code
    @thing = Thing.where(external_key: params[:key]).first
    code = @thing.codes.where(name: params[:code]).first
    code.code = params[:value]
    code.save
    render json: {message: 'success'}
  end

  def execute_code
    @thing = Thing.where(external_key: params[:key]).first
    QueuedCommand.create(thing_id: @thing.id, name: params[:code], parameters: params[:params])
    render json: {message: 'success'}
  end

end
