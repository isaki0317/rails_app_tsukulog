class ImagesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process resize_to_limit: [597, nil]



  # 保存先条件分岐
  if Rails.env.development? || Rails.env.test?
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  else
    storage :fog
  end

   #アップロード可能な拡張子のリスト
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  # version :big do
  #   process resize_to_fit: [598, nil]
  # end

  version :medium do
    process resize_to_fit: [510, nil]
  end

  version :small do
    process resize_to_fit: [115, nil]
  end

  version :thumb do
    process resize_to_fit: [50, nil]
  end

  # version :thumb_big do
  #   process resize_to_fit: [150, nil]
  # end

  # version :thumb_small do
  #   process resize_to_fit: [30, nil]
  # end
  # デフォルト画像設定
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  # #   For Rails 3.1+ asset pipeline compatibility:
  #   ActionController::Base.helpers.asset_path("fallback/" + [version_name, "sample.jpg"].compact.join('_'))
  # #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

end
