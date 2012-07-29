require 'nokogiri'

class StationeryMarkupValidator < ActiveModel::Validator
  def validate record
    doc   = Nokogiri::HTML record.send(options[:attribute])
    links = doc.css '.actions a'

    unless test(links, href_tests) && test(links, content_tests)
      record.errors[options[:attribute]] << error_message
    end
  end

  def test links, tests
    links.each_with_index.map do |link, index|
      tests[index] =~ link['href']
    end.compact.size == 2
  end

  def href_tests
    %w(accept decline).map do |action|
      /{{(\s|)urls.#{action}(\s|)}}/
    end
  end

  def content_tests
    %w(accept decline).map do |action|
      /#{action}/i
    end
  end

  def error_message
<<EOL
Stationery markup is invalid, please format correctly:
<code>
  <div class="actions>
    <a href="{{ urls.accept }}">Accept</a>
    <d href="{{ urls.decline }}">Decline</a>
  </div>
</code>
EOL
  end
end
