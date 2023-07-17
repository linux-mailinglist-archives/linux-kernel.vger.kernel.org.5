Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45CE7559D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGQDDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGQDDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:03:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C6AE48
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:03:43 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R46NX3YdszBHYMM
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:03:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689563020; x=1692155021; bh=sektMFR2B16JV9kFS/KKigXez+4
        7W8fBLNUaaSF32yU=; b=BSxn30iiM349D2OFRqXBrVlXTYNMDsSeqnSm8M5HQNS
        IScHKLfcmxto1Fej9x6GFGeJztnswnlvHHi50/8ymXuCpfoOOFBO2Fc8vMdKrJzX
        4xmthiuTYBkn01TLIlIAxTrnCReJ3aAmvIb07uW5tC/DIQIw8IHIvofdw4iwhN0a
        3wpiqNuPKCj1xvQ4y4PPqJGuTG627C9i8Rrc1q/m7OYBU1d4+5HPdgfvJo3TkazN
        jo61t8b+OR9eaEo0G3Rh3y0I4L9OKbd6/e6jTzQA1C5qqBOFfZP4D+c/NdL+ZuJS
        fVkXpw5mFxSMXLmgMgnAYddyz9njiu8N0fKl6XKnExA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zBylTSVDG7QC for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:03:40 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R46NX1fV1zBHYMC;
        Mon, 17 Jul 2023 11:03:40 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:03:40 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: 3com: 3c574_cs: Add space around '='
In-Reply-To: <tencent_847E8BEE8A0DA19841D2B6801D09F3E44808@qq.com>
References: <tencent_847E8BEE8A0DA19841D2B6801D09F3E44808@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <61ea29204b81265e05ee48f513c39653@208suo.com>
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

Fix checkpatch warnings:

./drivers/net/ethernet/3com/3c574_cs.c:171: ERROR: spaces required 
around that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c574_cs.c:177: ERROR: spaces required 
around that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c574_cs.c:177: ERROR: spaces required 
around that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c574_cs.c:177: ERROR: spaces required 
around that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c574_cs.c:192: ERROR: spaces required 
around that '=' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/3com/3c574_cs.c             | 6 +++---
  drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 2 +-
  2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c574_cs.c 
b/drivers/net/ethernet/3com/3c574_cs.c
index dc3b7c9..287af1d 100644
--- a/drivers/net/ethernet/3com/3c574_cs.c
+++ b/drivers/net/ethernet/3com/3c574_cs.c
@@ -168,13 +168,13 @@ enum Win0_EEPROM_cmds {
     Except for TxFree, which is overlapped by RunnerWrCtrl. */
  enum Window1 {
      TX_FIFO = 0x10,  RX_FIFO = 0x10,  RxErrors = 0x14,
-    RxStatus = 0x18,  Timer=0x1A, TxStatus = 0x1B,
+    RxStatus = 0x18,  Timer = 0x1A, TxStatus = 0x1B,
      TxFree = 0x0C, /* Remaining free bytes in Tx buffer. */
      RunnerRdCtrl = 0x16, RunnerWrCtrl = 0x1c,
  };

  enum Window3 {            /* Window 3: MAC/config bits. */
-    Wn3_Config=0, Wn3_MAC_Ctrl=6, Wn3_Options=8,
+    Wn3_Config = 0, Wn3_MAC_Ctrl = 6, Wn3_Options = 8,
  };
  enum wn3_config {
      Ram_size = 7,
@@ -189,7 +189,7 @@ enum wn3_config {
  };

  enum Window4 {        /* Window 4: Xcvr/media bits. */
-    Wn4_FIFODiag = 4, Wn4_NetDiag = 6, Wn4_PhysicalMgmt=8, Wn4_Media = 
10,
+    Wn4_FIFODiag = 4, Wn4_NetDiag = 6, Wn4_PhysicalMgmt = 8, Wn4_Media 
= 10,
  };

  #define MEDIA_TP    0x00C0    /* Enable link beat and jabber for 
10baseT. */
diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c 
b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 4a9cbb0..1c50e3e 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -1237,7 +1237,7 @@ static int myri10ge_notify_dca_device(struct 
device *dev, void *data)
  #if MYRI10GE_ALLOC_SIZE > 4096
          /* don't cross a 4KB boundary */
          end_offset = rx->page_offset + bytes - 1;
-        if ((unsigned int )(rx->page_offset ^ end_offset) > 4095)
+        if ((unsigned int)(rx->page_offset ^ end_offset) > 4095)
              rx->page_offset = end_offset & ~4095;
  #endif
          rx->fill_cnt++;
