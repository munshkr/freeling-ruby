require 'freeling/version'
require 'freeling_ruby'

module FreeLing
  class TreeNode
    def initialize
      @obj = Libmorfo_ruby::TreeNode.new
    end
  end
end
