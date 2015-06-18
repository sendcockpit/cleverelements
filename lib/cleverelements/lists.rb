require 'cleverelements/resource'

module CleverElements
  class Lists < Resource
    def all
      @client.api_get_list.body
    end

    def find(id)
      @client.api_get_list_details({listID: id}).body
    end

    def create(name = "", description = "")
      @client.api_add_list(listName: name, listDescription: description).body
    end

    def destroy(id)
      @client.api_delete_list({listID: id}).body
    end

    def get_subscribers(list_id, offset = 0, limit = 100)
      # cli.lists.get_subscribers(335333, 0, 100)
      @client.api_get_subscriber({listID: list_id, start: offset, count: limit}).body
    end

    def get_subscribers_with_details(list_id, offset = 0, limit = 100)
      # cli.lists.get_subscribers_with_details(335333, 0, 100)
      @client.api_get_subscriber_details({listID: list_id, start: offset, count: limit}).body
    end

    def get_unsubscribed(list_id, offset = 0, limit = 100)
      # cli.lists.get_unsubscribed(335333, 0, 100)
      @client.api_get_subscriber_unsubscribes({listID: list_id, start: offset, count: limit}).body
    end
  end
end

