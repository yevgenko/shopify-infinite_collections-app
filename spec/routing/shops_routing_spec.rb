require "spec_helper"

describe ShopsController do
  describe "routing" do

    it "not routes to #index" do
      get("/shops").should_not be_routable
    end

    it "not routes to #new" do
      get("/shops/new").should_not route_to("shop#new")
    end

    it "not routes to #show" do
      get("/shops/1").should_not route_to("shops#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shops/1/edit").should route_to("shops#edit", :id => "1")
    end

    it "not routes to #create" do
      post("/shops").should_not be_routable
    end

    it "routes to #update" do
      put("/shops/1").should route_to("shops#update", :id => "1")
    end

    it "not routes to #destroy" do
      delete("/shops/1").should_not be_routable
    end

  end
end
