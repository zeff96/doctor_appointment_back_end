class DoctorSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :bio, :image, :social_media, :location, :payment

  def social_media
    {
      facebook: object.social_medium.facebook,
      twitter: object.social_medium.twitter,
      instagram: object.social_medium.instagram
    }
  end

  def location
    {
      address: object.location.address,
      city: object.location.city,
      state: object.location.state,
      zip_code: object.location.zip_code
    }
  end

  def payment
    {
      amount: object.payment.consultation_fee
    }
  end
end
