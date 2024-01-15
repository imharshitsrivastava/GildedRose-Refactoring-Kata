class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
        # set items quality
        set_item_quality(item)
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            item.quality = item.quality + 1 if item.sell_in < 11 # sell in value less than 11 and quality increases by 2 when there are 10 days or less
            if item.sell_in < 6 # sell in value less than 6 and quality increases by 3 when there are 5 days or less
              item.quality = item.quality + 1 if item.sell_in < 6
            end
          end
        end
      end
      item.sell_in = item.sell_in - 1 if item.name != "Sulfuras, Hand of Ragnaros"
      # set item quality when sell in is less than zero
      set_item_quality_after_sale(item)
    end
  end
end

private

def set_item_quality(item)
  if item.quality > 0
    if item.name != "Sulfuras, Hand of Ragnaros"
      if item.name != "Conjured Mana Cake"
        item.quality = item.quality - 1
      else
        item.quality = item.quality - 2 # conjured items decreses quality by 2
      end
    end
  end
end

def set_item_quality_after_sale(item)
  if item.sell_in < 0
    if item.name != "Aged Brie"
      if item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
            # add functionality for conjured items
            if item.name == "Conjured Mana Cake"
              item.quality = item.quality - 1
            end
          end
        end
      else
        item.quality = item.quality - item.quality
      end
    else
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
