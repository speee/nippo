# frozen_string_literal: true
class NipposController < PrivateController
  include NippoHandleable

  def new
    @nippo = Nippo.new(
      body: current_user.template.body,
      reported_for: Nippo.default_report_date,
    )
  end

  def create
    if @nippo = Nippo.create(nippo_create_params)
      send_nippo
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render :new
    end
  end

  def update
    if update_nippo
      send_nippo
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render :show
    end
  end

  def show
    if @nippo.sent?
      reaction = Reaction.find_or_create_by(user: current_user, nippo: @nippo)
      Reaction.increment_counter(:page_view, reaction.id)
    end
  end

  private

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
end
