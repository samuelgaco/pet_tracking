# spec/controllers/pets_controller_spec.rb
require 'rails_helper'

RSpec.describe PetsController, type: :request do
  POST_TIMES = 3

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          pet_type: 'dog',
          tracker_type: 'small',
          owner_id: 1,
          in_zone: false
        }
      end

      it 'creates a new pet' do
        POST_TIMES.times do
          post pets_path, params: valid_params
        end

        expect(JSON.parse(response.body)["pets"].count).to eq(POST_TIMES)
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          pet_type: 'dog',
          tracker_type: 'invalid',
          owner_id: 1,
          in_zone: false
        }
      end

      it 'returns error for invalid tracker type' do
        post pets_path, params: invalid_params
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET #outside_zone' do
    it 'returns pets outside zone grouped by type' do
      get outside_zone_pets_path
      expect(response).to have_http_status(200)

      json_response = JSON.parse(response.body)

      expect(json_response['dogs']['small']).to eq(POST_TIMES)
    end
  end


  describe 'POST #create a pet with a lost tracker' do
  context 'with valid parameters' do
    let(:valid_params) do
      {
        pet_type: 'cat',
        tracker_type: 'small',
        owner_id: 1,
        in_zone: false,
        lost_tracker: true
      }
    end

    it 'creates a new cat with a lost tracker' do
      post pets_path, params: valid_params

      expect(JSON.parse(response.body)["pets"].count).to eq(POST_TIMES + 1)
      expect(response).to have_http_status(201)
    end
  end

  context 'with invalid parameters' do
    let(:invalid_params) do
      {
        pet_type: 'dog',
        tracker_type: 'small',
        owner_id: 1,
        in_zone: false,
        lost_tracker: true
      }
    end

    it 'returns error' do
      post pets_path, params: invalid_params

      expect(JSON.parse(response.body)["pets"].all? { |pet| pet["pet_type"] == "dog" ? pet["lost_tracker"].nil? : true }).to be true

      expect(JSON.parse(response.body)["pets"].count).to eq(POST_TIMES + 2)
    end
  end
end
end
