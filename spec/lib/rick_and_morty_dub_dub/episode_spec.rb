RSpec.describe RickAndMortyDubDub::Episode do
  describe "all episodes", vcr: { cassette_name: "lib/episode/all_episodes" } do
    let(:instance) { described_class.new }
    let(:result) { instance.all }

    it { expect(result[:body]).to be_a_kind_of(Hash) }
    it { expect(result[:status]).to eq(200) }
  end

  describe "pagination", vcr: { cassette_name: "lib/episode/pagination" } do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.all }

    it "when 2 page" do
      @params = { page: 2 }
      expect(result[:body]["info"]["prev"]).to eq("https://rickandmortyapi.com/api/episode/?page=1")
      expect(result[:body]["info"]["next"]).to eq("https://rickandmortyapi.com/api/episode/?page=3")
    end
  end

  describe "finder episode" do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.finder }
    it "single character" do
      @params = { id: 1 }
      VCR.use_cassette("lib/episode/single_episode") do
        expect(result[:body]).to be_a_kind_of(Hash)
        expect(result[:body]["id"]).to eq(1)
      end
    end

    it "multiple episodes" do
      @params = { id: [1, 2] }
      VCR.use_cassette("lib/location/multiple_episodes") do
        expect(result[:body]).to be_a_kind_of(Array)
        expect(result[:body].size).to eq(2)
      end
    end
  end

  describe "finder by filter" do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.filter }
    it "by name", vcr: { cassette_name: "lib/episode/filter/name" } do
      @params = { name: "Pilot" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["id"]).to eq(1)
      expect(result[:body]["results"][0]["name"]).to eq("Pilot")
    end

    it "by episode", vcr: { cassette_name: "lib/episode/filter/episode" } do
      @params = { type: "S01E01" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["id"]).to eq(1)
      expect(result[:body]["results"][0]["name"]).to eq("Pilot")
    end
  end
end
