# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  HighestCharge = 50000
  Currencies = ['usd', 'eur', 'cny', 'inr']

  def get_charge_hash
    prng = Random.new
    charge_hash = {}
    charge_hash[:amount] = prng.rand(HighestCharge)
    charge_hash[:currency] = Currencies.sample
    charge_hash[:paid] = true
    charge_hash[:refunded] = false
    charge_hash[:disputed] = false
    return charge_hash
  end

  def get_failed_charge_hash
    failed_charge_hash = get_charge_hash
    failed_charge_hash[:paid] = false
    return failed_charge_hash
  end

  def get_disputed_charge_hash
    disputed_charge_hash = get_charge_hash
    disputed_charge_hash[:disputed] = true
    return disputed_charge_hash
  end

  customers = Customer.create([
    { first_name: 'Johny', last_name: 'Flow' },
    { first_name: 'Raj', last_name: 'Jamnis' },
    { first_name: 'Andrew', last_name: 'Chung' },
    { first_name: 'Mike', last_name: 'Smith' }])

  charges = []

  # 10 successful charges
  (1..10).each do |i|
    charge = get_charge_hash
    if i < 6
      charge[:customer_id] = 1
    elsif i < 9
      charge[:customer_id] = 2
    elsif i < 10
      charge[:customer_id] = 3
    else
      charge[:customer_id] = 4
    end
    charges << Charge.create(charge) 
  end

  # 5 failed charges
  (1..5).each do |i|
      charge = get_failed_charge_hash
    if i < 4
      charge[:customer_id] = 3
    else
      charge[:customer_id] = 4
    end
    charges << Charge.create(charge)
  end

  # 5 disputed charges
  (1..5).each do |i|
    charge = get_disputed_charge_hash
    if i < 4
      charge[:customer_id] = 1
    else
      charge[:customer_id] = 2
    end
    charges << Charge.create(charge)
  end
