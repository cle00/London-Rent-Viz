alias LdnRent.Nestoria
alias LdnRent.Repo
import Ecto.Query

defmodule LdnRent.Api.Nestoria do
  def begin() do
    page = 1
    query = from a in LdnRent.Underground, select: a.station_name_slug
    place_name_list = Repo.all(query)
    for place_name <- place_name_list do
      process(page, place_name)
    end
    {:ok, inserted_post} = LdnRent.Repo.insert(%LdnRent.NestoriaLogs{log: "PROCESS COMPLETE"})
    IO.puts "Bad request or empty listings"
  end

  def process(page, place_name) do
    url = "http://api.nestoria.co.uk/api?encoding=json&pretty=1&action=search_listings&country=uk&listing_type=rent&place_name=#{place_name}&number_of_results=50&page=#{page}"
    {:ok, inserted_post} = LdnRent.Repo.insert(%LdnRent.NestoriaLogs{log: Enum.join([place_name, url], " // ")})
    IO.puts Enum.join([place_name, url], " // ")
    Process.sleep(10000)
    case fetch(url) do
      {:ok, %{response: res, last_page: false, page: curr_page}} ->
        add_to_database(res["listings"], place_name)
        page = curr_page + 1
        process(page, place_name)
      {:ok, %{response: res, last_page: true}} ->
        add_to_database(res["listings"], place_name)
        {:ok, inserted_post} = LdnRent.Repo.insert(%LdnRent.NestoriaLogs{log: "Place name added"})
        IO.puts "Place name added"
      {:error, %{last_page: true}} ->
        {:ok, inserted_post} = LdnRent.Repo.insert(%LdnRent.NestoriaLogs{log: "Bad request or empty listings"})
        IO.puts "Bad request or empty listings"
    end
  end

  def fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{"response" => response} = Poison.Parser.parse!(body)
        case response do
          %{"application_response_code" => "200",
            "application_response_text" => "unknown location"} ->
            {:error, %{last_page: true}}
          %{"application_response_code" => "101",
            "total_results" => 0} ->
            {:error, %{last_page: true}}
          %{"application_response_code" => "100"} ->
            %{"total_pages" => total_pages,
              "page" => current_page} =  response
            {:ok, %{page: current_page,
              response: response,
              last_page: current_page >= total_pages}}
          %{"application_response_code" => "101"} ->
            %{"total_pages" => total_pages,
              "page" => current_page} =  response
            {:ok, %{page: current_page,
              response: response,
              last_page: current_page >= total_pages}}
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ok, inserted_post} = LdnRent.Repo.insert(%LdnRent.NestoriaLogs{log: "request not found"})
        IO.puts "request not found"
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:ok, inserted_post} = LdnRent.Repo.insert(%LdnRent.NestoriaLogs{log: "error, waiting 10 seconds..."})
        IO.puts "Error, waiting 10 seconds..."
        IO.inspect reason
        Process.sleep(10000)
        fetch(url)
    end
  end

  def add_to_database([head | tail], place_name) do
    head = Map.put(head, "place_name", place_name)
    changeset = Nestoria.changeset(%Nestoria{}, head)
    Repo.insert!(changeset)
    add_to_database(tail, place_name)
  end

  def add_to_database([], place_name) do
    {:ok, inserted_post} = LdnRent.Repo.insert(%LdnRent.NestoriaLogs{log: "URL finished"})
    IO.puts "URL finished..."
  end
end

# IO.inspect LdnRent.Api.Nestoria.begin()
