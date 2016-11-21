class ContentItemsController < ApplicationController

  include Concerns::LtiSupport

  skip_before_filter :verify_authenticity_token

  before_filter :secure_launch, only: [:index]
  before_filter :check_is_content_item, only: [:index]
  before_filter :check_return_url, only: [:show]


  def index

    if params[:accept_media_types] =~ %r{text/html}
      @return_type = 'iframe'
    else
      @return_type = 'lti_launch'
    end
    @items = content_items
    render layout: "client"
  end

  def show
    @item = content_items.find{|item| item[:id] == params[:id].to_i}

    if params[:return_type] == 'iframe'
      content = embed_iframe(@item)
    else
      content = lti_launch(@item)
    end
    content_items = content_item_hash(content)

    @consumer = IMS::LTI::ToolConsumer.new(current_lti_application_instance.lti_key, current_lti_application_instance.lti_secret)
    tc = IMS::LTI::ToolConfig.new(launch_url: params[:return_url])

    @consumer.set_config(tc)
    @consumer.resource_link_id = "fake_id"
    @consumer.lti_message_type = 'ContentItemSelection'
    @consumer.set_non_spec_param('content_items', content_items.to_json)
  end

  def setup
    @xml = config_xml
    @lti_application_instances = LtiApplicationInstance.all
    respond_to do |format|
      format.html
      format.xml { render xml: @xml.strip }
    end
  end

  private

    def config_xml
      launch_url = root_url
      selection_ui_url = content_items_url
      <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <cartridge_basiclti_link xmlns="http://www.imsglobal.org/xsd/imslticc_v1p0" xmlns:blti="http://www.imsglobal.org/xsd/imsbasiclti_v1p0" xmlns:lticm="http://www.imsglobal.org/xsd/imslticm_v1p0" xmlns:lticp="http://www.imsglobal.org/xsd/imslticp_v1p0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.imsglobal.org/xsd/imslticc_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticc_v1p0.xsd http://www.imsglobal.org/xsd/imsbasiclti_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imsbasiclti_v1p0p1.xsd http://www.imsglobal.org/xsd/imslticm_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticm_v1p0.xsd http://www.imsglobal.org/xsd/imslticp_v1p0 http://www.imsglobal.org/xsd/lti/ltiv1p0/imslticp_v1p0.xsd">
          <blti:title>Content Item Example</blti:title>
          <blti:description>Content Item Example</blti:description>
          <blti:launch_url>#{launch_url}</blti:launch_url>
          <blti:extensions platform="canvas.instructure.com">
            <lticm:property name="domain">#{launch_url}</lticm:property>
            <lticm:property name="privacy_level">public</lticm:property>
            <lticm:options name="assignment_selection">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="url">#{selection_ui_url}</lticm:property>
              <lticm:property name="message_type">ContentItemSelectionRequest</lticm:property>
              <lticm:property name="selection_height">700</lticm:property>
              <lticm:property name="selection_width">700</lticm:property>
            </lticm:options>
            <lticm:options name="link_selection">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="url">#{selection_ui_url}</lticm:property>
              <lticm:property name="message_type">ContentItemSelectionRequest</lticm:property>
              <lticm:property name="selection_height">700</lticm:property>
              <lticm:property name="selection_width">700</lticm:property>
            </lticm:options>
            <lticm:options name="editor_button">
              <lticm:property name="canvas_icon_class">icon-lti</lticm:property>
              <lticm:property name="message_type">ContentItemSelectionRequest</lticm:property>
              <lticm:property name="text">Content Item Example</lticm:property>
              <lticm:property name="url">#{selection_ui_url}</lticm:property>
            <lticm:property name="selection_height">700</lticm:property>
              <lticm:property name="selection_width">700</lticm:property>
            </lticm:options>
          </blti:extensions>
        </cartridge_basiclti_link>
      XML
    end

    def check_is_content_item
      unless params[:lti_message_type] == 'ContentItemSelectionRequest'
        raise "LTI configuration error. This route is for Content item selection only."
      end
    end

    def check_return_url
      raise "No return url for content item" unless params[:return_url].present?
    end

    def content_item_hash(items)
      {
        "@context" => "http://purl.imsglobal.org/ctx/lti/v1/ContentItem",
        "@graph" => items
      }
    end

    def lti_launch(item)
      [
        {
          "@type" => "LtiLinkItem",
          "mediaType" => "application/vnd.ims.lti.v1.ltilink",
          "url" => lti_launches_url(item[:id]),
          "title" => item[:name],
        },
        {
          "@type" => "LtiLinkItem",
          "mediaType" => "application/vnd.ims.lti.v1.ltilink",
          "url" => lti_launches_url(item[:id]),
          "title" => item[:name],
          "text" => item[:name],
          "lineItem" => {
            "@type" => "LineItem",
            "label" => item[:name],
            "reportingMethod" => "res:totalScore",
            "maximumScore" => 10,
            "scoreConstraints" => {
              "@type" => "NumericLimits",
              "normalMaximum" => 10,
              "totalMaximum" => 10
            }
          }
        }
      ]
    end

    def embed_iframe(item)
      url = item_url(item[:id])
      iframe = <<-HTML
        <iframe style="width: 100%; height: 500px;" src="#{url}">
        </iframe>
      HTML

      [{
         "@type" => "ContentItem",
         "mediaType" => "text/html",
         "text" => iframe,
         "placementAdvice" => {
            "presentationDocumentTarget" => "embed"
         }
       }]
    end

    def secure_launch
      if !valid_lti_request?(current_lti_application_instance.lti_key, current_lti_application_instance.lti_secret)
        user_not_authorized
      end
    end

end
