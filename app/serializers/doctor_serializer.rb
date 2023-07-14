class DoctorSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :bio, :image_url

  def image_url
    if object.image.attached?
      url_for(object.image)
    end
  end
end
