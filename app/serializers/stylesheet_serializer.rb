class StylesheetSerializer < ActiveModel::Serializer
  include ActionController::Serialization

  attributes :id, :url
end
