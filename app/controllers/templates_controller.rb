# frozen_string_literal: true
class TemplatesController < PrivateController
  def show
    @template = current_user.template
  end

  def update
    @template = Template.find_by(id: params[:template][:id])
    redirect_to template_path if @template.blank? || @template.user != current_user

    first_update = !@template.user_updated?

    if @template.update(template_params)
      flash[:notice] = 'テンプレートを保存しました'
      flash[:first_update] = first_update
      redirect_to template_path
    else
      flash.now[:alert] = @template.errors.values.flatten
      render :show
    end
  end

  private

  def template_params
    params.require(:template).permit(
      :subject,
      :body,
      :from_name,
      :cc,
    )
  end
end
