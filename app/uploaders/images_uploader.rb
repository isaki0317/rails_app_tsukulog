class ImagesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process resize_to_limit: [540, nil]



  # 下記はデフォルトの保存先
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   #アップロード可能な拡張子のリスト
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  version :big do
    process resize_to_fit: [598, nil]
  end

  version :thumb do
    process resize_to_fit: [510, nil]
  end

  version :small do
    process resize_to_fit: [115, nil]
  end

  # デフォルト画像設定
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  # #   For Rails 3.1+ asset pipeline compatibility:
  #   ActionController::Base.helpers.asset_path("fallback/" + [version_name, "sample.jpg"].compact.join('_'))
  # #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

end
