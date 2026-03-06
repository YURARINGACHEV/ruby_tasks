# Требуется написать следующие классы:Класс Station (Станция):Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

# Класс Route (Маршрут):Имеет начальную и конечную станцию, а также список промежуточных станций. 
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

 # Класс Train (Поезд):
 # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
 # Может набирать скорость
 # Может возвращать текущую скорость
 # Может тормозить (сбрасывать скорость до нуля)
 # Может возвращать количество вагонов
 # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). 
 # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
 # Может принимать маршрут следования (объект класса Route). 
 # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
 # Может перемещаться между станциями, указанными в маршруте. 
 # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
 # Возвращать предыдущую станцию, текущую, следующую, на основе маршрутаВ качестве ответа приложите ссылку на репозиторий с решением.

class Train
	attr_accessor :serial_number, :type, :carriages, :current_speed, :route

	def initialize(serial_number, type, carriages = 0)
		@serial_number = serial_number
		@type = type
		@carriages = carriages
		@current_speed = 0
	end

	def set_current_speed(speed)
		@current_speed += speed
	end

	def speed_down(speed)
		@current_speed += speed
	end

	def changing_carriages_count(sign)
		if @current_speed == 0
			puts("Остановите поезд. Скорость #{@current_speed}")
			return
		end
		@carriages -= 1 if sign == "minus"
		@carriages += 1 if sign == "plus"
	end

	def unhook_the_carriage
		if @carriages <=0
			puts "Нет вагонов"
			return
		end

		changing_carriages_count("minus")
	end

	def attach_the_carriage
		changing_carriages_count("plus")
	end

	def add_route(route)
    @routes = route
    @routes.stations.first.add_train(self)
  end

  
  # Может перемещаться между станциями, указанными в маршруте. 
  def move_between_stations(station)
  	destination_station = station
    station_current.send_train(self)
    destination_station.add_train(self)
  end

  def move_station_forward
    return unless station_next
    
    move_between_stations(station_next)
  end

   #Может перемещаться между станциями на одну назад
  def move_station_back
    return unless previous_station

    move_between_stations(previous_station)
  end
 # Перемещение возможно вперед и назад, но только на 1 станцию за раз.
 # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

  def station_current
    @routes.stations.find { |station| station.trains.include?(self) }
  end

  def current_station_index
    @routes.stations.index(station_current)
  end

    #Возвращает следующую станцию
  def station_next
     @routes.stations[current_station_index + 1] if current_station_index < @routes.stations.length
  end

  #Возращает
  def previous_station
    @routes.stations[current_station_index - 1] if current_station_index > 0
  end
end




class Station
	attr_reader :name
	attr_accessor :trains

	def initialize(name)
		@name = name
		@trains = []
	end

	def add_train(train)
		@trains << train unless trains.include?(train)
	end

	def show_trains_by_type(type)
		@trains.select { |train| train.type == type }
	end

	def send_train(train)
    @trains.delete(train)
  end
end

class Route
	attr_accessor :stations

	def initialize(starting_station, terminal_station)
		@stations = [starting_station, terminal_station]
	end

	def add_station(station)
		return if stations.include?(station)
		@stations.insert(1, station)
	end

	def delete_station(station)
		return if @stations.count <= 0 || !@stations.include?(station) 
		@stations.delete(station)
	end

	def show_all_stations
		@stations.each { |station| puts station.name }
	end
end
