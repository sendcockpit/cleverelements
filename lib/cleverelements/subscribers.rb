require 'cleverelements/resource'

module CleverElements
  class Subscribers < Resource
    def history_for(id)
      @client.api_get_subscriber_history({subscriberID: id}).body
    end

    def find_by_email(email)
      @client.api_get_subscriber_by_email({email: email}).body
    end

    def get_subscriptions(id)
      @client.api_get_subscriber_subscriptions({subscriberID: id}).body
    end

    def custom_fields
      @client.api_get_subscriber_fields.body
    end

    def create_custom_field(name, type = 1)
      @client.api_add_subscriber_field(customFieldName: name, customFieldType: type).body
    end

    def destroy_custom_field(id)
      @client.api_delete_subscriber_field(customFieldID: id).body
    end

    def create(attributes)
      # attributes = [
      #   {
      #     list_id: 335333,
      #     email: "2email@example.org",
      #     custom_fields: [
      #       {field_id: 818718, field_value: 'Master'},
      #     ]
      #   },
      #   {
      #     list_id: 335333,
      #     email: "3email@example.org",
      #     custom_fields: [
      #       {field_id: 818718, field_value: 'The Master'},
      #     ]
      #   }
      # ]
      @client.api_add_subscriber(build_subscriber_list(attributes)).body
    end

    def create_doi(attributes)
      @client.api_add_subscriber_doi(build_subscriber_list(attributes)).body
    end

    def unsubscribe(subscriber_list)
      # attributes = [
      #   {id: 290099412, list_id: 335333},
      #   {id: 290086837, list_id: 335333}
      # ]

      @client.api_unsubscribe_subscriber_from_list(build_subscriber_id_list(subscriber_list)).body
    end

    def unsubscribe_from_all(subscriber_list)
      @client.api_unsubscribe_subscriber_from_all(build_subscriber_id_list(subscriber_list)).body
    end

    def destroy(ids)
      # ids = [290099412, 290099401]
      @client.api_delete_subscriber(build_subscriber_id_list_short(ids)).body
    end

    private
    def build_subscriber_id_list_short(ids)
      {
        subscriberIDListShort: {
          item: ids.map do |id|
            {subscriberID: id}
          end
        }
      }
    end

    def build_subscriber_id_list(attributes)
      {
        subscriberIDList: {
          item: attributes.map do |attr|
            {subscriberID: attr[:id], listID: attr[:list_id]}
          end
        }
      }
    end

    def build_subscriber_list(attributes)
      attributes_array = attributes.map do |attributes_hsh|
        {
          listID: attributes_hsh[:list_id],
          email: attributes_hsh[:email],
          customFields: {
            item: build_custom_fields_array(attributes_hsh[:custom_fields])
          }
        }
      end
      {subscriberList: {item: attributes_array}}
    end

    def build_custom_fields_array(custom_fields)
      custom_fields.map do |custom_fields_hsh|
        { customFieldID: custom_fields_hsh[:field_id],
          customFieldValue: custom_fields_hsh[:field_value] }
      end
    end
  end
end
