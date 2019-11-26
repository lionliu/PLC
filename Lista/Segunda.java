import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.atomic.AtomicBoolean;

// TODO: Fazer consumidores como os jogadores e um produtor de cadeiras. Na primeira rodada, criar N consumidores e produzir N-1 cadeiras, e a cada rodada ir decrementando o N, até que reste 1 jogador. 
// O produtor pode gerar um atomic integer = (qt jogadores-1), sendo que cada jogador(consumidor) subtrai 1 do valor e coloca a flag sentado = 1
public class Segunda {
    public static void main(String[] args) {
        UtilidadePublica up = new UtilidadePublica();
        List<AtomicBoolean> cadeiras = new ArrayList<AtomicBoolean>();
        int qtJogadores;
        Scanner s = new Scanner(System.in);
        qtJogadores = s.nextInt();
        List<Jogador> jogadores = new ArrayList<Jogador>();
        for(int i = 0; i < (qtJogadores - 1); i++) {
            
            cadeiras.add(new AtomicBoolean());
           
        }

         for(int i = 0; i < (qtJogadores - 1); i++){
            jogadores.add(new Jogador("Jogador " + i, cadeiras));
        }

        while(cadeiras.size() > 0) {

            // Inicializa o jogo;
            for(int i = 0; i < jogadores.size(); i++) {
                (new Thread(jogadores.get(i))).start();
            }

            while(!up.isAllCadeirasOcupadas(cadeiras)) {
                // Enquanto todas as cadeiras não estiverem ocupadas o jogo vai rolando
                
            }

            up.reiniciaJogo(cadeiras, jogadores);
        }
        System.out.println(jogadores.get(0) + " ganhou");
    }

}

// Vai ser um consumidor
class Jogador implements Runnable{

    public String name;
    public Boolean sentado;
    public List<AtomicBoolean> cadeiras;
    UtilidadePublica up;

    public Jogador(String n, List<AtomicBoolean> c){
        this.name = n;
        this.cadeiras = c;
    }

    public void run() {
        // Roda o run até que ele sente ou todas as cadeiras estejam ocupadas
        while(!(this.sentado) && !this.up.isAllCadeirasOcupadas(this.cadeiras)) {
            for(int i = 0; i < this.cadeiras.size(); i++) {
                // Se a caderia não estiver ocupada,ocupa ela
                if(!this.cadeiras.get(i).get()) {
                    this.cadeiras.get(i).set(true);
                    this.sentado = true;
                }
            }
        }
    }

    public String toString() {
        return this.name;
    }


}

class UtilidadePublica {
    public boolean isAllCadeirasOcupadas(List<AtomicBoolean> cadeiras) {
        for (int i = 0; i < cadeiras.size(); i++) {
            if (!cadeiras.get(i).get()) {
                return false;
            }
        }
        return true;
    }
    public void reiniciaJogo(List<AtomicBoolean> cadeiras, List<Jogador> jogadores) {
        // remove uma cadeira
        cadeiras.remove(0);
        // Tira os jogadores das cadeiras.
        for(int i = 0; i < cadeiras.size(); i++) {
            cadeiras.get(i).set(false);
        }
        for (int i = 0; i < jogadores.size(); i++) {

            if(!jogadores.get(i).sentado) {
                // Remove o jogador em pé
                System.out.println(jogadores.get(i).name + " foi eliminado");
                jogadores.remove(i);
            }
            // coloca os jogadores de pé de volta
            jogadores.get(i).sentado = false;
        }
    }
}

// class Jogo {

// }