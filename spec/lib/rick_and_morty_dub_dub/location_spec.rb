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
end
