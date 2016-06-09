# frozen_string_literal: true
class MesController < PrivateController
  def show
    @my_nippos = Nippo
                 .where(user: current_user)
                 .order(sent_at: :desc)
  end
end
