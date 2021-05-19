module Commons
  include Azu::Markup

  def unmount
  end

  def on_event(name, data)
  end

  def card_counter(name : String, title : String, unit : String, color : String, count : String, series : String)
    div class: "card" do
      div class: "card-header pd-t-20 pd-b-0 bd-b-0 d-flex justify-content-between" do
        h6 title, class: "lh-5 mg-b-0"
      end
      div class: "card-body pd-0 pos-relative ht-120" do
        div class: "pos-absolute t-10 l-20 z-index-10  m-b-30" do
          div class: "d-flex d-lg-block d-xl-flex align-items-end" do
            h3 "#{count} #{unit}", class: "tx-normal tx-rubik mg-b-0 mg-r-5 lh-1 text-#{color}"
            para class: "tx-11 tx-color-03 mg-b-0" do
              text " last 5 seconds "
            end
          end
        end
        div style: "position: absolute; bottom: 0" do
          span id: "#{name}-sparkline", values: "#{series}"
        end
      end
    end
  end
end
