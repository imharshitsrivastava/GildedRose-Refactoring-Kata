require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    context "wrong item" do
      it "does not change the name of product" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items.first.name).to eq "foo"
      end

      it "should raise error for incorrect input" do
        items = [Item.new("foo", "invalid", 0)]
        expect { GildedRose.new(items).update_quality() }.to raise_error(StandardError)
      end
    end

    context "when item name is +5 Dexterity Vest" do 19
      it "decreases the sell in and quality for Normal items by 1)" do
        items = [Item.new("+5 Dexterity Vest", 10, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "+5 Dexterity Vest, 9, 19"
      end
    end

    context "daily product" do
      it "decreases quality and sell in by 1" do
        items = [Item.new("Bread", 5, 5)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Bread, 4, 4"
      end

      it "checks for item quality to never be less than 0" do
        items = [Item.new("Bread", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Bread, 4, 0"
      end

      it "decreases quality by 2 when sell in value reaches 0" do
        items = [Item.new("Bread", 0, 5)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Bread, -1, 3"
      end
    end

    context "when item name is Aged Brie" do
      it "increases quality and decrease in sell in value by 1" do
        items = [Item.new("Aged Brie", 8, 8)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Aged Brie, 7, 9"
      end

      it "increases quality by 2 when sell in value reaches 0" do
        items = [Item.new("Aged Brie", 0, 8)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Aged Brie, -1, 10"
      end

      it "checks for quality to never be more than 50" do
        items = [Item.new("Aged Brie", 8, 50)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Aged Brie, 7, 50"
      end
    end

    context "when item name is Elixir of the Mongoose" do
      it "ensures quality never goes below 0" do
        items = [Item.new("Elixir of the Mongoose", 3, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Elixir of the Mongoose, 2, 0"
      end
    end

    context "when item name is Backstage passes to a TAFKAL80ETC concert" do
      context "sell in value is 0 or less" do
        it "sets quality quals to 0 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
          GildedRose.new(items).update_quality()
          expect(items.first.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, -1, 0"
        end
      end

      context "sell in value is greater than 10" do
        it "increases quality and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)]
          GildedRose.new(items).update_quality()
          expect(items.first.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 14, 11"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)]
          GildedRose.new(items).update_quality()
          expect(items.first.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 14, 50"
        end
      end

      context "sell in value is less than 11 and greater than 5" do
        it "increases quality by 2 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 10)]
          GildedRose.new(items).update_quality()
          expect(items.first.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 8, 12"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
          GildedRose.new(items).update_quality()
          expect(items.first.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 9, 50"
        end
      end

      context "sell in value is less than 6 and greater than 0" do
        it "increases quality by 3 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 10)]
          GildedRose.new(items).update_quality()
          expect(items.first.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 3, 13"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 50)]
          GildedRose.new(items).update_quality()
          expect(items.first.to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 3, 50"
        end
      end
    end

    context "when item name is Sulfuras, Hand of Ragnaros" do
      it "never changes it's sell in value (for legendary items)" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Sulfuras, Hand of Ragnaros, 10, 80"
      end

      it "never changes it's quality (for legendary items)" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items.first.to_s).to eq "Sulfuras, Hand of Ragnaros, 0, 80"
      end
    end
  end

end
