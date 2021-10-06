class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
        uniqueness: { case_sensitive: false},
        length: {maximum: 255},
        format: { with: VALID_EMAIL_REGEX }
    before_validation { email.downcase! }
    validates :password, presence: true,
        length: {minimum: 8},
        allow_nil: true
    # validates :lastname, presence: true,
    #     allow_nil: true
    # validates :firstname, presence: true,
    #     allow_nil: true
    has_secure_password
    has_many :tasks, dependent: :destroy

    before_destroy :check_if_last_admin, prepend: true
    before_update :check_if_admin, prepend: true
    paginates_per 5
    private
    def check_if_last_admin
        throw :abort if User.where(admin: true).count == 1
    end

    def check_if_admin
        self.admin = true if User.where(admin: true).count == 1
    end



    # def change_role
    #     unless self.new_record?
    #         if self.admin  
    #             unless User.where(admin: true).count == 1  
    #                 self.admin = !self.admin
    #             end
    #         else
    #             self.admin = !self.admin
    #         end    
    #     end
    # end
    # def destroy_action
    #     if User.where(admin: true).count == 1 && self.admin
    #     throw(:abort)
    #     end
    # end

    # def update_action
    #     user = User.where(id: self.id).where(admin: true)
    #     # binding.irb
    #     if User.where(admin: true).count == 1 && user.present? && self.admin == false
    #     errors.add(:admin, 'It cannot be removed from. At least one administrator is required')
    #     throw(:abort)
    #     end
    # end
end
