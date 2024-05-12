module reaction_game (
  input clk,
  input reset,

  input btn1,  // Кнопка игрока 1
  input btn2,  // Кнопка игрока 2

  output reg start_led, // Сигнальная лампочка
  output reg win1_led,  // Лампочка игрока 1
  output reg win2_led   // Лампочка игрока 2
);

    // clk - тактовый сигнал 100 МГц
    parameter CLOCK_FREQ = 1;
    parameter AUTO_RESTART = 5 * CLOCK_FREQ;

    reg [31:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin

            // Сброс всех сигналов
            start_led <= 0;
            win1_led <= 0;
            win2_led <= 0;
            counter <= 0; 

        end else begin

            // Логика игры
            if (counter == 0) begin

                // Начало нового раунда
                start_led <= 1;
                counter <= counter + 1;

            end else if (counter < AUTO_RESTART) begin

                // Проверка, кто нажал кнопку первым
                if (!win1_led && !win2_led) begin

                    if (btn1) begin
                        win1_led <= 1;
                        start_led <= 0;
                    end

                    else if (btn2) begin
                        win2_led <= 1;
                        start_led <= 0;
                    end
                end

                counter <= counter + 1;

            end else begin

                // Сброс результатов и запуск нового раунда
                win1_led <= 0;
                win2_led <= 0;
                counter <= 0; 

            end
        end
    end
endmodule