# frozen_string_literal: true

class FrequentlyAskedQuestionPolicy < ApplicationPolicy
  relation_scope(&:all)
end
