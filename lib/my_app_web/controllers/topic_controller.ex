defmodule MyAppWeb.TopicController do
  use MyAppWeb, :controller

  alias MyApp.Post
  alias MyApp.Post.Topic

  def index(conn, _params) do
    topics = Post.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    current_user = conn.assigns.current_user
    changeset = Post.change_topic(%Topic{}, current_user)
    IO.puts("XXxxxxxxxxxxx")
    IO.inspect(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    # IO.inspect(conn)
    current_user = conn.assigns.current_user
    IO.inspect(current_user)
    case Post.create_topic(current_user, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: Routes.topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Post.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic = Post.get_topic!(id)
    current_user = conn.assigns.current_user
    changeset = Post.change_topic(topic, current_user)
    render(conn, "edit.html", topic: topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Post.get_topic!(id)
    current_user = conn.assigns.current_user

    case Post.update_topic(topic, current_user, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: Routes.topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Post.get_topic!(id)
    {:ok, _topic} = Post.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
