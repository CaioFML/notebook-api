class Contact < ApplicationRecord
  has_many :phones
  belongs_to :kind # optional: true
  accepts_nested_attributes_for :phones

  def as_json(options={})
    h = super(options)
    h[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank? )
    h
  end

  # def to_br
  #   {
  #     name: self.name,
  #     email: self.email,
  #     birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank? )
  #   }
  # end

  # def author
  #   "Caio"
  # end

  # def kind_description
  #   self.kind.description
  # end

  # def as_json(options={})
  #   super(
  #     root: true,
  #     methods: %i[kind_description author]
  #   )
  # end

end
