RSpec.describe RickAndMortyDubDub::Location do
  describe "all locations", vcr: { cassette_name: "lib/location/all_locations" } do
    let(:instance) { described_class.new }
    let(:result) { instance.all }

    it { expect(result[:body]).to be_a_kind_of(Hash) }
    it { expect(result[:status]).to eq(200) }
  end

  describe "pagination", vcr: { cassette_name: "lib/location/pagination" } do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.all }

    it "when 3 page" do
      @params = { page: 3 }
      expect(result[:body]["info"]["prev"]).to eq("https://rickandmortyapi.com/api/location/?page=2")
      expect(result[:body]["info"]["next"]).to eq("https://rickandmortyapi.com/api/location/?page=4")
    end
  end

  describe "finder location" do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.finder }
    it "single character" do
      @params = { id: 1 }
      VCR.use_cassette("lib/location/single_location") do
        expect(result[:body]).to be_a_kind_of(Hash)
        expect(result[:body]["id"]).to eq(1)
      end
    end

    it "multiple characters" do
      @params = { id: [1, 2] }
      VCR.use_cassette("lib/location/multiple_locations") do
        expect(result[:body]).to be_a_kind_of(Array)
        expect(result[:body].size).to eq(2)
      end
    end
  end

  describe "finder by filter" do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.filter }
    it "by name", vcr: { cassette_name: "lib/location/filter/name" } do
      @params = { name: "Post-Apocalyptic Earth" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["name"]).to eq("Post-Apocalyptic Earth")
    end

    it "by type", vcr: { cassette_name: "lib/location/filter/type" } do
      @params = { type: "Planet" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["type"]).to eq("Planet")
    end

    it "by dimension", vcr: { cassette_name: "lib/location/filter/dimension" } do
      @params = { dimension: "Post-Apocalyptic Dimension" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["dimension"]).to eq("Post-Apocalyptic Dimension")
    end

    it "all parameters", vcr: { cassette_name: "lib/location/filter/all_parameters" } do
      @params = { name: "Citadel of Ricks", type: "Space station", dimension: "unknown" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["name"]).to eq("Citadel of Ricks")
      expect(result[:body]["results"][0]["type"]).to eq("Space station")
      expect(result[:body]["results"][0]["dimension"]).to eq("unknown")
    end
  end
end
