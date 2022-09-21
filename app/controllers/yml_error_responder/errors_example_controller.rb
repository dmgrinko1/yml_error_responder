module YmlErrorResponder
  class ErrorsExampleController < Api::V1::BaseController

    class CvvInvalid < ExampleApiError; end
    class Appointment < ExampleApiError; end

    def cvv
      raise CvvInvalid
    end

    def appointment
      raise Appointment.new(meta: {
        "available_slots": [
          {
            "id": 4,
            "name": "Slot1"
          },
          {
            "id": 5,
            "name": "Slot2"
          }
        ]
      })
    end

    def uncovered
      raise 'UncoveredExeption'
    end
  end
end
