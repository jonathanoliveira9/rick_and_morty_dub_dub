RSpec.describe RickAndMortyDubDub::Character do
  describe "all characters", vcr: { cassette_name: "lib/characters/all_characters" } do
    let(:instance) { described_class.new }
    let(:result) { instance.all }

    it { expect(result[:body]).to be_a_kind_of(Hash) }
    it { expect(result[:status]).to eq(200) }
  end

  describe "finder characters" do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.finder }
    it "single character" do
      @params = { id: 1 }
      VCR.use_cassette("lib/characters/single_character") do
        expect(result[:body]).to be_a_kind_of(Hash)
        expect(result[:body]["id"]).to eq(1)
      end
    end

    it "multiple characters" do
      @params = { id: [1, 2] }
      VCR.use_cassette("lib/characters/multiple_characters") do
        expect(result[:body]).to be_a_kind_of(Array)
        expect(result[:body].size).to eq(2)
      end
    end
  end

  describe "finder by filter" do
    before { @params = nil }
    let(:instance) { described_class.new(@params) }
    let(:result) { instance.filter }
    it "by name", vcr: { cassette_name: "lib/characters/filter/name" } do
      @params = { name: "Rick Sanchez" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["name"]).to eq("Rick Sanchez")
    end

    it "by status", vcr: { cassette_name: "lib/characters/filter/status" } do
      @params = { status: "alive" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["status"]).to eq("Alive")
    end

    it "by species", vcr: { cassette_name: "lib/characters/filter/species" } do
      @params = { species: "humanoid" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["species"]).to eq("Humanoid")
    end

    it "by type", vcr: { cassette_name: "lib/characters/filter/type" } do
      @params = { type: "phone" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["type"]).to eq("Phone-Person")
    end

    it "by gender", vcr: { cassette_name: "lib/characters/filter/gender" } do
      @params = { gender: "male" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["gender"]).to eq("Male")
    end

    it "all parameters", vcr: { cassette_name: "lib/characters/filter/all_parameters" } do
      @params = { name: "Slaveowner", status: "dead", species: "human", type: "", gender: "male" }
      expect(result[:body]).to be_a_kind_of(Hash)
      expect(result[:status]).to eq(200)
      expect(result[:body]["results"][0]["name"]).to eq("Slaveowner")
      expect(result[:body]["results"][0]["status"]).to eq("Dead")
      expect(result[:body]["results"][0]["species"]).to eq("Human")
      expect(result[:body]["results"][0]["type"]).to eq("")
      expect(result[:body]["results"][0]["gender"]).to eq("Male")
    end
  end
end
