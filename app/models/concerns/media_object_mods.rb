# Copyright 2011-2015, The Trustees of Indiana University and Northwestern
#   University.  Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
#   under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
#   CONDITIONS OF ANY KIND, either express or implied. See the License for the
#   specific language governing permissions and limitations under the License.
# ---  END LICENSE_HEADER BLOCK  ---
module MediaObjectMods
  extend ActiveSupport::Concern

  included do
    has_subresource 'descMetadata', class_name: 'ModsDocument'
    before_save :normalize_desc_metadata!
  end

  # # this method returns a hash: class attribute -> metadata attribute
  # # this is useful for decoupling the metdata from the view
  # def klass_attribute_to_metadata_attribute_map
  #   {
  #   :avalon_uploader => :creator,
  #   :avalon_publisher => :publisher,
  #   :title => :main_title,
  #   :alternative_title => :alternative_title,
  #   :translated_title => :translated_title,
  #   :uniform_title => :uniform_title,
  #   :statement_of_responsibility => :statement_of_responsibility,
  #   :creator => :creator,
  #   :date_created => :date_created,
  #   :date_issued => :date_issued,
  #   :copyright_date => :copyright_date,
  #   :abstract => :abstract,
  #   :note => :note,
  #   :format => :media_type,
  #   :contributor => :contributor,
  #   :publisher => :publisher,
  #   :genre => :genre,
  #   :subject => :topical_subject,
  #   :related_item_url => :related_item_url,
  #   :geographic_subject => :geographic_subject,
  #   :temporal_subject => :temporal_subject,
  #   :topical_subject => :topical_subject,
  #   :bibliographic_id => :bibliographic_id,
  #   :language => :language,
  #   :terms_of_use => :terms_of_use,
  #   :table_of_contents => :table_of_contents,
  #   :physical_description => :physical_description,
  #   :other_identifier => :other_identifier,
  #   :record_identifier => :record_identifier,
  #   }
  # end

  # delegate :alternative_title, :translated_title, :uniform_title, :statement_of_responsibility, :creator,
  #          :date_created, :date_issued, :copyright_date, :abstract, :note, :format, :contributor, :publisher,
  #          :genre, :related_item_url, :geographic_subject, :temporal_subject, :topical_subject, :bibliographic_id,
  #          :language, :terms_of_use, :table_of_contents, :physical_description, :other_identifier, :record_identifier,
  #          to: :descMetadata
  # end

  # has_attributes :title, datastream: :descMetadata, at: [:main_title], multiple: false
  def title
    descMetadata.main_title.first
  end

  def title=(value)
    delete_all_values(:main_title)
    descMetadata.add_main_title(value)
  end

  # has_attributes :alternative_title, datastream: :descMetadata, at: [:alternative_title], multiple: true
  def alternative_title
    descMetadata.alternative_title
  end

  def alternative_title=(value)
    delete_all_values(:alternative_title)
    Array(value).each { |val| descMetadata.add_alternative_title(val) }
  end

  # has_attributes :translated_title, datastream: :descMetadata, at: [:translated_title], multiple: true
  def translated_title
    descMetadata.alternative_title
  end

  def translated_title=(value)
    delete_all_values(:translated_title)
    Array(value).each { |val| descMetadata.add_translated_title(val) }
  end

  # has_attributes :uniform_title, datastream: :descMetadata, at: [:uniform_title], multiple: true
  def uniform_title
    descMetadata.uniform_title
  end

  def uniform_title=(value)
    delete_all_values(:uniform_title)
    Array(value).each { |val| descMetadata.add_uniform_title(val) }
  end

  # has_attributes :statement_of_responsibility, datastream: :descMetadata, at: [:statement_of_responsibility], multiple: false
  def statement_of_responsibility
    descMetadata.statement_of_responsibility.first
  end

  def statement_of_responsibility=(value)
    delete_all_values(:statement_of_responsibility)
    descMetadata.statement_of_responsibility = value
  end

  # has_attributes :creator, datastream: :descMetadata, at: [:creator], multiple: true
  def creator
    descMetadata.creator
  end

  def creator=(value)
    delete_all_values(:creator)
    Array(value).each { |val| descMetadata.add_creator(val) }
  end

  # has_attributes :date_created, datastream: :descMetadata, at: [:date_created], multiple: false
  def date_created
    descMetadata.date_created.first
  end

  def date_created=(value)
    delete_all_values(:date_created)
    descMetadata.add_date_created(value)
  end

  # has_attributes :date_issued, datastream: :descMetadata, at: [:date_issued], multiple: false
  def date_issued
    descMetadata.date_issued.first
  end

  def date_issued=(value)
    delete_all_values(:date_issued)
    descMetadata.add_date_issued(value)
  end

  # has_attributes :copyright_date, datastream: :descMetadata, at: [:copyright_date], multiple: false
  def copyright_date
    descMetadata.copyright_date.first
  end

  def copyright_date=(value)
    delete_all_values(:copyright_date)
    descMetadata.add_copyright_date(value)
  end

  # has_attributes :abstract, datastream: :descMetadata, at: [:abstract], multiple: false
  def abstract
    descMetadata.abstract.first
  end

  def abstract=(value)
    delete_all_values(:abstract)
    descMetadata.abstract = value
  end

  # has_attributes :note, datastream: :descMetadata, at: [:note], multiple: true
  def note
    descMetadata.note.present? ? descMetadata.note.type.zip(descMetadata.note) : nil
  end

  def note=(value)
    delete_all_values(:note)
    descMetadata.note = Array(value)
  end

  # has_attributes :format, datastream: :descMetadata, at: [:media_type], multiple: false
  def format
    descMetadata.media_type.first
  end

  def format=(value)
    delete_all_values(:media_type)
    descMetadata.media_type = value
  end

  # has_attributes :resource_type, datastream: :descMetadata, at: [:resource_type], multiple: true
  def resource_type
    descMetadata.resource_type
  end

  def resource_type=(value)
    delete_all_values(:resource_type)
    descMetadata.resource_type = value
  end

  # Additional descriptive metadata
  # has_attributes :contributor, datastream: :descMetadata, at: [:contributor], multiple: true
  def contributor
    descMetadata.contributor
  end

  def contributor=(value)
    delete_all_values(:contributor)
    Array(value).each { |val| descMetadata.add_contributor(val) }
  end

  # has_attributes :publisher, datastream: :descMetadata, at: [:publisher], multiple: true
  def publisher
    descMetadata.publisher
  end

  def publisher=(value)
    delete_all_values(:publisher)
    Array(value).each { |val| descMetadata.add_publisher(val) }
  end

  # has_attributes :genre, datastream: :descMetadata, at: [:genre], multiple: true
  def genre
    descMetadata.genre
  end

  def genre=(value)
    delete_all_values(:genre)
    descMetadata.genre = value
  end

  # TODO: Review this with jlhardes
  # has_attributes :subject, datastream: :descMetadata, at: [:topical_subject], multiple: true
  def subject
    descMetadata.topical_subject
  end

  def subject=(value)
    delete_all_values(:topical_subject)
    Array(value).each { |val| descMetadata.add_topical_subject(val) }
  end
  # has_attributes :related_item_url, datastream: :descMetadata, at: [:related_item_url], multiple: true
  def related_item_url
    descMetadata.related_item_url.zip(descMetadata.related_item_label).map{|a|{url: a[0],label: a[1]}}
  end

  def related_item_url=(value)
    delete_all_values(:related_item_url)
    Array(value).each { |val| descMetadata.add_related_item_url(val) }
  end

  # has_attributes :geographic_subject, datastream: :descMetadata, at: [:geographic_subject], multiple: true
  # has_attributes :temporal_subject, datastream: :descMetadata, at: [:temporal_subject], multiple: true
  # has_attributes :topical_subject, datastream: :descMetadata, at: [:topical_subject], multiple: true
  # has_attributes :bibliographic_id, datastream: :descMetadata, at: [:bibliographic_id], multiple: false

  # has_attributes :language, datastream: :descMetadata, at: [:language], multiple: true
  def language
    descMetadata.language.code.zip(descMetadata.language.text).map{|a|{code: a[0],text: a[1]}}
  end
  def language=(value)
    delete_all_values(:language)
    Array(value).each { |val| descMetadata.add_language(val) }
  end

  # has_attributes :terms_of_use, datastream: :descMetadata, at: [:terms_of_use], multiple: false
  # has_attributes :table_of_contents, datastream: :descMetadata, at: [:table_of_contents], multiple: true
  # has_attributes :physical_description, datastream: :descMetadata, at: [:physical_description], multiple: true
  # has_attributes :other_identifier, datastream: :descMetadata, at: [:other_identifier], multiple: true
  # has_attributes :record_identifier, datastream: :descMetadata, at: [:record_identifier], multiple: true

  # def find_metadata_attribute(attribute)
  #   metadata_attribute = klass_attribute_to_metadata_attribute_map[ attribute.to_sym ]
  #   if metadata_attribute.nil? and descMetadata.class.terminology.terms.has_key?(attribute.to_sym)
  #     metadata_attribute = attribute.to_sym
  #   end
  #   metadata_attribute
  # end
  #
  # def update_datastream(datastream = :descMetadata, values = {})
  #   missing_attributes.clear
  #   # Special case the identifiers and their types
  #   if values[:bibliographic_id].present? and values[:bibliographic_id_label].present?
  #     values[:bibliographic_id] = {value: values[:bibliographic_id], attributes: values[:bibliographic_id_label]}
  #   end
  #   values.delete(:bibliographic_id_label)
  #   if values[:related_item_url].present? and values[:related_item_label].present?
  #       values[:related_item_url] = values[:related_item_url].zip(values[:related_item_label])
  #   end
  #   values.delete(:related_item_label)
  #   if values[:note].present? and values[:note_type].present?
  #     values[:note]=values[:note].zip(values[:note_type]).map{|v| {value: v[0], attributes: v[1]}}
  #   end
  #   values.delete(:note_type)
  #   if values[:other_identifier].present? and values[:other_identifier_type].present?
  #     values[:other_identifier]=values[:other_identifier].zip(values[:other_identifier_type]).map{|v| {value: v[0], attributes: v[1]}}
  #   end
  #   values.delete(:other_identifier_type)
  #
  #   values.each do |k, v|
  #     # First remove all blank attributes in arrays
  #     v.keep_if { |item| not item.blank? } if v.instance_of?(Array)
  #
  #     # Peek at the first value in the array. If it is a Hash then unpack it into two
  #     # arrays before you pass everything off to the update_attributes method so that
  #     # the markup is composed properly
  #     #
  #     # This does not feel right but is just a first pass. Maybe the use of NOM rather
  #     # than OM will mitigate the need for such tricks
  #     begin
  #       if v.is_a?(Hash)
  #         update_attribute_in_metadata(k, v[:value], v[:attributes])
  #       elsif v.is_a?(Array) and v.first.is_a?(Hash)
  #         vals = []
  #         attrs = []
  #
  #         v.each do |entry|
  #           vals << entry[:value]
  #           attrs << entry[:attributes]
  #         end
  #         update_attribute_in_metadata(k, vals, attrs)
  #       else
  #         update_attribute_in_metadata(k, v)
  #       end
  #     rescue Exception => msg
  #       missing_attributes[k.to_sym] = msg.to_s
  #     end
  #   end
  # end
  #
  # def bibliographic_id
  #   descMetadata.bibliographic_id.present? ? [descMetadata.bibliographic_id.source.first,descMetadata.bibliographic_id.first] : nil
  # end
  # def related_item_url
  #   descMetadata.related_item_url.zip(descMetadata.related_item_label).map{|a|{url: a[0],label: a[1]}}
  # end
  # def language
  #   descMetadata.language.code.zip(descMetadata.language.text).map{|a|{code: a[0],text: a[1]}}
  # end
  # def note
  #   descMetadata.note.present? ? descMetadata.note.type.zip(descMetadata.note) : nil
  # end
  # def other_identifier
  #   descMetadata.other_identifier.present? ? descMetadata.other_identifier.type.zip(descMetadata.other_identifier) : nil
  # end
  #
  #
  # # This method is one way in that it accepts class attributes and
  # # maps them to metadata attributes.
  # def update_attribute_in_metadata(attribute, value = [], attributes = [])
  #   # class attributes should be decoupled from metadata attributes
  #   # class attributes are displayed in the view and posted to the server
  #   metadata_attribute = find_metadata_attribute(attribute)
  #   metadata_attribute_value = value
  #   if metadata_attribute.nil?
  #     missing_attributes[attribute] = "Metadata attribute '#{attribute}' not found"
  #     return false
  #   else
  #     values = if self.class.multiple?(attribute)
  #       Array(value).select { |v| not v.blank? }
  #     elsif Array(value).length==1
  #       Array(value).first
  #     else
  #       value
  #     end
  #     descMetadata.find_by_terms( metadata_attribute ).each &:remove
  #     if descMetadata.template_registry.has_node_type?( metadata_attribute )
  #       Array(values).each_with_index do |val, i|
  #         descMetadata.add_child_node(descMetadata.ng_xml.root, metadata_attribute, val, (Array(attributes)[i]||{}))
  #       end
  #       #end
  #     elsif descMetadata.respond_to?("add_#{metadata_attribute}")
  #       Array(values).each_with_index do |val, i|
  #         descMetadata.send("add_#{metadata_attribute}", val, (Array(attributes)[i] || {}))
  #       end;
  #     else
  #       # Put in a placeholder so that the inserted nodes go into the right part of the
  #       # document. Afterwards take it out again - unless it does not have a template
  #       # in which case this is all that needs to be done
  #       if self.respond_to?("#{metadata_attribute}=")
  #         self.send("#{metadata_attribute}=", values)
  #       else
  #         descMetadata.send("#{metadata_attribute}=", values)
  #       end
  #     end
  #   end
  # end

  private

  # Put the pieces into the right order and validate to make sure that there are no
  # syntactic errors
  def normalize_desc_metadata!
    descMetadata.ensure_identifier_exists!
    descMetadata.update_change_date!
    descMetadata.reorder_elements!
    descMetadata.remove_empty_nodes!
  end

  def delete_all_values(field_name)
    descMetadata.find_by_terms(field_name).each &:remove
  end
end
