defmodule PeticeniWeb.Admin do
  use Phoenix.Component
  import PeticeniWeb.Gettext

  # attr :schema, :struct, required: true
  attr :rows, :list, required: true
  attr :per_page, :integer, default: 10

  slot :field, required: true do
    attr :name, :string, required: true
    attr :label, :string
  end

  def index(assigns) do
    # rows = Repo.all(item(from @schema, limit: @per_page))

    ~H"""
    <div class="flex flex-col">
      <div class="-m-1.5 overflow-x-auto">
        <div class="inline-block min-w-full p-1.5 align-middle">
          <div class="overflow-hidden rounded-lg border dark:border-gray-700">
            <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
              <thead class="bg-gray-50 dark:bg-gray-700">
                <tr>
                  <th
                    :for={field <- @field}
                    scope="col"
                    class="px-6 py-3 text-left text-xs font-medium uppercase text-gray-500 dark:text-gray-400"
                  >
                    <%= field[:label] || Phoenix.Naming.humanize(field[:name]) %>
                  </th>
                  <th class="px-6 py-3 text-right text-xs font-medium uppercase text-gray-500 dark:text-gray-400">
                    <span class="sr-only"><%= gettext("Actions") %></span>
                  </th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                <tr :for={row <- @rows} class="group hover:bg-gray-100 dark:hover:bg-gray-700">
                  <td :for={col <- @field} class="p-0">
                    <div class="whitespace-nowrap px-6 py-4 text-sm font-medium text-gray-800 dark:text-gray-200">
                      <%= render_slot(col, row) %>
                    </div>
                  </td>

                  <td class="w-14 p-0">
                    <div class="whitespace-nowrap px-6 py-4 text-right text-sm font-medium">
                      <span class="ml-4 font-semibold leading-6 text-gray-800 hover:bg-gray-100 dark:text-gray-200 dark:hover:bg-gray-700">
                        <.link
                          href="/products/1/edit"
                          class="inline-flex items-center gap-x-1.5 text-sm font-medium text-blue-600 decoration-2 hover:underline"
                        >
                          Edit
                        </.link>
                      </span>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
