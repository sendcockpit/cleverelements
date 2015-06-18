require 'savon'
require 'cleverelements/lists'
require 'cleverelements/subscribers'

module CleverElements
  class Client
    API_VERSION = "1.0"
    attr_reader :savon

    def initialize(api_id, api_key, mode = 'test')
      # cli = CleverElements::Client.new('195753', 'ua4zhTpLPaZ9wfpD', 'live')
      # cli.lists.all
      # cli.subscribers.find_by_email('email@example.org')
      # cli.request(:api_get_list)
      # cli.request(:api_get_list_details, {listID: 335333})
      # sub_proxy = CleverElements::Subscribers.new(cli)
      # sub_proxy.find_by_email('email@example.org')

      @savon = Savon.client do
        wsdl 'http://api.sendcockpit.com/server.php?wsdl'
        convert_request_keys_to :none
        soap_header({
          validate: {
            userid: api_id,
            apikey: api_key,
            version: API_VERSION,
            mode: mode,
          }
        })
      end
      define_methods
    end

    def request(operation, data = {})
      @savon.call(operation, build_data(operation, data))
    end

    def build(operation, data = {})
      @savon.operation(operation).build(build_data(operation, data)).to_s
    end

    def define_methods
      @savon.operations.each do |method|
        self.class.send(:define_method, method) do |args = {}|
          request(method, args)
        end
      end
    end

    def subscribers
      CleverElements::Subscribers.new(self)
    end

    def lists
      CleverElements::Lists.new(self)
    end

    private
    def build_data(operation, data)
      hash = {}
      if operation_ct[operation]
        hash[:message] = {operation_ct[operation] => data}
      end
      hash
    end

    def operation_ct
      # wsdl.parser.document.css('message[name*=Request]').first.children.css('part').first.attributes["name"].value
      {
        api_add_subscriber: :ctSubscriberRequest,
        api_add_subscriber_doi: :ctSubscriberRequest,
        api_add_subscriber_field: :ctAddSubscriberFields,
        api_delete_list: :ctListDetailsRequest,
        api_delete_subscriber: :ctGetSubscriberIDListShort,
        api_delete_subscriber_field: :ctDeleteSubscriberFields,
        api_get_list_details: :ctListDetailsRequest,
        api_add_list: :ctAddListRequest,
        api_get_subscriber: :ctListRequest,
        api_get_subscriber_details: :ctListRequest,
        api_get_subscriber_by_email: :ctSubscriberEmailRequest,
        api_get_subscriber_history: :ctGetSubscriberID,
        api_get_subscriber_subscriptions: :ctSubscriberSubscriptionsRequest,
        api_get_subscriber_unsubscribes: :ctListRequest,
        api_unsubscribe_subscriber_from_all: :ctGetSubscriberIDList,
        api_unsubscribe_subscriber_from_list: :ctGetSubscriberIDList,
      }
    end
  end
end
