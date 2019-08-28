class Contact < ApplicationRecord
  def to_br
    {
      name: self.name,
      email: self.email,
      birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank? )
    }
  end

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

  belongs_to :kind # optional: true
end
