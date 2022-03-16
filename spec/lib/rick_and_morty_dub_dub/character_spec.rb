RSpec.describe RickAndMortyDubDub::Character do

  describe "all characters", vcr: { cassette_name: "lib/characters/all_characters" } do
    let(:instance) { described_class.new }
    let(:result) { instance.all }

    it { expect(result[:body]).to be_a_kind_of(Hash) }
    it { expect(result[:status]).to eq(200) }
  end

  describe "finder characters" do
    context "single character", vrc: { cassette_name: "lib/characters/single_character" } do
      let(:instance) { described_class.new(id: 1) }
      let(:result) { instance.finder }
      it { expect(result[:body].size).to eq(1) }
    end

    context "multiple characters" do

    end
  end
end
