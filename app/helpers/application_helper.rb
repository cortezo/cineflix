module ApplicationHelper
  def rating_select_array
    [5,4,3,2,1].map {|number| [pluralize(number, "Star"), number]}
  end

  def my_queue_rating_select(f, review, video)
    if review.new_record?
      f.select :rating, rating_select_array, class: 'form-group btn btn-default dropdown-toggle', include_blank: "Avg: #{video.avg_rating}/5"
    else
      f.select :rating, rating_select_array, class: 'form-group btn btn-default dropdown-toggle', selected: review.rating
    end
  end
end
