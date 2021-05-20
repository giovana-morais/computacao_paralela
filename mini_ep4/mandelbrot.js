// Digite aqui seu código JS para gerar uma imagem

// As janelas tem um tamanho fixo de 3000x3000
const WIDTH = 3000;
const HEIGHT = 3000;

// Constantes do limite o plano cartesiano
const Xi = -2.0;
const Xj = +1.0;
const Yi = -1.5;
const Yj = +1.5;

const Xd = Xj - Xi;
const Yd = Yj - Yi;

const main = (data) => {
    //Data é um array de bytes que representa a imagem
    //O valor mínimo é 0 e o máximo é 255
    //A cada 4 bytes temos um pixel
    //Red Green Blue Alpha

    //Vamos usar o for para percorrer cada pixel
    for(let i = 0; i < data.length; i += 4) {
        const _x = Math.floor((i/4) % 3000);
        const _y = Math.floor((i/4) / 3000);

        //converte para um plano cartesiano indo de Xi-Xj e Yi-Yj.
        const x = Xi + (_x/WIDTH) * Xd;
        const y = Yj - (_y/HEIGHT) * Yd;

        //****************************

        let zx = 0; let zy = 0; let steps = 0;

        let red = 0;
        let green = 0;
        let blue = 0;
        let porcentagem = 0;

        while (steps < 255) {
            let zx_novo = zx*zx - zy*zy + x;
            let zy_novo = 2*zx*zy + y;
            zx = zx_novo;
            zy = zy_novo;

            if (zx*zx + zy*zy > 4) {
                break;
            }
            steps += 1;
        } 
        if (steps >= 0 && steps < 10) {
            porcentagem = steps/10;
            red = interpola(0, 32, porcentagem);
            green = interpola(7, 107, porcentagem);
            blue = interpola(100, 203, porcentagem);
        } else if (steps >= 10 && steps < 80) {
            porcentagem = steps/80
            red = interpola(32, 237, porcentagem);
            green = interpola(107, 255, porcentagem);
            blue = interpola(203, 255, porcentagem);
        } else if (steps >= 80 && steps < 150) {
            porcentagem = steps/150
            red = interpola(237, 255, porcentagem);
            green = interpola(255, 170, porcentagem);
            blue = interpola(0, 0, porcentagem);
        } else if (steps >= 200 && steps < 255) {
            porcentagem = steps/255
            red = interpola(255, 100, porcentagem);
            green = interpola(170, 120, porcentagem);
            blue = interpola(0, 0, porcentagem);
        }             

        //compute a cor do pixel aqui
        data[i] = red;
        data[i+1] = green;
        data[i+2] = blue;
        data[i+3] = steps;

    }
};

function interpola(canal_a, canal_b, porcentagem) {
    return Math.sqrt(canal_a*canal_a*(1-porcentagem) + canal_b*canal_b*porcentagem);
}


// O nome da função a ser executada retornada deve aparecer no final
// clique em Run JS e aguarde um pouco para o seu código executar
main
