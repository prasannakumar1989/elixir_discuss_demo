defmodule DiscussWeb.TopicController do
  # alias Math saves some keystrokes Math.add,
  # so that you can just call add

  use DiscussWeb, :controller
  # phoenix code sharing
  # reach into _web.ex

  alias Discuss.Topic
  alias Discuss.Repo

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html",
           changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} -> render conn, "new.html",
                                    changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html",
           changeset: changeset,
           topic: topic
  end

  def update(conn, %{"id" => topic_id,
                      "topic" => topic}) do

    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} -> render conn, "edit.html",
                          changeset: changeset,
                          topic: old_topic
    end
  end

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html",
           topics: topics
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "topic deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

end