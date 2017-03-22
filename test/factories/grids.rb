FactoryGirl.define do
  factory :grid do
    letters "catb" # keep test grid small
    words_count 9
    words [
      {:word=>"cat", :indices=>[[0, 0], [0, 1], [1, 0]]},
      {:word=>"cab", :indices=>[[0, 0], [0, 1], [1, 1]]},
      {:word=>"act", :indices=>[[0, 1], [0, 0], [1, 0]]},
      {:word=>"at",  :indices=>[[0, 1], [1, 0]]},
      {:word=>"ab",  :indices=>[[0, 1], [1, 1]]},
      {:word=>"ta",  :indices=>[[1, 0], [0, 1]]},
      {:word=>"tab", :indices=>[[1, 0], [0, 1], [1, 1]]},
      {:word=>"ba",  :indices=>[[1, 1], [0, 1]]},
      {:word=>"bat", :indices=>[[1, 1], [0, 1], [1, 0]]}
    ]
  end
end
