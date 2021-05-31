defmodule MyApp.Post.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Users.User

  schema "topics" do
    field :title, :string
    field :content, :string
    # has_many :comments, Comment
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
