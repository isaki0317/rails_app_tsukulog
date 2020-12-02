class ImagesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  process resize_to_limit: [200, 200]

　#AWSのS3ストレージ、本番環境ではS3に保存されるように設定
  # if Rails.env == 'production'
  #   storage :fog
  # else
  #   storage :file
  # end

  # 下記はデフォルトの保存先
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   #アップロード可能な拡張子のリスト
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

end
