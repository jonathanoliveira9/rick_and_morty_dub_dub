RSpec.describe RickAndMortyDubDub::Character do
  describe "all locations", vcr: { cassette_name: "lib/location/all_locations" } do
    let(:instance) { described_class.new }
    let(:result) { instance.all }
    it { expect(result[:body]).to be_a_kind_of(Hash) }
    it { expect(result[:status]).to eq(200) }
  end
end
