class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  rolify
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :cars
  has_many :drivers ,class_name: "User", foreign_key: "driver_id"
  has_one :driver_car ,class_name: "Car", foreign_key: "car_id"
  # def driver_car
  # 	Car.find_by_id(self.car_id)
  # end
end
