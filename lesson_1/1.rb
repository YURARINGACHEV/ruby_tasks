#Сделать хеш, содержащий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30.
month_days = {
    "Jan": 31, "Feb": 28, "Mar": 31, "Apr": 30,
    "May": 31, "Jun": 30, "Jul": 31, "Aug": 31,
    "Sep": 30, "Oct": 31, "Nov": 30, "Dec": 31
}

month_days.each do |m, v|
	puts m if v == 30
end

month_days.each {|m,v| puts m if v == 30}

# 2. Заполнить массив числами от 10 до 100 с шагом 5

arr = []
arr = (1..100).step(5).map {|n| n}
print arr

# 3. Заполнить массив числами фибоначчи до 100
print "\ntask_3\n"
def fib_sequence(count)
  seq = [0, 1]
  while seq.length < count
    seq << seq[-1] + seq[-2]
  end
  seq.take(count)
end

print fib_sequence(13)

# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
puts "\ntask 4"
vowels = ['а', 'е', 'ё', 'и', 'о', 'у', 'э', 'ю', 'я']
vowels_hash = {}
('а'..'я').to_a.each_with_index {|w, i| vowels_hash[w]=i+1 if vowels.include? w }
print vowels_hash
puts "\ntask 5" 


# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 
# (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
# 	Алгоритм опредления високосного года: https://docs.microsoft.com/ru-ru/office/troubleshoot/excel/determine-a-leap-year
print "Введите день (1-31): "
day = gets.to_i
print "Введите месяц (1-12): "
month = gets.to_i
print "Введите год: "
year = gets.to_i

is_leap = (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)

days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

days_in_months[1] = 29 if is_leap

day_of_year = 0
(0...(month-1)).each {|i| day_of_year += days_in_months[i] }

day_of_year += day
print day_of_year

puts "\ntask 6"
