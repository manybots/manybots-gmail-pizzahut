module ManybotsGmailPizzahut
  class EmailOrder
    
    def initialize(user_id, activity)
      @user_id = user_id
      
      @created_at = activity['published']
      @email_id = activity['object']['url'].split('/').last.to_i
    end
    
    def email
      @email ||= ManybotsGmail::Email.find(@email_id)
    end
    
    def body
      @body ||= email.body
    end

    def price
      @price ||= body.match(/^(- TOTAL A PAGAR:).+/).to_s.
        scan(/\d+/).join('.').to_f
    end
    
    def content
      @content ||= body.gsub(/(A sua nova).+./, '').
        split('- TOTAL A PAGAR').
        first.strip
    end
    
    def products
      @products ||= content.
        scan(/(.*)\s(\d+)\s+(\d+.\d+)\s+(\d+.\d+\s*$)/).
        collect { |item|
          ({
            name: item[0].split.join(' '),
            units: item[1].strip.to_i,
            price: item[2].strip.to_f,
            total: item[3].strip.to_f
          })
      }
    end
    
    def to_meal
      @meal = ManybotsGmailPizzahut::Meal.new
      @meal.user_id = @user_id
      @meal.ordered_at = @created_at
      @meal.price = self.price
      @meal.currency = 'EUR'
      @meal.products = self.products
      @meal.content = self.content
      @meal
    end
    
  end
end
