namespace :feature do 
    desc "Lectura de feature"
    task get_feature: :environment do
        response = Faraday.get("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")
        body = JSON.parse(response.body)

        body["features"].each do |feature|
            featureProperties = feature["properties"]
            featureGeometry = feature["geometry"]

            Feature.create(
                mag: featureProperties["mag"], 
                place: featureProperties["place"], 
                time: featureProperties["time"], 
                url: featureProperties["url"],
                tsunami: featureProperties["tsunami"],
                magType: featureProperties["magType"],
                title: featureProperties["title"],
                longitude: featureGeometry["coordinates"][0],
                latitude: featureGeometry["coordinates"][1],
                magnitud: featureGeometry["coordinates"][2]
            )
        end
    end
end