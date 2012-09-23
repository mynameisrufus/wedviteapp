class WeddingWordingValidator < ActiveModel::Validator
  def validate record
    wording = record.send(options[:attribute])

    record.errors[options[:attribute]] << error_message unless
      test wording, guest_tag_test
  end

  def test wording, test
    !(wording =~ test).nil?
  end

  def guest_tag_test
    /{{(\s|)guest.name(\s|)}}/
  end

  def error_message
<<EOL
Your invitation has lost it's tag for the guests name! ake sure you have this tag in your invitation:
<code>
  {{ guest.name }}
</code>
EOL
  end
end
