def split(data_split, data_type):
    num_files = 6
    data_path = f"../../../data/wiki/sequences/{data_type}/wiki_{data_split}_{data_type}.txt"
    with open(data_path, "r") as f:
        data = f.readlines()
        lines_per_file = round(len(data) / num_files)
        for i in range(num_files):
            output_path = f"../../../data/wiki/sequences/{data_type}/transformer/{data_split}/{i + 1}_{data_split}_{lines_per_file}_sentences.txt"
            sentences = data[i * lines_per_file:i * lines_per_file + lines_per_file]
            with open(output_path, "w") as file:
                file.writelines(sentences)


split("validation", "pos")
split("test", "pos")

split("validation", "word")
split("test", "word")
