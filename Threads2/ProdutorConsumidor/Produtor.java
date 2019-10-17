import java.util.Random;

public class Produtor implements Runnable {
    private Drop drop;

    public Produtor(Drop drop) {
        this.drop = drop;
    }

    public void run() {
        String importantInfo[] = { "Mensagem 1", "Mensagem 2", "Mensagem 3", "Mensagem 4" };
        /*
         * String importantInfo[] = new String[100000]; for(int j = 0; j < 100000; j++)
         * { importantInfo[j] = new Integer(j).toString(); }
         */

        Random random = new Random();

        for (int i = 0; i < importantInfo.length; i++) {
            drop.put(importantInfo[i]);
            try {
                Thread.sleep(random.nextInt(500));
            } catch (InterruptedException e) {
            }
        }
        drop.put("Fim");
    }
}