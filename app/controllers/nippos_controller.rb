# frozen_string_literal: true
class NipposController < PrivateController
  def new
    @nippo = Nippo.new(
      body: current_user.template.body,
      reported_for: Nippo.default_report_date,
    )
  end

  def create
    @nippo = Nippo.new(nippo_params)

    if params[:back]
      render :new
    elsif params[:preview]
      preview
    elsif @nippo.save
      send_nippo
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render :new
    end
  end

  def show
    @nippo = Nippo.find(params[:id])
    reaction = Reaction.find_or_create_by(user: current_user, nippo: @nippo)
    Reaction.increment_counter(:page_view, reaction.id)
  end

  private

  def preview
    if @nippo.valid?
      render :preview
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render :new
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

  def nippo_params
    params.require(:nippo).permit(:body, :reported_for).merge(
      user: current_user,
      subject: current_user.template.subject,
    )
  end

  def current_report_date
    Time.zone.today
  end
end
