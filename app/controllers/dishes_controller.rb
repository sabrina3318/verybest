class DishesController < ApplicationController
  def index
    @q = Dish.ransack(params[:q])
    @dishes = @q.result(:distinct => true).includes(:cuisine).page(params[:page]).per(10)

    render("dish_templates/index.html.erb")
  end

  def show
    @dish = Dish.find(params.fetch("id_to_display"))

    render("dish_templates/show.html.erb")
  end

  def new_form
    @dish = Dish.new

    render("dish_templates/new_form.html.erb")
  end

  def create_row
    @dish = Dish.new

    @dish.cuisine_id = params.fetch("cuisine_id")
    @dish.name = params.fetch("name")

    if @dish.valid?
      @dish.save

      redirect_back(:fallback_location => "/dishes", :notice => "Dish created successfully.")
    else
      render("dish_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_cuisine
    @dish = Dish.new

    @dish.cuisine_id = params.fetch("cuisine_id")
    @dish.name = params.fetch("name")

    if @dish.valid?
      @dish.save

      redirect_to("/cuisines/#{@dish.cuisine_id}", notice: "Dish created successfully.")
    else
      render("dish_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @dish = Dish.find(params.fetch("prefill_with_id"))

    render("dish_templates/edit_form.html.erb")
  end

  def update_row
    @dish = Dish.find(params.fetch("id_to_modify"))

    @dish.cuisine_id = params.fetch("cuisine_id")
    @dish.name = params.fetch("name")

    if @dish.valid?
      @dish.save

      redirect_to("/dishes/#{@dish.id}", :notice => "Dish updated successfully.")
    else
      render("dish_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_cuisine
    @dish = Dish.find(params.fetch("id_to_remove"))

    @dish.destroy

    redirect_to("/cuisines/#{@dish.cuisine_id}", notice: "Dish deleted successfully.")
  end

  def destroy_row
    @dish = Dish.find(params.fetch("id_to_remove"))

    @dish.destroy

    redirect_to("/dishes", :notice => "Dish deleted successfully.")
  end
end
