defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title]) # changeset is the first argument

    # #Ecto.Changeset is the object that will be saved
  end

  # topic -> record that is present in db
  # attrs -> what it should be
  # changeset
end
