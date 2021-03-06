require_relative 'assessment_json_serializer'
require_relative 'assessment_xml_serializer'

class AssessmentSerializer

  # Returns an string with the representation of the grades in the desired format
  def self::serialize_grades(grades, format)
    case format
      when 'xml'
        result = AssessmentXmlSerializer::serialize_grades(grades)
      else
        result = AssessmentJsonSerializer::serialize_grades(grades)
    end

    return result
  end

  # Returns an string with the representation of the statistics in the desired format
  def self::serialize_statistics(statistics, format)
    case format
      when 'xml'
        result = AssessmentXmlSerializer::serialize_statistics(statistics)
      else
        result = AssessmentJsonSerializer::serialize_statistics(statistics)
    end

    return result
  end

end