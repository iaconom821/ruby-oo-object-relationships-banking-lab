class Transfer
  # your code here
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    if self.sender.valid? && self.receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if self.valid? && self.sender.balance > self.amount && self.status == "pending"
      self.receiver.deposit(amount)
      self.sender.deposit(-amount)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      self.sender.deposit(amount)
      self.receiver.deposit(-amount)
      self.status = 'reversed'
    else
      nil
    end
  end

end
