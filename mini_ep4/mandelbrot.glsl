// Digite aqui seu código GLSL para gerar uma imagem
// O GLSL é muito próximo do C, mas não é idêntico.

// Essa linha vai definir a precisão do float,
// e mediump é bom o bastante no momento.
precision mediump float;

// Aqui não tem conversão automática entre int e float
// Então coloque .0 quando precisar de floats

// As janelas tem um tamanho fixo de 3000x3000
#define WIDTH (3000.0)
#define HEIGHT (3000.0)

// Constantes do limite do plano cartesiano
#define Xi (-2.0)
#define Xj (+1.0)
#define Yi (-1.5)
#define Yj (+1.5)

#define Xd (Xj - Xi)
#define Yd (Yj - Yi)

float interpola(float canal_a, float canal_b, float porcentagem);

// diferente do código em JS
// a GPU roda essa função main para cada pixel
void main() {
    // Aqui o pixel é guardado num vetor de 4 floats
    // Também segue o formato RGBA, mas dessa vez
    // os campos variam de 0.0 a 1.0

    // vamos obter as coordenadas do plano a partir da
    // variável gl_FragCoord que é pré definida para cada pixel
    vec2 xy = (gl_FragCoord.xy / vec2(WIDTH, HEIGHT) * vec2(Xd, Yd)) + vec2(Xi, Yi);

    // Para acessa o x ou o y individualmente é só usar
    // xy.x e xy.y respectivamente
    float x = xy.x;
    float y = xy.y;

    //****************************

    float zx = 0.0;
    float zy = 0.0;
    int steps = 255;
    float zx_novo = 0.0;
    float zy_novo = 0.0;
    float color = 0.0;
    float porcentagem = 0.0;
    float red = 0.0;
    float blue = 0.0;
    float green = 0.0;

    for (int i = 0; i < 255; i++) {
         zx_novo = zx*zx - zy*zy + x;
         zy_novo = 2.0*zx*zy + y;
         zx = zx_novo;
         zy = zy_novo;

         if (zx*zx + zy*zx > 4.0) {
            steps = i;
            break;
         }
    }

    if (steps >= 0 && steps < 10) {
        porcentagem = float(steps)/10.0;
        red = interpola(0.0, 32.0, porcentagem);
        green = interpola(7.0, 107.0, porcentagem);
        blue = interpola(100.0, 203.0, porcentagem);
    } else if (steps >= 10 && steps < 80) {
        porcentagem = float(steps)/80.0;
        red = interpola(32.0, 237.0, porcentagem);
        green = interpola(107.0, 255.0, porcentagem);
        blue = interpola(203.0, 255.0, porcentagem);
    } else if (steps >= 80 && steps < 150) {
        porcentagem = float(steps)/150.0;
        red = interpola(237.0, 255.0, porcentagem);
        green = interpola(255.0, 170.0, porcentagem);
        blue = interpola(0.0, 0.0, porcentagem);
    } else if (steps >= 200 && steps < 255) {
        porcentagem = float(steps)/255.0;
        red = interpola(255.0, 100.0, porcentagem);
        green = interpola(170.0, 120.0, porcentagem);
        blue = interpola(0.0, 0.0, porcentagem);
    }             


    //*****************************
    // Aplica a cor
    gl_FragColor = vec4(red, gree, blue, steps);
}

float interpola(float canal_a, float canal_b, float porcentagem) { 
    return sqrt(canal_a*canal_a*(1.0-porcentagem) + canal_b*canal_b*porcentagem)/255.0;
}

// Clique em Run GLSL para rodar o código ;)
