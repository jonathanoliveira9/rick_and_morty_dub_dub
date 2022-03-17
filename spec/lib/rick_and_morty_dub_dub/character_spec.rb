RSpec.describe RickAndMortyDubDub::Character do
  describe "all characters", vcr: { cassette_name: "lib/characters/all_characters" } do
    let(:instance) { described_class.new }
    let(:result) { instance.all }

    it { expect(result[:body]).to be_a_kind_of(Hash) }
    it { expect(result[:status]).to eq(200) }
  end

  describe "finder characters" do
    before { @params = nil }
    let(:instance) { described_class.new(id: @params) }
    let(:result) { instance.finder }
    it "single character" do
      @params = 1
      VCR.use_cassette("lib/characters/single_character") do
        expect(result[:body]).to be_a_kind_of(Hash)
        expect(result[:body]["id"]).to eq(1)
      end
    end

    it "multiple characters" do
      @params = [1, 2]
      VCR.use_cassette("lib/characters/multiple_characters") do
        expect(result[:body]).to be_a_kind_of(Array)
        expect(result[:body].size).to eq(2)
      end
    end
  end
end
