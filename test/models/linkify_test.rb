require 'test_helper'

describe Linkify do
  let(:l) { Linkify }

  it 'replaces links' do
    r= l.links('Hi #Cruel-world') do |tag, name, param|
      "H:#{tag} N:#{name} P:#{param}"
    end
    r.must_equal 'Hi H:#Cruel-world N:Cruel world P:cruel-world'
  end

  it 'extracts link' do
    l.links('Hello #world').must_include '#world'
    l.links('This is a #comma, test').must_include '#comma'
    l.links('Strange #Charácters').must_include '#Charácters'
    l.links('#Begin of line').must_include '#Begin'
    l.links('#SeveralWords').must_include '#SeveralWords'
    l.links('#several-words').must_include '#several-words'
    l.links('#with9number').must_include '#with9number'
    l.links('#with-9-number').must_include '#with-9-number'
    l.links('\n\r#with-break').must_include '#with-break'
  end

  it 'quoted links' do
    l.links('#"Hello world"').must_include '#"Hello world"'
    l.to_param('#"Hello world"').must_equal 'hello-world'
    l.to_name('#"Hello world"').must_equal '"Hello world"'
  end

  it 'extracts several links' do
    links = l.links('#uno, #dos, #tres')
    links.must_include '#uno'
    links.must_include '#dos'
    links.must_include '#tres'
  end

  it 'convert links to parameters' do
    l.to_param('#simple').must_equal 'simple'
    l.to_param('#TwoWords').must_equal 'two-words'
    l.to_param('#two-words').must_equal 'two-words'
    l.to_param('#with9number').must_equal 'with-9-number'
  end

  it 'converts links to names' do
    l.to_name('#simple').must_equal 'simple'
    l.to_name('#Two-words').must_equal 'Two words'
    l.to_name('#TwoWords').must_equal 'Two Words'
    l.to_name('#Diff-casesMixed').must_equal 'Diff cases Mixed'
  end
end
