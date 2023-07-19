Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201E7759AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGSQgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGSQgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:36:01 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09372121
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:35:30 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5W8Q2TxczBR9tT
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:43:02 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689759782; x=1692351783; bh=0qN7aWBD+baNQ4xVa9csEAf705n
        vxHS7iIjGmKgh65g=; b=vFq9wYwGZSh3ZTZ+aRLn+j5gSsy/7S1FD4xiasiDCAO
        ENIhgOplWEkmtwVDzQ77O0FqZVqOY07dHE971jVhHrbmp6e1ynyuzHOQwej3AFOz
        qODkrbaonEdOyCgRZ01iCsi59YrdJTtESgf5T1Ce5ZFKJyDeZdVDsGWiZR+oMBYZ
        cbxW/Kr1m11FxzkN/c3T+yXZatppTB3vnH4GcZXY8GB0XkEA/UF8FxT+fbD8XzWG
        p1PT3aKOMvz72Z8pMmomPHUHUJxks1lYPzw56gGFW6Z2C1OM5aFjJE9VP836Eh4j
        x892ZrsYtm+4WFiPgPVdzoiPtondQiqvrUBM1di2h9g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x03_wFDWzYGO for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:43:02 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5W8Q0bQmzBR9Zx;
        Wed, 19 Jul 2023 17:43:02 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:43:02 +0800
From:   hanyu001@208suo.com
To:     pkshih@realtek.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8192ee: phy Remove unnecessary spaces
In-Reply-To: <tencent_413C0292C42299E2632862909F6D4407C406@qq.com>
References: <tencent_413C0292C42299E2632862909F6D4407C406@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <1fa527d26c2f9535bca96bc39d3d40d5@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:742: ERROR: space 
prohibited before that ',' (ctx:WxW)
./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:766: ERROR: space 
prohibited before that ',' (ctx:WxW)
./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:766: ERROR: space 
prohibited before that ',' (ctx:WxW)
./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:771: ERROR: space 
prohibited before that ',' (ctx:WxW)
./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:771: ERROR: space 
prohibited before that ',' (ctx:WxW)
./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:927: ERROR: space 
prohibited before that ',' (ctx:WxW)
./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:974: ERROR: space 
prohibited before that ',' (ctx:WxW)

Signed-off-by: 	Yu Han <hanyu001@208suo.com>
---
  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c 
b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
index cc0bcaf..d4b6131 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
@@ -739,7 +739,7 @@ static bool phy_config_bb_with_hdr_file(struct 
ieee80211_hw *hw,
                  if (i >= len - 2)
                      break;

-                if (!_check_condition(hw , array[i])) {
+                if (!_check_condition(hw, array[i])) {
                      /*Discard the following pairs*/
                      READ_NEXT_PAIR(v1, v2, i);
                      while (v2 != 0xDEAD &&
@@ -763,12 +763,12 @@ static bool phy_config_bb_with_hdr_file(struct 
ieee80211_hw *hw,
                                    MASKDWORD,
                                    array[i + 1]);
                          udelay(1);
-                        READ_NEXT_PAIR(v1 , v2 , i);
+                        READ_NEXT_PAIR(v1, v2, i);
                      }

                      while (v2 != 0xDEAD &&
                             i < len - 2) {
-                        READ_NEXT_PAIR(v1 , v2 , i);
+                        READ_NEXT_PAIR(v1, v2, i);
                      }
                  }
              }
@@ -924,7 +924,7 @@ bool rtl92ee_phy_config_rf_with_headerfile(struct 
ieee80211_hw  *hw,
                  if (i >= len - 2)
                      break;

-                if (!_check_condition(hw , array[i])) {
+                if (!_check_condition(hw, array[i])) {
                      /*Discard the following pairs*/
                      READ_NEXT_RF_PAIR(v1, v2, i);
                      while (v2 != 0xDEAD &&
@@ -971,7 +971,7 @@ bool rtl92ee_phy_config_rf_with_headerfile(struct 
ieee80211_hw  *hw,
                  if (i >= len - 2)
                      break;

-                if (!_check_condition(hw , array[i])) {
+                if (!_check_condition(hw, array[i])) {
                      /*Discard the following pairs*/
                      READ_NEXT_RF_PAIR(v1, v2, i);
                      while (v2 != 0xDEAD &&
