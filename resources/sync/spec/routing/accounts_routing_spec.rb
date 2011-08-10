require "spec_helper"

describe AccountsController do
  describe "routing" do

    it "routes to #edit" do
      get("/account/edit").should route_to("accounts#edit")
    end

    it "routes to #update" do
      put("/account").should route_to("accounts#update")
    end

  end
end
