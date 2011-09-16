require 'freeling/version'
require 'libmorfo_ruby'

module FreeLing
  class TreeNode
    def initialize
      @obj = Libmorfo_ruby::TreeNode.new
    end
  end
end
