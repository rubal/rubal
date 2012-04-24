require 'test_helper'
require 'rubal_core/page_processor'

include RubalCore

class PageProcessorTest < ActiveSupport::TestCase

  test "replace" do
    parser = PageProcessor.instance

    result = parser.replace '[[category:param]]', {'category'=>{'param'=>'value'}}
    assert 'value'==result, "Replace error"
  end

  test "replace unknown placeholder" do
    parser = PageProcessor.instance

    result = parser.replace '[[category:param]]', {}
    assert ''==result, "Replacing unknown placeholder"

    result = parser.replace '[[page:param]]',  {'category'=>{'parampapam'=>'value'}}
    assert ''==result, "Replacing unknown placeholder (unknown category)"

    result = parser.replace '[[category:param]]',  {'category'=>{'parampapam'=>'value'}}
    assert ''==result, "Replacing unknown placeholder (unknown param)"
  end

  test "replace page with syntax error" do
    parser = PageProcessor.instance

    result = parser.replace '[category:param]',  {'category'=>{'param'=>'value'}}
    assert '[category:param]'==result, "Replacing page with syntax error"
  end

  test "type error" do
    parser = PageProcessor.instance

    assert_raise( TypeError, "First param must be String instance" ) {
      parser.replace ['Not a sting'],{}
    }

    assert_raise( TypeError, "First param must be String instance" ) {
      parser.replace nil, {}
    }

    assert_raise( TypeError, "Second param must be Hash instance" ) {
      parser.replace '[[category:param]]', 'Not a hash'
    }

    assert_raise( TypeError, "Second param must be Hash instance" ) {
      parser.replace '[[category:param]]', nil
    }

    assert_raise( TypeError, "First param must be String instance" ) {
      parser.replace ['Not a sting'],{}
    }

    assert_raise( TypeError, "TypeError" ) {
      parser.replace nil, nil
    }
  end

  test "process text" do
    parser = PageProcessor.instance
    PAGE =
<<page
  <html>
    <head>
      <title> [[page:title]] </title>
    </head>
    <body>
      <div id="header">
        <h1> [[page:title]] </h1>
        <ul id="menu">
          <li> [[param:menu1]] </li>
          <li> [[param:menu2]] </li>
          <li> [[param:menu3]] </li>
        </ul>
      </div>
      <div id="main"> [[page:content]] </div>
    </body>
  </html>
page
    RESULT_REQUIRED =
<<result
  <html>
    <head>
      <title> Hello, man! </title>
    </head>
    <body>
      <div id="header">
        <h1> Hello, man! </h1>
        <ul id="menu">
          <li> Menu1 </li>
          <li>  </li>
          <li> Menu3 </li>
        </ul>
      </div>
      <div id="main"> Welcome to hell </div>
    </body>
  </html>
result
    VALUES_HASH = {
        'page' => {
            'title' =>   'Hello, man!',
            'content' => 'Welcome to hell'
        },
        'param' => {
            'menu1' => 'Menu1',
            'menu3' => 'Menu3'
        }
    }

    result = parser.replace PAGE, VALUES_HASH
    assert RESULT_REQUIRED==result, "RESULT_REQUIRED!=result: '#{RESULT_REQUIRED}'!='#{result}'"
  end

end