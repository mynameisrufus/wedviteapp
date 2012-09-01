Paperclip::Attachment.default_options[:hash_secret] = "wedvitehash"
Paperclip::Attachment.default_options[:storage] = :fog
Paperclip::Attachment.default_options[:fog_directory] = "wedviteapp-#{Rails.env}"
Paperclip::Attachment.default_options[:fog_public] = true
Paperclip::Attachment.default_options[:fog_credentials] ={
  provider: "AWS",
  aws_access_key_id: 'AKIAIBSFKAL3RH3LUGWA',
  aws_secret_access_key: '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',
  region: 'us-east-1'
}
