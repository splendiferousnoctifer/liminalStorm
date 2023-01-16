import java.time.Duration;
import java.util.Random;
import java.util.Arrays;
import java.util.List;
import java.util.Collections;

int amountOfStates = 4; //without grass and end

public class TimeSplit {
    public int[] splitInterval() {
        Random rng = new Random();
 
        int numSplits = rng.nextInt(3) + 3; //3-5
        int[] splitDurations = new int[numSplits];
        int duration = rng.nextInt(3 * 60000) + (4 * 60000); // 4-6
        
        println("Seconds: ", duration/1000);

        int sum = 0;
  
        for (int i = 0; i < numSplits; i++) {/*
            int num;
            if (i == numSplits - 1) {
                // Generate the last number so that the sum adds up to k
                num = duration - sum;
            } else {
                num = rng.nextInt(duration - sum) + 1; // Generate a random number between 1 and k - sum (inclusive)
                sum += num;
            }*/
            
            
            splitDurations[i] = int(duration/numSplits + random(numSplits)*100);
        }

        return splitDurations;
    }

    //Numbers from 1 to array length
    public int[] assignNumbersOrder(int[] array) {
        int n = array.length -1; // Number of elements

        // Create an array of integers from 1 to n
        int[] numbers = new int[n];
        for (int i = 0; i < n; i++) {
            numbers[i] = i + 1;
        }


        // Shuffle the array
        return shuffleArray(numbers);
    }
    
    //Numbers n out of 5
    public int[] assignNumbers(int[] array) {
      int n = amountOfStates; // Number of elements
      List<Integer> numbers = new ArrayList<>();
      
      for (int i = 1; i <= n; i++) {
        numbers.add(i);
      }
      
      // Select k numbers at random
      Random random = new Random();
      int amountOfNumbers = array.length - 1;
      int[] selection = new int[amountOfNumbers];
      
      for (int i = 0; i < array.length - 1; i++) {
        int j = random.nextInt(numbers.size());
        selection[i] = numbers.get(j);
        numbers.remove(j);
        n--;
      }
      
      return selection;
      
    }

    
    public int[] shuffleArray(int[] array) {
        Random random = new Random();
        
        for (int i = array.length - 1; i > 0; i--) {
          int j = random.nextInt(i + 1);
          int temp = array[i];
          array[i] = array[j];
          array[j] = temp;
        }
        
        return array;
    }
}
