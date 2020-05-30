package trilateralBasic;

import kitGL.glWeb.Texture;
import kitGL.glWeb.Shaders;
import kitGL.glWeb.HelpGL;
import kitGL.glWeb.AnimateTimer;
import kitGL.glWeb.BufferGL;
import kitGL.glWeb.DivertTrace;

import trilateral3.Trilateral;
import trilateral3.drawing.Pen;
import trilateral3.geom.FlatColorTriangles;
import trilateral3.nodule.PenNodule;

import js.html.webgl.RenderingContext;
import js.html.webgl.Program;

class AppGL{
    public var gl: RenderingContext;
    public var program: Program;
    public var pen: Pen;
    public var penNodule = new PenNodule();
    public var width:  Int;
    public var height: Int;
    public
    function new( width_: Int, height_: Int ){
        width = width_;
        height = height_;
        creategl();
        setup();
    }
    inline
    function creategl( ){
        var mainTexture = new Texture();
        mainTexture.create( width, height, true );
        gl = mainTexture.gl;
    }
    inline
    function setup(){
        program = programSetup( gl, vertexString0, fragmentString0 );
        draw( penNodule.pen );
        interleaveXYZ_RGBA( gl
                          , program
                          , penNodule.data
                          , 'vertexPosition', 'vertexColor' );
        setAnimate();
    }
    public
    function draw( pen: Pen ){
    }
    inline
    function render(){
        clearAll( gl, width, height );
        gl.useProgram( program );
        gl.drawArrays( RenderingContext.TRIANGLES, 0, penNodule.size );
    }
    inline
    function setAnimate(){
        AnimateTimer.create();
        AnimateTimer.onFrame = function( v: Int ) render();
    }
}