# -*- coding: utf-8 -*-
require 'helper'

class TestRegressionHeaderImage09 < Test::Unit::TestCase
  def setup
    setup_dir_var
  end

  def teardown
    File.delete(@xlsx) if File.exist?(@xlsx)
  end

  def test_header_image09
    @xlsx = 'header_image09.xlsx'
    workbook  = WriteXLSX.new(@xlsx)
    worksheet1 = workbook.add_worksheet
    worksheet2 = workbook.add_worksheet

    worksheet1.write('A1', 'Foo')
    worksheet1.write_comment('B2', 'Some text')

    # Set the author to match the target XLSX file.
    worksheet1.comments_author = 'John'

    worksheet2.set_header('&L&G', nil, { :image_left   => 'test/regression/images/red.jpg' })

    workbook.close
    compare_xlsx_for_regression(File.join(@regression_output, @xlsx), @xlsx,
                                [],
                                {
                                  'xl/worksheets/sheet1.xml' => [ '<pageMargins', '<pageSetup' ],
                                  'xl/worksheets/sheet2.xml' => [ '<pageMargins', '<pageSetup' ],
                                }
                                )
  end
end
