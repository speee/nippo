# frozen_string_literal: true
class TemplatesController < PrivateController
  def show
    @template = current_user.template
  end

  def update
    @template = Template.find_by(id: params[:template][:id])
    redirect_to template_path if @template.blank? || @template.user != current_user

    if @template.update(template_params)
      redirect_to template_path
    else
      render :show
    end
  end

  private

  def template_params
    params.require(:template).permit(
      :subject_yaml,
      :body,
    )
  end
end
