<?php
$CONFIG = array(
 'trusted_domains' =>array (
   getenv('NEXTCLOUD_URL')
  ),
  // 'trusted_proxies' => array(
  //   gethostbyname('proxy'),
  // ),
  // 'forwarded_for_headers' => array('HTTP_X_FORWARDED_FOR'),
  'overwrite.cli.url' => getenv('NEXTCLOUD_CLI_URL'),
  'overwriteprotocol' => getenv('NEXTCLOUD_PROTOCOL'),
);
