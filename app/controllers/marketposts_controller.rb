class MarketpostsController < ApplicationController
  
  def all 
    @transactions = Transaction.where(:hidden_transaction => false).where("sender_id = ? or receiver_id = ? or user_id = ?", @current_user.id, @current_user.id, @current_user.id).select("DISTINCT ON (sender_id, marketpost_id) *")
    @transaction_array = []
    @transactions.each do |transaction|
      if (transaction.receiver_id == @current_user.id)
        if  (transaction.receiver_read == false)
          @transaction_array.push(1)
        end
      elsif (transaction.sender_id == @current_user.id)
        if  (transaction.sender_read == false)
          @transaction_array.push(1)
        end
      end
    end

    @marketposts = Marketpost.order("created_at DESC").where(:hidden_marketpost => false)
    @marketpost  = Marketpost.new
    @marketpost.user = @current_user
    render action: "index"
  end

  # GET /marketposts/new
  # GET /marketposts/new.json
  def new
    @marketpost = Marketpost.new

    respond_to do |format|
      format.html
      format.json { render json: @marketpost }
    end
  end

  # POST /marketposts
  # POST /marketposts.json
  def create
    @marketpost = Marketpost.new(params[:marketpost])
    @marketpost.user = @current_user

    respond_to do |format|
      if @marketpost.save
        format.json { render json: @marketpost, status: :created, location: @marketpost }
        format.html { redirect_to  root_path(:registered => "true") }
      else
        flash[:error] = @marketpost.errors.empty? ? "Error" : @marketpost.errors.full_messages.to_sentence
        format.html { redirect_to marketposts_all_path }
      end
    end
  end

  def hide
    @admin = @current_user.admin
    if @admin == true
      @marketpost = Marketpost.find(params[:id])
      @marketpost.update_attributes(:hidden_marketpost => true)
      redirect_to root_url
    else 
      @marketpost = Marketpost.find(params[:id])
      if @current_user.id == @marketpost.user_id
        @marketpost.update_attributes(:hidden_marketpost => true)
        redirect_to :back 
      end
    end
  end
end
