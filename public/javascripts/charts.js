// <![CDATA[    
var so = new SWFObject("/charts/ampie/ampie.swf", "population_chart", "800", "380", "8", "#000000");
so.addVariable("path", "/charts/ampie/");
so.addVariable("settings_file", escape("/charts/ampie/column_settings.xml"));
so.addVariable("data_file", escape("<%= @population_data_link %>"));
so.addVariable("additional_chart_settings", "<settings><labels><label><x>250</x><y>25</y><text_size>18</text_size><text><![CDATA[<b>California Population as of <%= Time.now.to_s(:db) %></b>]]></text></label></labels></settings>");
so.addVariable("preloader_color", "#000000");
so.write("population_chart");
// ]]>