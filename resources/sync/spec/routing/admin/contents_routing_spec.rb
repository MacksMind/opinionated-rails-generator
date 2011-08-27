require "spec_helper"

describe Admin::ContentsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/contents").should route_to("admin/contents#index")
    end

    it "routes to #new" do
      get("/admin/contents/new").should route_to("admin/contents#new")
    end

    it "routes to #show" do
      get("/admin/contents/1").should route_to("admin/contents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/contents/1/edit").should route_to("admin/contents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/contents").should route_to("admin/contents#create")
    end

    it "routes to #update" do
      put("/admin/contents/1").should route_to("admin/contents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/contents/1").should route_to("admin/contents#destroy", :id => "1")
    end

  end
end
