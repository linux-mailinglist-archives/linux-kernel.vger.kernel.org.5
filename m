Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD78755D64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGQHsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGQHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:48:17 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D210D9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:48:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4Dhl1khdzBR5lN
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:48:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689580085; x=1692172086; bh=jBmzA+Ot8NNeosauqxyCYei355K
        Xn+iPCtrHMP5yy5s=; b=ZRt0iTNUfpqyur7SY+1I2II3TGBVlsW+8OJTO98f+qc
        9Qjsmhsn06F/K0NI7qp9gaj+4KuEB34MwHl2UnA5Na36HePKzwul/Ka9gGVyXydq
        5wtrXUyoH4HkbFTWqq791H3ptduqOghU9jAeqFcqRqI/JNy3CYE0yOkPmYc+gpYD
        wM6POZkudvnrxmRdIYUdd1lFiyiPc5zvo+4qznjuEr/cVujfunB50XISmuZ23s2S
        EUeckLYZY9mbgPZ/HxO/bzK3LtIAL+Om6TZaoKbXVd8a8gBJO4AnSwS5cidcCRMg
        D93j+w5pDz88ITTPd6Cwve8hOkRXCV7cmz23MncFaow==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q7jV583kI0Vy for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 15:48:05 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4Dhh6nKWzBHXgm;
        Mon, 17 Jul 2023 15:48:04 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:48:04 +0800
From:   hanyu001@208suo.com
To:     toke@toke.dk, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath: ath9k: add space before the open parenthesis '('
In-Reply-To: <tencent_20790524E1454B45E150A32030DB910EB907@qq.com>
References: <tencent_20790524E1454B45E150A32030DB910EB907@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <2fafd955b5da152049bf4545b7ce3a0a@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

drivers/net/wireless/ath/ath9k/xmit.c: ERROR: space required before the 
open parenthesis '('

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/wireless/ath/ath9k/xmit.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c 
b/drivers/net/wireless/ath/ath9k/xmit.c
index f6f2ab7..72f9593 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -717,7 +717,7 @@ static void ath_tx_count_airtime(struct ath_softc 
*sc,
      int i;

      airtime += ts->duration * (ts->ts_longretry + 1);
-    for(i = 0; i < ts->ts_rateindex; i++) {
+    for (i = 0; i < ts->ts_rateindex; i++) {
          int rate_dur = ath9k_hw_get_duration(sc->sc_ah, bf->bf_desc, 
i);
          airtime += rate_dur * bf->rates[i].count;
      }
@@ -2437,7 +2437,7 @@ void ath_tx_cabq(struct ieee80211_hw *hw, struct 
ieee80211_vif *vif,
              break;

          skb = ieee80211_get_buffered_bc(hw, vif);
-    } while(skb);
+    } while (skb);

      if (skb)
          ieee80211_free_txskb(hw, skb);
