require 'csv'

class Converter
	def convert(operation)
		chars = operation.split(//)
		result = ''
		tmp = ''
		stack = []
		chars.each do |token|
			if token == '+' or token == '*' or token == '/' or token == '-'
				if stack.empty?
					stack.push(token)
				else
					# Si es mas importante el token etonces lo añade a la pila
					if important(token, stack.last)
						stack.push(token)
					# Si los dos tienen la misma importancia, entonces los intercambia en la pila
					elsif important(token, stack.last) == -1
						lastItem = stack.pop
						stack.push(token)
						stack.push(lastItem)
					# Si el token no es mas importante entonces lo saca de la pila y lo añade a la cadena resultado
					else
						result = result + stack.pop
						stack.push(token)
					end
				end
			else
				result = result + token
			end
		end
		stack.reverse.each do |element|
			result = result + element
		end
		return result
	end

	def important(element, element2)
		if ( element == element2 ) or 
			( ( element == '+' or element == '-' ) and ( element2 == '+' or element2 == '-' ) ) or 
			( ( element == '*' or element == '/' ) and ( element2 == '*' or element2 == '/' ) )
			return -1
		elsif ( element == '+' or element == '-' ) and ( element2 == '*' or element2 == '/' )
			return false
		elsif ( element == '*' or element == '/' ) and ( element2 == '+' or element2 == '-' )
			return true
		end
	end

	def readAndConvert( file )
		tmp = true
		file_CSV = CSV.read(file)
		file_CSV.each do |row|
			result = convert(row[0])
			if result != row[1]
				row.push(result)
				row.push("FAIL")
				tmp = false
			else
				row.push(result)
				row.push("OK")
			end
		end
		puts file_CSV.inspect
		CSV.open(file, "r+") do |csv|
			file_CSV.each do |row|
				csv << row
			end
		end
		return tmp
	end
end