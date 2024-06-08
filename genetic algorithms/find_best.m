function [new_population, best_fit] = find_best(population, objectiveValues, child_pop, p_size,child_objectiveValues, elit_value, old_elit_value)
% population: mevcut popülasyon (hücre dizisi)
% objectiveValues: mevcut popülasyonun uygunluk değerleri (double dizisi)
% child_pop: yeni oluşturulan çocuk popülasyonu (hücre dizisi)
% child_objectiveValues: çocuk popülasyonunun uygunluk değerleri (double dizisi)
% top_n: en iyi birey sayısı

% Popülasyonları ve uygunluk değerlerini birleştir
combined_pop = [population; child_pop];
combined_objectiveValues = [objectiveValues; child_objectiveValues];

% Uygunluk değerlerine göre sıralama yap
[~, sorted_indices] = sort(combined_objectiveValues, 'ascend'); % Küçükten büyüğe sıralama

% En iyi `top_n` bireyi seç
best_indices = sorted_indices(1:p_size);
new_population = combined_pop(best_indices);
best_fit = combined_objectiveValues(best_indices);
% Elit birey sayısı
elit_count = floor(p_size * 0.1);
new_elit_indices = elit_value(1:elit_count, 2);
new_elit_fitness = elit_value(1:elit_count, 1);
% Elit bireylerin indekslerini ve uygunluk değerlerini al
if exist('old_elit_value', 'var')
    old_elit_indices = old_elit_value(1:elit_count, 2);
    old_elit_fitness = old_elit_value(1:elit_count, 1);


    % Eğer eski elit birey daha iyi ise, onu yeni elit birey olarak al
    for k = 1:elit_count
        if old_elit_fitness(k) < new_elit_fitness(k)
            new_population{p_size - elit_count + k} = population{old_elit_indices(k)};
            best_fit(p_size - elit_count + k) = old_elit_fitness(k);
        else
            new_population{p_size - elit_count + k} = population{new_elit_indices(k)};
            best_fit(p_size - elit_count + k) = new_elit_fitness(k);
        end
    end
end



end


