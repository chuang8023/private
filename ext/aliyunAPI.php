<?php

function AliyunAPI($key, $secret, $host, $format='JSON', $params = array(), $method='GET') {
    $version = '2014-08-15';
    $signatureMethod = 'HMAC-SHA1';
    $signatureVersion = '1.0';

    $params['Format'] = $format;
    $params['Version'] = $version;
    $params['AccessKeyId'] = $key;
    $params['SignatureMethod'] = $signatureMethod;
    $params['SignatureVersion'] = $signatureVersion;
    
    while (1) {
        $params['SignatureNonce'] = _nonce_aliyun();
        $params['Timestamp'] = gmdate('Y-m-d\TH:i:s\Z');
        $params['Signature'] = _sign_aliyun($secret, $params, $method);
        $query = _splice_query($params);
        $html = cURL(_splice_URL($host, $query));
        $obj = json_decode($html,true);
        if (!isset($obj['Code']) ||$obj['Code'] != 'IncompleteSignature') {
            break;
        }
        sleep(1);
        unset($query);
    }
    return $obj;
}

function _nonce_aliyun() {
     $microtime = _get_microtime();
     return $microtime . mt_rand(1000,9999);
}

function _sign_aliyun($secret, $params = array(), $method='GET'){

    $params = _params_filter($params);
    $query = '';
    $arg = '';
    if(is_array($params) && !empty($params)){
      while (list ($key, $val) = each ($params)) {
        $arg .= _percentEncode($key) . "=" . _percentEncode($val) . "&";
      }
      $query = substr($arg, 0, count($arg) - 2);
    }
    $base_string = strtoupper($method).'&%2F&' ._percentEncode($query);
    return base64_encode(hash_hmac('sha1', $base_string, $secret."&", true));
  }
  
  function _params_filter($parameters = array()){
    $params = array();
    while (list ($key, $val) = each ($parameters)) {
      if ($key == "Signature" ||$val === "" || $val === NULL){
        continue;
      } else {
        $params[$key] = $parameters[$key];
      }
    }
    ksort($params);
    reset($params);
    return $params;
  }
  
  function _percentEncode($str) {
          // 使用urlencode编码后，将"+","*","%7E"做替换即满足 API规定的编码规范
          $res = urlencode($str);
          $res = preg_replace('/\+/', '%20', $res);
          $res = preg_replace('/\*/', '%2A', $res);
          $res = preg_replace('/%7E/', '~', $res);
          return $res;
  }
  
  function _get_microtime() {
    list($usec, $sec) = explode(" ", microtime());
    return floor(((float)$usec + (float)$sec) * 1000);
 }
 
 function _splice_query($params) {
     $arg = '';
     $query = '';
     
     if(is_array($params) && !empty($params)){
      while (list ($key, $val) = each ($params)) {
        $arg .= $key . "=" . $val . "&";
      }
      $query = substr($arg, 0, count($arg) - 2);
    }
    return $query;
 }
 
 function _splice_URL($host, $URL) {
    /*if(preg_match("/.*\/$/", $host)){
        $host = substr($host, 0,-1);
    }*/
    $URL = rtrim($host, '/') . "/?" . $URL;
    return $URL;
 }
 
 function cURL ($URL) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $URL);
    curl_setopt($ch, CURLOPT_USERAGENT, "OMG auto script tools");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);        //需要获得返回的内容
    $html = curl_exec($ch);
    curl_close($ch);
    return $html;
 }