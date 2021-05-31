defmodule MyApp.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Users.User
  alias MyApp.Post.Topic

  schema "comments" do
    field :tag, :string
    field :text, :string
    belongs_to :user, User
    belongs_to :topic, Topic
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :tag])
    |> validate_required([:text, :tag])
  end
end
