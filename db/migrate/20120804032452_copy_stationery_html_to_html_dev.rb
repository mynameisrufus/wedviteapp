class CopyStationeryHtmlToHtmlDev < ActiveRecord::Migration
  def change
    connection.execute <<EOL
UPDATE stationeries
  SET html_dev = html,
      example_wording_dev = example_wording,
      deployed_at = now()
EOL
  end
end
