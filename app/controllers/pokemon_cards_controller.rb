class PokemonCardsController < ApplicationController
  def index
    @pokemon_cards = PokemonCard.all

    if params[:search].present?
      search_query = "%#{params[:search]}%"
      @pokemon_cards = @pokemon_cards.where("pokemon_cards.name LIKE ? OR pokemon_cards.description LIKE ?", search_query, search_query)
    end

    if params[:type].present?
      @pokemon_cards = @pokemon_cards.joins(:types).where(types: { name: params[:type] })
    end

    if params[:filter].present?
      case params[:filter]
      when "new"
        @pokemon_cards = @pokemon_cards.where("created_at >= ?", 3.days.ago)
      when "recently_updated"
        @pokemon_cards = @pokemon_cards.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
      end
    end

    @pokemon_cards = @pokemon_cards.page(params[:page]).per(15)
  end

  def show
    @pokemon_card = PokemonCard.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end
