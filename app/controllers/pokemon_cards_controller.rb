class PokemonCardsController < ApplicationController
  def index
    @pokemon_cards = PokemonCard.all

    if params[:search].present?
      @pokemon_cards = @pokemon_cards.where("pokemon_cards.name LIKE ?", "%#{params[:search]}%")
    end

    if params[:type].present?
      @pokemon_cards = @pokemon_cards.joins(:types).where(types: { name: params[:type] })
    end

    @pokemon_cards = @pokemon_cards.page(params[:page]).per(15)
  end

  def show
    @pokemon_card = PokemonCard.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end