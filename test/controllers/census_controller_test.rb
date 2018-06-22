require 'test_helper'

class CensusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @censu = census(:one)
  end

  test "should get index" do
    get census_url
    assert_response :success
  end

  test "should get new" do
    get new_censu_url
    assert_response :success
  end

  test "should create censu" do
    assert_difference('Censu.count') do
      post census_url, params: { censu: { birthdate: @censu.birthdate, calle: @censu.calle, casa: @censu.casa, edad: @censu.edad, last_name: @censu.last_name, name: @censu.name, nivel_estudio: @censu.nivel_estudio, piso: @censu.piso, position: @censu.position, profesion: @censu.profesion, sector: @censu.sector } }
    end

    assert_redirected_to censu_url(Censu.last)
  end

  test "should show censu" do
    get censu_url(@censu)
    assert_response :success
  end

  test "should get edit" do
    get edit_censu_url(@censu)
    assert_response :success
  end

  test "should update censu" do
    patch censu_url(@censu), params: { censu: { birthdate: @censu.birthdate, calle: @censu.calle, casa: @censu.casa, edad: @censu.edad, last_name: @censu.last_name, name: @censu.name, nivel_estudio: @censu.nivel_estudio, piso: @censu.piso, position: @censu.position, profesion: @censu.profesion, sector: @censu.sector } }
    assert_redirected_to censu_url(@censu)
  end

  test "should destroy censu" do
    assert_difference('Censu.count', -1) do
      delete censu_url(@censu)
    end

    assert_redirected_to census_url
  end
end
