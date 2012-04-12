module ManybotsGmailPizzahut
  class Meal < ActiveRecord::Base
    store :payload, accessors: [:price, :currency, :products, :content]
    
    def self.create_from_activity(user_id, activity)
      email_order_id = activity['object']['id'].split('/').last.to_i
      meal = self.find_or_initialize_by_user_id_and_email_order_id(user_id, email_order_id)
      if meal.new_record?
        meal = ManybotsGmailPizzahut::EmailOrder.new(user_id, activity).to_meal
        meal.email_order_id = email_order_id
        meal.save
        meal
      else
        false
      end
    end
    
    def as_activity
      activity = {
        title: "ACTOR ordered a OBJECT from TARGET",
        auto_title: true,
        verb: 'order',
        published: self.ordered_at.xmlschema,
        icon: {
          url: ManybotsServer.url + ManybotsGmailPizzahut.app.app_icon_url
        },
        content: self.content
      }
      # activity[:actor] = {
      #   displayName: self.user.name || self.user.email,
      #   objectType: 'person',
      #   id: "#{ManybotsServer.url}/users/#{self.user.id}",
      #   url: "#{ManybotsServer.url}/users/#{self.user.id}",
      #   image: {
      #     url: self.user.avatar_url
      #   }
      # }

      activity[:object] = {
        displayName: 'Meal',
        objectType: 'meal',
        id: "#{ManybotsGmailPizzahut.app.url}/meals/#{self.id}",
        url: "#{ManybotsGmailPizzahut.app.url}/meals/#{self.id}",
        price: {
          currency: self.currency,
          value: self.price
        },
        attachments: self.products.collect {|product|
          ({
            displayName: product[:name],
            objectType: 'product',
            units: product[:units],
            price: {
              currency: self.currency,
              unit: product[:price],
              total: product[:total]
            },
            id: "#{ManybotsGmailPizzahut.app.url}/products/#{Digest::MD5.hexdigest(product[:name])}",
            url: "#{ManybotsGmailPizzahut.app.url}/products/#{Digest::MD5.hexdigest(product[:name])}"
          })
        }
      }
      activity[:target] = {
        displayName: 'Pizzahut PT',
        objectType: 'person',
        id: "http://www.pizzahut.pt",
        url: "http://www.pizzahut.pt"
      }
      activity[:provider] = {
        :displayName => 'Pizzahut PT',
        :url => "http://www.pizzahut.pt",
        :image => {
          :url => ManybotsServer.url + ManybotsGmailPizzahut.app.app_icon_url
        }
      }
      activity[:generator] = {
        :displayName => 'Pizzahut PT Agent',
        :url => ManybotsGmailPizzahut.app.url,
        :image => {
          :url => ManybotsServer.url + ManybotsGmailPizzahut.app.app_icon_url
        }
      }

      activity
    end
    
  end
end
