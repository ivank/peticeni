defmodule PeticeniWeb.Admin do
  use Phoenix.Component
  import PeticeniWeb.Gettext
  import PeticeniWeb.CoreComponents

  require Logger

  attr(:items, :list, required: true)
  attr(:fields, :list)
  attr(:meta, Flop.Meta, required: true)

  attr(:path, :string, doc: "The path to the resource")
  slot(:title, doc: "The titel")

  slot(:field, doc: "Custom fields") do
    attr(:label, :string)
  end

  def admin_index(assigns) do
    schema = assigns.meta.schema

    assigns =
      assigns
      |> assign(:fields, Map.get(assigns, :fields, schema.__schema__(:fields)))
      |> assign(:title, schema |> Module.split() |> List.last() |> Phoenix.Naming.humanize())
      |> assign(:item_pk, schema.__schema__(:primary_key) |> List.first())

    ~H"""
    <div class="flex flex-col">
      <div class="-m-1.5 overflow-x-auto">
        <div class="inline-block min-w-full p-1.5 align-middle">
          <div class="overflow-hidden rounded-lg border dark:border-gray-700">
            <div class="px-6 py-4 grid gap-3 md:flex md:justify-between md:items-center border-b border-gray-200 dark:border-gray-700">
              <div>
                <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200">
                  <%= @title %>
                </h2>
              </div>

              <div>
                <div class="inline-flex gap-x-2">
                  <.button_link size="small" color="green" navigate={"#{@path}/new"}>
                    <.icon name="hero-plus" />
                    <%= @title %>
                  </.button_link>
                </div>
              </div>
            </div>

            <Flop.Phoenix.table
              items={@items}
              meta={@meta}
              path={@path}
              opts={[
                table_attrs: [class: "min-w-full divide-y divide-gray-200 dark:divide-gray-700"],
                thead_attrs: [class: "bg-gray-50 dark:bg-gray-700"],
                thead_th_attrs: [
                  class:
                    "px-6 py-3 text-left text-xs font-medium uppercase text-gray-500 dark:text-gray-400"
                ],
                tbody_attrs: [class: "divide-y divide-gray-200 dark:divide-gray-700"],
                tbody_tr_attrs: [class: "group hover:bg-gray-100 dark:hover:bg-gray-700"],
                tbody_td_attrs: [
                  class:
                    "whitespace-nowrap px-6 py-4 text-sm font-medium text-gray-800 dark:text-gray-200"
                ]
              ]}
            >
              <:col
                :let={item}
                :for={field <- @fields}
                :if={Enum.empty?(@field)}
                label={Phoenix.Naming.humanize(field)}
              >
                <%= Map.get(item, field) %>
              </:col>

              <:col
                :let={item}
                :for={custom_field <- @field}
                :if={!Enum.empty?(@field)}
                label={custom_field.label}
              >
                <%= render_slot(custom_field, item) %>
              </:col>

              <:col :let={item} label={gettext("Actions")}>
                <div class="inline-flex gap-x-2">
                  <.button_link
                    size="small"
                    color="blue"
                    navigate={"#{@path}/#{Map.get(item, @item_pk)}/edit"}
                  >
                    <.icon name="hero-pencil" />
                    <%= gettext("Edit") %>
                  </.button_link>

                  <.button_link
                    size="small"
                    color="red"
                    navigate={"#{@path}/#{Map.get(item, @item_pk)}/delete"}
                  >
                    <.icon name="hero-trash" />
                    <%= gettext("Delete") %>
                  </.button_link>
                </div>
              </:col>
            </Flop.Phoenix.table>

            <Flop.Phoenix.pagination
              meta={@meta}
              path={@path}
              opts={[
                wrapper_attrs: [
                  class:
                    "px-6 py-4 grid gap-3 md:flex md:items-center border-t border-gray-200 dark:border-gray-700"
                ],
                disabled_class:
                  "border-gray-100 font-semibold text-gray-400 hover:text-gray-400 hover:bg-transparent hover:border-gray-200",
                pagination_list_attrs: [
                  class: "inline-flex gap-x-2"
                ],
                pagination_link_attrs: [
                  class:
                    "py-[.688rem] px-4 inline-flex justify-center items-center gap-2 rounded-md border-2 border-gray-200 font-semibold text-blue-500 hover:text-white hover:bg-blue-500 hover:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-all text-sm dark:border-gray-700 dark:hover:border-blue-500"
                ],
                next_link_attrs: [
                  class:
                    "py-[.688rem] px-4 mr-auto inline-flex justify-center items-center gap-2 rounded-md border-2 border-gray-200 font-semibold text-blue-500 hover:text-white hover:bg-blue-500 hover:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-all text-sm dark:border-gray-700 dark:hover:border-blue-500"
                ],
                previous_link_attrs: [
                  class:
                    "py-[.688rem] px-4 inline-flex justify-center items-center gap-2 rounded-md border-2 border-gray-200 font-semibold text-blue-500 hover:text-white hover:bg-blue-500 hover:border-blue-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-all text-sm dark:border-gray-700 dark:hover:border-blue-500"
                ],
                current_link_attrs: [
                  class:
                    "py-3 px-4 inline-flex justify-center items-center gap-2 rounded-md border-2 border-gray-100 font-semibold text-gray-400 hover:bg-white hover:border-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 transition-all text-sm dark:focus:ring-offset-gray-800"
                ]
              ]}
            />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
