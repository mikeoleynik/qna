shared_examples_for 'Unregistered' do
  context "unregistered user" do
    it "try to vote cancel" do
      expect{ send_vote }.to_not change(Vote, :count)
    end
    
    it "send to client from server" do
      send_vote
      expect(response).to have_http_status(401)
    end
  end
end