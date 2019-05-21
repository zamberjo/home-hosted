<?php
$CONFIG = array(
  'trusted_proxies' => array(
    gethostbyname('proxy'),
  ),
  'forwarded_for_headers' => array('HTTP_X_FORWARDED_FOR'),
);
