package com.company;

public class Principal implements Runnable{

    public void run() {
        System.out.println("Opa meu chapa");
    }



    public static void main(String[] args) {
        (new Thread(new Principal2())).start();
        (new Thread(new Principal3())).start();
        (new Thread(new Principal4())).start();
    }
}

class Principal2 implements Runnable {
    public void run() {
        while (true) {
            System.out.println("Opa meu bom");
        }

    }
}

class Principal3 implements Runnable {
    public void run() {
        while (true) {
            System.out.println("Opa meu garoto");
        }

    }
}

class Principal4 implements Runnable {
    public void run() {
        while (true) {
            System.out.println("Opa meu amigo");
        }

    }
}