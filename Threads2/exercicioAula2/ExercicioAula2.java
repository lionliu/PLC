
public class ExercicioAula2 {
    public static void main(String args[]) {
        Thread t = new HelloThread();
        t.start();
        try {
            t.join();
        } catch (InterruptedException e) {

        }
        System.out.println("Opa do Main");
    }
}

class HelloThread extends Thread {

    public void run() {
        System.out.println("Opa meu chapa");
    }
}