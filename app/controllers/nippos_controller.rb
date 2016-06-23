# frozen_string_literal: true
class NipposController < PrivateController
  before_action :set_nippo, only: %i(show update)
  before_action :check_status, only: %i(update)

  def new
    @nippo = Nippo.new(
      body: current_user.template.body,
      reported_for: Nippo.default_report_date,
    )
  end

  def create
    @nippo = Nippo.new(nippo_create_params)

    if params[:back]
      render back_view
    elsif params[:preview]
      preview
    elsif params[:draft]
      save_as_draft
    else
      save_and_send
    end
  end

  def update
    if params[:back]
      @nippo.attributes = nippo_update_params
      render back_view
    elsif params[:preview]
      @nippo.attributes = nippo_update_params
      preview
    elsif params[:draft]
      save_as_draft { update_draft }
    else
      save_and_send { update_draft }
    end
  end

  def show
    if @nippo.sent?
      reaction = Reaction.find_or_create_by(user: current_user, nippo: @nippo)
      Reaction.increment_counter(:page_view, reaction.id)
    end
  end

  private

  def set_nippo
    @nippo = Nippo.find(params[:id])
  end

  def check_status
    return if @nippo.draft?

    flash[:alert] = 'この日報は送信済みです'
    redirect_to nippo_path(@nippo)
  end

  def preview
    if @nippo.valid?
      render :preview
    else
      back_with_errors
    end
  end

  def save_as_draft
    if block_given? ? yield : @nippo.save
      flash[:notice] = '日報を下書き保存しました'
      redirect_to nippo_path(@nippo)
    else
      back_with_errors
    end
  end

  def save_and_send
    if block_given? ? yield : @nippo.save
      send_nippo
    else
      back_with_errors
    end
  end

  def update_draft
    Nippo.transaction do
      @nippo.lock!
      @nippo.attributes = nippo_update_params
      @nippo.save
    end
  end

  def send_nippo
    sender = NippoSender.new(nippo: @nippo)
    if sender.run
      flash[:notice] = '日報を送信しました'
      redirect_to root_path
    else
      flash[:alert] = sender.errors.full_messages
      redirect_to nippo_path(@nippo)
    end
  end

  def back_view
    case params[:action]
    when 'create' then :new
    when 'update' then :show
    end
  end

  def back_with_errors
    flash.now[:alert] = @nippo.errors.full_messages
    render back_view
  end

  def nippo_create_params
    params.require(:nippo).permit(:body, :reported_for).merge(
      user: current_user,
      subject: current_user.template.subject,
    )
  end

  def nippo_update_params
    params.require(:nippo).permit(:body)
  end

  def current_report_date
    Time.zone.today
  end
end
