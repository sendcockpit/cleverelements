# cleverelements

## Quick Start

### Set up client
```
require 'cleverlements'

client = CleverElements::Client.new('API_ID', 'API_KEY', 'live') # Use test if you do not want to write to the API
```

### Get all mailing lists
```
client.lists.all
```

### Get specific list
```
client.lists.find(LIST_ID)
```

### Get all subscribers for a specific list
```
client.lists.get_subscribers(LIST_ID)
```

### Add new subscriber(s) to list
```
subscribers = [
  {
    list_id: LIST_ID,
    email: 'subscriber@domain.com'
    custom_fields: [{field_id: 818718, field_value: 'Sir'}]
  },
  {
    list_id: LIST_ID,
    email: 'subscriber2@domain.com'
    custom_fields: [{field_id: 818718, field_value: 'Madam'}]
  }
]

client.subscribers.create(subscribers)
```

### Find subscriber by email
```
client.subscribers.find_by_email('subscriber@domain.com')
```
