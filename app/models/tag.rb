class Tag < ApplicationRecord
    before_save :downcase_name
    
    validates :name, presence: true, uniqueness: true
	validates :name, length: {minimum: 2, maximum: 15}
    
    has_many :taggings, dependent: :destroy
    
    has_many :projects, :through => :taggings, :source => :taggable, :source_type => 'Project'

    private

    # Converts name to all lowercase.
    def downcase_name
        self.name.downcase!
    end
end
