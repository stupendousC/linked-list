
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value, next_node = nil)
    @data = value
    @next = next_node
  end
end

# Defines the singly linked list
class LinkedList
    def initialize
      @head = nil # keep the @head private. Not accessible outside this class
    end

    # method to add a new node with the specific data value in the linked list
    # insert the new node at the beginning of the linked list
    ### Space = O(1) and Time = O(1)
    def add_first(value)
      @head = Node.new(value, @head)
    end

    # method to find if the linked list contains a node with specified value
    # returns true if found, false otherwise
    ### Space = O(1) and Time = O(n)
    def search(value)
      return false if !@head

      curr = @head 
      while curr
        if curr.data == value 
          return true 
        else
          curr = curr.next
        end
      end

      return false
    end

    # method to return the max value in the linked list
    # returns the data value and not the node
    ### Space = O(1) and Time = O(n)
    def find_max
      return nil if !@head

      max = @head.data
      curr = @head 
      
      while curr 
        max = curr.data if curr.data > max 
        curr = curr.next
      end

      return max
    end

    # method to return the min value in the linked list
    # returns the data value and not the node
    ### Space = O(1) and Time = O(n)
    def find_min
      return nil if !@head

      min = @head.data
      curr = @head 
      
      while curr 
        min = curr.data if curr.data < min 
        curr = curr.next
      end

      return min
    end


    # method that returns the length of the singly linked list
    ### Space = O(1) and Time = O(n)
    def length
      count = 0
      curr = @head 

      while curr
        count += 1
        curr = curr.next
      end

      return count
    end

    # method that returns the value at a given index in the linked list
    # index count starts at 0
    # returns nil if there are fewer nodes in the linked list than the index value
    ### Space = O(1) and Time = O(n)
    def get_at_index(index)
      curr = @head
      count = 0 

      while count < index && curr
        count += 1
        curr = curr.next 
      end

      if count == index 
        return curr.data 
      else 
        return nil
      end
    end

    # method to print all the values in the linked list
    ### Space = O(n) and Time = O(n)
    def visit
      if !@head 
        return "empty list"
      end
  
      printout = "LL = #{@head.data}"
      curr = @head.next 
  
      while curr 
        printout += " -> #{curr.data}"
        curr = curr.next
      end
  
      return printout
    end

    # method to delete the first node found with specified value
    ### Space = O(1) and Time = O(n)
    def delete(value)
      prev = nil
      curr = @head 

      while curr 
        if curr.data == value 
          if prev == nil
            @head = curr.next 
          else  
            prev.next = curr.next 
          end
          return

        else
          prev = curr
          curr = curr.next
        end
      end

      # if u reached this point, then nothing matches, and no changes made to list
    end

    # method to reverse the singly linked list
    # note: the nodes should be moved and not just the values in the nodes
    ### Space = O(1) and Time = O(n)
    def reverse
      if !@head || !@head.next 
        # if 0 or 1 node, then nothing to reverse
        return
      end
  
      prev = @head
      curr = @head.next 
  
      # first make the @head point to nil since it's the new tail now
      @head.next = nil
  
      # traverse the SLL
      while curr 
  
        if curr.next
          upcoming = curr.next   # needed to define upcoming so it's anchored down
        else
          upcoming = nil
        end
  
        # flip the direction of curr.next arrow
        curr.next = prev 
        
        # redefine the prev/curr focus  
        prev = curr
        if upcoming 
          curr = upcoming 
        else  
          # reached the end of SLL, which is the new @head
          @head = curr
          return
        end
      end
    end

    ## Advanced Exercises
    # returns the value at the middle element in the singly linked list
    ### Space = O(1) and Time = O(n)
    def find_middle_value
      return "empty list" if !@head 
      return @head.data if !@head.next 

      # brute force: count total # nodes, then go back and get the middle
      # better method: set potentialWinner & currScout, move potentialWinner up by 1 and currScout up by 2 until currScout reach nil

      # first possible middle node requirements (must have 3 nodes) met
      if @head.next.next 
        potentialWinner = @head.next 
        currScout = @head.next.next
      else 
        return "only 2 nodes in the list"
      end

      # traverse down SLL until end of tail is met
      while currScout
        if currScout.next 
          if currScout.next.next 
            currScout = currScout.next.next 
            potentialWinner = potentialWinner.next 
          else
            return "not quite the middle, but the middle is between #{potentialWinner.data} and #{potentialWinner.next.data}"
          end
        else 
          # perfect middle
          return potentialWinner.data
        end
      end
    end

    # find the nth node from the end and return its value
    # assume indexing starts at 0 while counting to n
    ### Space = O(1) and Time = O(n)
    def find_nth_from_end(n)

      if !@head
        return nil
      end
  
      potentialWinner = @head 
      currScout = @head
      count = 0
  
      while n > count
        if currScout.next
          currScout = currScout.next
          count += 1
        else
          # puts "not enough nodes for #{n}th node from end"
          return nil
        end
      end
  
      # move potentialWinner and currScout up by 1 down the SLL until currScout lands on last node
      while currScout.next
        currScout = currScout.next 
        potentialWinner = potentialWinner.next 
      end
  
      return potentialWinner.data
    end

    # checks if the linked list has a cycle. A cycle exists if any node in the
    # linked list links to a node already visited.
    # returns true if a cycle is found, false otherwise.
    ### Space = O(1) and Time = O(n)
    def has_cycle
      slow = head
      fast = head 

      # slow is moving 1 at a time, fast is moving 2 at a time
        # if fast ever ends up at nil, return false
        # if fast loops back and eventually ends up at same node as slow, return true
      
      until !fast || !fast.next 
        fast = fast.next.next 
        slow = slow.next

        return true if fast == slow 
      end

      return false
    end

    # Additional Exercises 
    # returns the value in the first node
    # returns nil if the list is empty
    ### Space = O(1) and Time = O(1)
    def get_first
      if @head 
        return @head.data
      else  
        return nil
      end
    end


    # method that inserts a given value as a new last node in the linked list
    ### Space = O(1) and Time = O(n)
    def add_last(value)
      newNode = Node.new(value)
      
      if @head.nil? 
        @head = newNode
        return
      end

      prev = nil
      curr = @head 

      while curr
        if curr.next 
          prev = curr
          curr = curr.next
        else
          curr.next = newNode
          return
        end
      end
      
    end

    # method that returns the value of the last node in the linked list
    # returns nil if the linked list is empty
    ### Space = O(1) and Time = O(n)
    def get_last
      return nil if !@head

      prev = nil
      curr = @head 

      while curr 
        if curr.next 
          prev = curr
          curr = curr.next 
        else  
          return curr.data
        end
      end

    end

    # method to insert a new node with specific data value, assuming the linked
    # list is sorted in ascending order
    ### Space = O(1) and Time = O(n)
    def insert_ascending(data)
      newNode = Node.new(data)

      if !@head 
        @head = newNode
        return
      end

      prev = nil
      curr = @head 

      while curr
        if data <= curr.data 
          # insert in front of curr 
          if prev == nil 
            @head = newNode
          else 
            prev.next = newNode 
          end

          newNode.next = curr
          return
        else 
          # traverse down the list
          prev = curr 
          curr = curr.next
        end
      end

      # if have not inserted the newNode by now, it's the largest value, therefore goes at the end
      # newNode's next is already nil by default
      prev.next = newNode 
    end

    # Helper method for tests
    # Creates a cycle in the linked list for testing purposes
    # Assumes the linked list has at least one node
    ### Space = O(1) and Time = O(n)
    def create_cycle
      return if @head == nil # don't do anything if the linked list is empty

      # navigate to last node
      current = @head
      while current.next != nil
          current = current.next
      end

      current.next = @head # make the last node link to first node
      # now it's 1 giant loop!
    end
