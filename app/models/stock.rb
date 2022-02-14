class Stock < ApplicationRecord
    belongs_to :user
    belongs_to :book

    scope :with_start_date, proc { |start_date|
        if start_date.present?
            where("created_at::date>=?",start_date)
        end
    }

    scope :with_end_date, proc{ |end_date|
        if end_date.present?
            where("created_at::date<=?",end_date)
        end
    }

    scope :with_book_id , proc { |book_id|
        if book_id.present?
            # joins("inner join books on books.id=stocks.book_id").where("books.id=?",book_id)
            where("book_id=?",book_id)
        end 
    }

    scope :with_user_id, proc { |user_id| 
        if user_id.present?
            where("user_id=?",user_id)
        end 
    }

    scope :with_movement_type , proc { |movement_type|
        if movement_type.present? 
            where("movement_type=?",movement_type)
        end 
    }

    def created_at
        read_attribute(:created_at).strftime("%Y-%m-%d %H:%M:%S")
    end 

    def updated_at 
        read_attribute(:updated_at).strftime("%Y-%m-%d %H:%M:%S")
    end 
    
end
