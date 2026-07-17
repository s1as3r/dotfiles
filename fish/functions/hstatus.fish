function hstatus
  python -c "print(__import__('http').HTTPStatus($argv[1]).name)"
end
