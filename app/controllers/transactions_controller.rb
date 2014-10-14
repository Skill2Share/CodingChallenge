class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.where(:hidden_transaction => false).where("sender_id = ? or receiver_id = ? or user_id = ?", @current_user.id, @current_user.id, @current_user.id).select("DISTINCT ON (sender_id, marketpost_id) *")
  end

  def show
    @current_transaction = Transaction.find(params[:id])
    @marketpost = Marketpost.find(@current_transaction.marketpost_id)
    @all_messages_from_marketpost = Transaction.order("created_at DESC").where(:hidden_transaction => false).where(:marketpost_id => @marketpost.id).where(:sender_id => @current_transaction.sender_id).where(:receiver_id => @current_transaction.receiver_id)
    @transaction = @marketpost.transactions.build
    @current_receiver_id = @current_transaction.receiver_id
    @current_sender_id = @current_transaction.sender_id
    @sender = User.find_by_id(@current_sender_id)
    @receiver = User.find_by_id(@current_receiver_id)

    if @current_user.id == @current_transaction.sender_id
      @all_messages_from_marketpost.update_all(:sender_read => true)
    end
    if @current_user.id == @current_transaction.receiver_id
      @all_messages_from_marketpost.update_all(:receiver_read => true)
    end
  end

  def new

    @transaction = Transaction.new

    respond_to do |format|
      format.html
      format.json { render json: @transaction }
    end 
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = @current_user.id
    @marketpost = Marketpost.find(@transaction.marketpost_id)
    if @transaction.sender_id.blank?
      @transaction.sender_id = @current_user.id
    end
    if @transaction.receiver_id.blank?
      @transaction.receiver_id = @marketpost.user_id
    end
    if @transaction.sender_id == @current_user.id
      @transaction.sender_read = true
    end
    if @transaction.receiver_id == @current_user.id
       @transaction.receiver_read = true
    end

    #needs better validation
    if @current_user.id == @transaction.receiver_id or @current_user.id == @transaction.sender_id and @marketpost.id == @transaction.marketpost_id and @marketpost.hidden_marketpost == false
      respond_to do |format|
        if @transaction.save
          @all_messages_from_marketpost = Transaction.where(:hidden_transaction => false).where(:marketpost_id => @marketpost.id).where(:sender_id => @transaction.sender_id).where(:receiver_id => @transaction.receiver_id)
          if @current_user.id == @transaction.sender_id
            @all_messages_from_marketpost.update_all(receiver_read: false)
          end
          if @current_user.id == @transaction.receiver_id
            @all_messages_from_marketpost.update_all(sender_read: false)
          end
          format.html { redirect_to :back, :notice => "Message sent" }
        else
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
          flash[:error] = @transaction.errors.empty? ? "Error" : @transaction.errors.full_messages.to_sentence
          format.html { redirect_to :back }
        end
      end
    else 
      redirect_to marketposts_all_path, :error => "No forgery" and return
    end
  end

  def hide
    @admin = @current_user.admin
    if @admin == true
      @transaction = Transaction.find(params[:id])
      @transaction.update_attributes(:hidden_transaction => true)
      redirect_to transactions_path
    else 
      @transaction = Transaction.find(params[:id])
      @transactions = Transaction.where("sender_id = ? and receiver_id = ? and marketpost_id = ?", @transaction.sender_id, @transaction.receiver_id, @transaction.marketpost_id)
      if @current_user.id == @transaction.user_id
        @transactions.update_all(:hidden_transaction => true)
        redirect_to transactions_path
      end
    end
  end

  private
    def transaction_params
      params.require(:transaction).permit(:user_id, :receiver_id, :description, :marketpost_id, :sender_id)
    end
end
