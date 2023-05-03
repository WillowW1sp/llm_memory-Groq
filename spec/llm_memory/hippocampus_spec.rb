require "spec_helper"
require "llm_memory/hippocampus"

RSpec.describe LlmMemory::Hippocampus do
  it "instantiates a new Broca object" do
    hippocampus = LlmMemory::Hippocampus.new
    expect(hippocampus).to be_a(LlmMemory::Hippocampus)
  end

  describe "make_chunks" do
    it "should returns the same docs if content length is less than chunk_size" do
      hippocampus = LlmMemory::Hippocampus.new
      docs = [{content: "foo bar", metadata: {info: "test"}}]
      docs = hippocampus.make_chunks(docs)
      expect(docs).to eq([{content: "foo bar", metadata: {info: "test"}}])
    end

    it "should returns chunked docs" do
      hippocampus = LlmMemory::Hippocampus.new(chunk_size: 1, chunk_overlap: 0)
      docs = [{content: "foo bar", metadata: {info: "test"}}]
      docs = hippocampus.make_chunks(docs)
      expect(docs).to eq([{content: "foo", metadata: {info: "test"}}, {content: "bar", metadata: {info: "test"}}])
    end
  end

  describe "add_vectors", :vcr do
    it "should returns docs that has vector" do
      hippocampus = LlmMemory::Hippocampus.new(chunk_size: 1, chunk_overlap: 0)
      docs = [{content: "Hello, I'm Shohei. I'm working as a sotware developer", metadata: {info: "test"}}]
      docs = hippocampus.add_vectors(docs)
      doc = docs.first
      expect(doc[:vector].length).to eq(1536)
      expect(doc[:content]).to eq("Hello, I'm Shohei. I'm working as a sotware developer")
      expect(doc[:metadata]).to eq({info: "test"})
    end
  end
end