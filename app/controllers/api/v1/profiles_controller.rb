class Api::V1::ProfilesController < ApplicationController
  doorkeeper_for :me

  def me
    render nothing: true
  end
end