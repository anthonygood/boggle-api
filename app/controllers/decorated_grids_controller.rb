class DecoratedGridsController < ApplicationController

  # GET /grid
  def index
    random = DecoratedGrid.collection.aggregate([:$sample => { size: 1 }]).first
    random = DecoratedGrid.find random["_id"]

    render json: random, serializer: DecoratedGridSerializer
  end

  # GET /grid/:id
  def show
    grid = DecoratedGrid.find(params[:id])

    render json: grid, serializer: DecoratedGridSerializer
  end
end
