require_relative 'assessment_json_serializer'
require_relative 'assessment_xml_serializer'

class AssessmentSerializer

  def self::serialize_grades(grades, format)
    case format
      when 'xml'
        result = AssessmentXmlSerializer::serialize_grades(grades)
      else
        result = AssessmentJsonSerializer::serialize_grades(grades)
    end

    return result
  end

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