defmodule Mirror.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:user) do
      add(:first_name, :text, null: false)
      add(:last_name, :text, null: false)
      add(:email, :text, null: false)
      add(:username, :text)
      add(:code, :text)

      timestamps()
    end

    create table(:reflections) do
      add(:user_id, references(:user))
      add(:learn, :text)
      add(:accomplish, :text)

      timestamps()
    end
  end
end