end


########################################### DOUBLY LINKED LIST below ###########################################
########################################### Will get to hopefully sometime later, but for now I'm turning in the required parts on SLL

# class DLL_Node
#   attr_reader :data # allow external entities to read value but not write
#   attr_accessor :next, :prev # allow external entities to read or write next node

#   def initialize(value, next_node = nil, prev_node = nil)
#     @data = value
#     @next = next_node
#     @prev = prev_node
#   end
# end

# class DoublyLinkedList < LinkedList
#   def initialize
#     @head = nil # keep the @head private. Not accessible outside this class
#   end

#   def showLL
#     if !@head 
#       return "empty list"
#     end

#     printout = "LL = #{@head.data}"
#     curr = @head.next 

#     while curr 
#       printout += " <-> #{curr.data}"
      
#       # make sure both directions are valid
#       if curr.next 
#         if curr.next.prev != curr 
#           puts "ERROR!!!"
#         end
#       end

#       curr = curr.next
#     end

#     puts printout
#   end

#   ### Space = O(1) and Time = O(1)
#   def add_first(value)
#     @head = Node.new(value, @head)
#     @head.next.prev = @head

#     self.showLL()
#   end

#   ### Space = O(TODO) and Time = O(TODO)
#   def add_last(value)
#   end

#   ### Space = O(TODO) and Time = O(TODO)
#   def get_first
#   end

#   ### Space = O(TODO) and Time = O(TODO)
#   def get_at_index(index)
#   end

#   ### Space = O(TODO) and Time = O(TODO)
#   def reverse
#   end

#   ### Space = O(TODO) and Time = O(TODO)
#   def delete(value)

#     self.showLL()
#     prev = nil
#     curr = @head 

#     while curr 
#       if curr.data == value 
#         if prev == nil
#           @head = curr.next 
#           @head.prev = nil
#         else  
#           prev.next = curr.next 
#           curr.next.prev = prev
#         end
#         return

#       else
#         prev = curr
#         curr = curr.next
#       end
#     end

#     # if u reached this point, then nothing matches, and no changes made to list
#   end
# end