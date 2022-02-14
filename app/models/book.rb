class Book < ApplicationRecord
    has_many :stocks
    def created_at
        read_attribute(:created_at).strftime("%Y-%m-%d %H:%M:%S")
    end
    
    def updated_at
        read_attribute(:updated_at).strftime("%Y-%m-%d %H:%M:%S")
    end 
end
