defmodule PeticeniWeb.AdminHTML do
  use PeticeniWeb, :html

  def index(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="-m-1.5 overflow-x-auto">
        <div class="inline-block min-w-full p-1.5 align-middle">
          <div class="overflow-hidden rounded-lg border dark:border-gray-700">
            <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
              <thead class="bg-gray-50 dark:bg-gray-700">
                <tr>
                  <th
                    :for={field <- @resource[:fields]}
                    scope="col"
                    class="px-6 py-3 text-left text-xs font-medium uppercase text-gray-500 dark:text-gray-400"
                  >
                    <%= Phoenix.Naming.humanize(field) %>
                  </th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
                <tr :for={row <- @rows} class="group hover:bg-gray-100 dark:hover:bg-gray-700">
                  <td :for={field <- @resource[:fields]} class="relative p-0">
                    <div class="whitespace-nowrap px-6 py-4 text-sm font-medium text-gray-800 dark:text-gray-200">
                      <span class="absolute -inset-y-px right-0 -left-4 group-hover:bg-gray-100 dark:group-hover:bg-gray-700 sm:rounded-l-xl" />
                      <span class="relative">
                        <%= Map.get(row, field) %>
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
