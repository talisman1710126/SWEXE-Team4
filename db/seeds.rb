# 初期スポットデータ（出典は notes/廣地/spot-sources.md）
# 何回 db:seed を実行しても重複しないよう、name_ja で find_or_create_by! する
spots = [
  {
    name_ja: "温井ダム", name_en: "Nukui Dam", category: :dam,
    description_en: "A 156 m high concrete arch dam on the Takiyama River, a tributary of the Ota River. It is the second highest arch dam in Japan and began operation in 2002. Visitors can take an underground elevator and walk through a tunnel to see the dam up close.",
    access: "About 20 min by car from Togouchi IC, or 15 min from Kake Smart IC (Chugoku Expressway)",
    latitude: 34.634250, longitude: 132.299667
  },
  {
    name_ja: "土師ダム", name_en: "Haji Dam", category: :dam,
    description_en: "A dam on the Gonokawa River in Akitakata, completed in 1974. Its dam body bends partway across the valley and has yellow gates, and the area is one of the best-known cherry blossom spots in western Japan.",
    access: "Akitakata City, Hiroshima Prefecture (car recommended)",
    latitude: 34.64361, longitude: 132.62111
  },
  {
    name_ja: "灰塚ダム", name_en: "Haizuka Dam", category: :dam,
    description_en: "A dam on the Joge River whose main feature is a discharge facility built mainly to protect the river environment. It was the first dam in the world to use a two-axis supported tension radial gate.",
    access: "About 15 min by car from Miyoshi-Mirasaka IC (Onomichi-Matsue Expressway), or 7 km from Mirasaka Station",
    latitude: 34.78083, longitude: 132.98778
  },
  {
    name_ja: "八田原ダム", name_en: "Hattabara Dam", category: :dam,
    description_en: "An 84.9 m high, 325 m long concrete gravity dam on the Ashida River, completed in 1997. Part of the inside of the dam body is open to visitors free of charge.",
    access: "3 km (about 7 min by car) from JR Kawasa Station, or about 20 min by car from Sera IC",
    latitude: 34.58861, longitude: 133.14556
  },
  {
    name_ja: "本庄水源地堰堤（本庄ダム）", name_en: "Honjo Dam", category: :dam,
    description_en: "A 25 m high, 97 m long gravity dam built by the Imperial Navy in 1918 to supply water to the Kure naval base. Faced with granite, it was said to be the largest in East Asia at the time. In 1999 it became the first working waterworks in Japan to be designated an Important Cultural Property. It is open to the public only during the cherry blossom season.",
    access: "About 30 min by bus from JR Kure Station (Platform 1), get off at Izumigaoka Danchi",
    latitude: 34.308028, longitude: 132.562167
  },
  {
    name_ja: "音戸大橋", name_en: "Ondo Bridge", category: :bridge,
    description_en: "A red bridge opened in 1961 over the Ondo Strait, which is only about 90 m wide at its narrowest and is used by around 700 ships a day. To let 1,000-ton ships pass underneath without piers in the water, the approaches climb in a double loop on the Kure side and a spiral on the island side.",
    access: "Bus from JR Kure Station to Ondo Tosen-guchi, then 1 min walk",
    latitude: 34.19500, longitude: 132.53722
  },
  {
    name_ja: "安芸灘大橋", name_en: "Akinada Bridge", category: :bridge,
    description_en: "A suspension bridge with a 750 m main span, opened in 2000. It links the mainland to Shimo-kamagari Island and is the gateway to the Akinada Tobishima Kaido island route. Cyclists and pedestrians can cross it free of charge.",
    access: "About 30 min by car from Kure IC (Hiroshima-Kure Road)",
    latitude: 34.20611, longitude: 132.67944
  },
  {
    name_ja: "蒲刈大橋", name_en: "Kamagari Bridge", category: :bridge,
    description_en: "A 480 m truss bridge opened in 1979 between Kami-kamagari and Shimo-kamagari islands. When completed it was the longest farm-road bridge in Japan, and it was the first truss bridge erected in large blocks with a floating crane.",
    access: "Cross Akinada Bridge to Shimo-kamagari Island, then continue along the Akinada Tobishima Kaido",
    latitude: 34.184833, longitude: 132.684278
  },
  {
    name_ja: "因島大橋", name_en: "Innoshima Bridge", category: :bridge,
    description_en: "A suspension bridge with a 770 m main span, opened in 1983 on the Shimanami Kaido. Its deck sits 50 m above high tide so large ships can pass. The upper deck carries cars, and the lower deck is a path for bicycles and pedestrians.",
    access: "On the Shimanami Kaido (Nishiseto Expressway) between Mukaishima and Innoshima; walk or cycle on the lower deck",
    latitude: 34.35694, longitude: 133.18028
  },
  {
    name_ja: "鞆港（常夜燈・雁木）", name_en: "Tomo Port", category: :port,
    description_en: "A historic port where ships once waited for the tide. It is the only port in Japan that still has all five Edo-period harbor facilities: the stone lantern lighthouse (Joyato), stone landing steps (Gangi), breakwater, ship-repair yard and guardhouse. The Joyato, built in 1859, is 11 m tall from its underwater base.",
    access: "About 30 min by Tomotetsu Bus from JR Fukuyama Station (south exit), get off at Tomoko, then about 10 min walk",
    latitude: 34.380762, longitude: 133.380111
  }
]

spots.each do |attrs|
  Spot.find_or_create_by!(name_ja: attrs[:name_ja]) do |spot|
    spot.assign_attributes(attrs)
  end
end

puts "Spots: #{Spot.count}"
