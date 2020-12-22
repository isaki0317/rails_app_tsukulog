class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
end
