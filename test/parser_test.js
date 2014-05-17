describe('Parser', function(){

  it('should exist', function() {
    expect(parser).to.be.ok;
  });

  it('should convert "this.div" into "React.DOM.div" calls', function() {
    var source= '{render:function(){ return this.div(null, this.span(null, "test")) }}',
        result=  '{render:function(){ return React.DOM.div(null, React.DOM.span(null, "test")) }}';
    expect( parser(source) ).to.equal( result );
  });

  it('should convert "_this.div" into "React.DOM.div" calls', function() {
    var source= '{render:function(){ return _this.div(null, this.span(null, "test")) }}',
        result=  '{render:function(){ return React.DOM.div(null, React.DOM.span(null, "test")) }}';
    expect( parser(source) ).to.equal( result );
  });

})
