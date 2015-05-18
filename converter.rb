require 'csv'

class Converter
	def convert(operation)
		chars = operation.split(//)
		result = ''
		tmp = ''
		stack = []
		chars.each do |token|
			if token == '+' or token == '*' or token == '?' or token == '.' or token == '|'
				if stack.empty?
					stack.push(token)
				else
					# Si es mas importante el token etonces lo añade a la pila
					if important2(token, stack.last)
						stack.push(token)
					# Si los dos tienen la misma importancia, entonces los intercambia en la pila
					elsif important2(token, stack.last) == -1
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

	def important2(element, element2)
		if ( element == element2 ) or 
			( ( element == '*' or element == '+' or element == '?') and 
			( element2 == '*' or element2 == '+' or element2 == '?' ) )
			return -1
		elsif ( element == '.' or element == '|' ) and 
			( element2 == '*' or element2 == '+' or element2 == '?' ) or
			( element == '|' and element2 == '.' )
			return false
		elsif ( ( element == '*' or element == '+' or element == '?' ) and 
			( element2 == '.' or element2 == '|' ) ) or 
			(element == '.' and element2 == '|')
			return true

		end
	end

	def readAndConvert( file )
		if File.exist?(file)
			file_CSV = CSV.read(file)
			file_CSV.each do |row|
				if !row[3].kind_of? String 
					result = convert(row[0])
					if result != row[1]
						row.push(result)
						row.push("FAIL")
					else
						row.push(result)
						row.push("OK")
					end
				else
					return -1
				end
			end
			CSV.open(file, "r+") do |csv|
				file_CSV.each do |row|
					csv << row
				end
			end
			return true
		else
			return false
		end
	end

	def normalize(operation)
		operation = operation.gsub(/([a-zA-Z]\+)|([a-zA-Z]\*)|([a-zA-Z]\?)/,'\&.')
		return operation
	end

	def binary(operator)
		case operator
			when '.'
				return true
			when '|'
				return true
			when '*'
				return false
			when '?'
				return false
			when '+'
				return false
			else 
				return -1
		end						
	end
	def treelizer(operation)
		chars = operation.split(//)
		stack = []
		result = ''
		isNotBinary = false

		chars.each do |token|
			case token
				when '.'
					if !isNotBinary
						lastItem = stack.pop
						stack.push(token)
						stack.push(lastItem)
					else
						lastItem = stack.pop
						lastLastItem = stack.pop
						stack.push(token)
						stack.push(lastLastItem)
						stack.push(lastItem)
						isNotBinary = false
					end
				when '|'
					stack.unshift(token)
					#if !isNotBinary
					#	lastItem = stack.pop
					#	stack.push(token)
					#	stack.push(lastItem)
					#else
						#lastItem = stack.pop
						#lastLastItem = stack.pop
						#stack.push(token)
						#stack.push(lastLastItem)
						#stack.push(lastItem)
					isNotBinary = false
					#end
				when '*'
					lastItem = stack.pop
					stack.push(token)
					stack.push(lastItem)
					isNotBinary = true
				when '?'
					lastItem = stack.pop
					stack.push(token)
					stack.push(lastItem)
					isNotBinary = true
				when '+'
					lastItem = stack.pop
					stack.push(token)
					stack.push(lastItem)
					isNotBinary = true
				else 
					stack.push(token)
			end	
		end
		stack.each do |element|
			result = result + element
		end
		return result
	end
end