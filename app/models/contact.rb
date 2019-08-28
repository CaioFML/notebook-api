class Contact < ApplicationRecord
  def author
    "Caio"
  end

  def kind_description
    self.kind.description
  end

  def as_json(options={})
    super(
      root: true,
      methods: [:kind_description, :author]
    )
  end

  belongs_to :kind
end
