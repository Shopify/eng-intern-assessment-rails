# frozen_string_literal: true

class EngInternAssessmentRailsSchema < GraphQL::Schema
  query(Types::QueryType)
  mutation(Types::MutationType)
end
