module MovesMapper
  class ProfileMapper < Faceter::Mapper
    symbolize_keys

    unwrap from: :profile, only: [:localization, :firstDate]
    unwrap from: :localization, only: [:metric, :locale]

    rename :firstDate, to: :created_at
    rename :userId, to: :id

    wrap to: :attributes, only: [:id, :locale, :metric, :created_at]

    create nil, from: [:attributes] do |attributes|
      Profile.new(attributes)
    end

  end

end