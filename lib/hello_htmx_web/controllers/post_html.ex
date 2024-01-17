defmodule HelloHtmxWeb.PostHTML do
  use HelloHtmxWeb, :html

  def index(assigns) do
    ~H"""
    <.header>
      Listing Posts
      <:actions>
        <.link href={~p"/posts/new"}>
          <.button>New Post</.button>
        </.link>
      </:actions>
    </.header>

    <.table id="posts" rows={@posts}>
      <:col :let={post} label="Title"><%= post.title %></:col>
      <:col :let={post} label="Body"><%= post.body %></:col>
      <:col :let={post} label="Author"><%= post.author %></:col>
      <:action :let={post}>
        <.link navigate={~p"/posts/#{post}"}>Show</.link>
      </:action>
      <:action :let={post}>
        <a href="#" hx-target="body" hx-delete={~p"/posts/#{post}"} hx-confirm="Are you sure?">
          Delete
        </a>
      </:action>
    </.table>
    """
  end

  def show(assigns) do
    ~H"""
    <.header>
      Post <%= @post.id %>
      <:subtitle>This is a post record from your database.</:subtitle>
      <:actions>
        <a
          hx-select={"#post#{@post.id}"}
          hx-target={"#post#{@post.id}"}
          hx-swap="outerHTML"
          hx-get={~p"/posts/#{@post}/edit"}
        >
          <.button>Edit post</.button>
        </a>
      </:actions>
    </.header>

    <.list id={"post#{@post.id}"}>
      <:item title="Title"><%= @post.title %></:item>
      <:item title="Body"><%= @post.body %></:item>
      <:item title="Author"><%= @post.author %></:item>
    </.list>

    <.back navigate={~p"/posts"}>Back to posts</.back>
    """
  end

  def new(assigns) do
    ~H"""
    <.header>
      New Post
      <:subtitle>Use this form to manage post records in your database.</:subtitle>
    </.header>

    <.post_form id="post-new" changeset={@changeset} action={~p"/posts"} />

    <.back navigate={~p"/posts"}>Back to posts</.back>
    """
  end

  def edit(assigns) do
    ~H"""
    <.post_form id={"post#{@post.id}"} changeset={@changeset} action={~p"/posts/#{@post}"} />
    """
  end

  @doc """
  Renders a post form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :id, :string, required: true

  def post_form(assigns) do
    ~H"""
    <.simple_form :let={f} id={@id} for={@changeset} action={@action}>
      <.error :if={@changeset.action}>
        Oops, something went wrong! Please check the errors below.
      </.error>
      <.input field={f[:title]} type="text" label="Title" />
      <.input field={f[:body]} type="text" label="Body" />
      <.input field={f[:author]} type="text" label="Author" />
      <:actions>
        <.button>Save Post</.button>
      </:actions>
    </.simple_form>
    """
  end
end
