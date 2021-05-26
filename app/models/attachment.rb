class Attachment < ApplicationRecord
    belongs_to :article, required: true

    validates_presence_of :data
end
