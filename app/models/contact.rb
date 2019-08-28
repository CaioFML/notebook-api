class Contact < ApplicationRecord
  def author
    "Caio"
  end

  def as_json(options={})
    super(methods: :author, root: true)
  end

  belongs_to :kind
end
