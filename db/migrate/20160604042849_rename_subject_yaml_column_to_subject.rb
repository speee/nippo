class RenameSubjectYamlColumnToSubject < ActiveRecord::Migration[5.0]
  def change
    rename_column :templates, :subject_yaml, :subject
    rename_column :nippos,    :subject_yaml, :subject
  end
end
