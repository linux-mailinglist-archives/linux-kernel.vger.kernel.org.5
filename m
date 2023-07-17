Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E54755CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGQH0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjGQH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:26:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A41716
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:26:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4D1b1Nz7zBQHHW
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:17:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689578259; x=1692170260; bh=WOF11T8cPGBiDtBHkc2Q1W/gt3q
        HG2GPKagEpk0fQ3Q=; b=FwJByUz0ZJ9HL8zss0c/4ZS6C1yOXvHUO75MX+4rc0v
        uiUXsQIwNI+NW3319/Xvv+ZRKF3HSZGVKopXyuWASZqeXITVAPfpouga1CcErLay
        WR53Jt7g8Z7eEuw84JK2fIspdf2V3cqali8b2plXp7gQDkvmKPhu4I73VslmfEiu
        RDECq8WT/ZkIF1m83w3V5xoGjwfYr1thY2A+zBAKZUjwJvweJXlk59p2MHwiEEFh
        g/ZnAMXx+e4vdA6mjCsa5pe98Y6OrwiIoG0Nl5lF8WGKNzqNnRn3yTyNze0M1Eb1
        36RFvIq5QMIcR9+UwFRHjqyH6cS3HLGyDWKH8YCVgAQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id li0enEMk-yM9 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 15:17:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4D1Z6RJvzBJTJt;
        Mon, 17 Jul 2023 15:17:38 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:17:38 +0800
From:   hanyu001@208suo.com
To:     kvalo@kernel.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ath: wcn36xx: space required after that ','
In-Reply-To: <tencent_1007902217D11483429F82606CE33B24E609@qq.com>
References: <tencent_1007902217D11483429F82606CE33B24E609@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <8d242d729e447fe0f41af7bccc35396e@208suo.com>
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

./drivers/net/wireless/ath/wcn36xx/dxe.c:233: ERROR: space required 
after that ',' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/wireless/ath/wcn36xx/dxe.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c 
b/drivers/net/wireless/ath/wcn36xx/dxe.c
index b8d7676..1e660b6 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -230,7 +230,7 @@ static void wcn36xx_dxe_deinit_descs(struct device 
*dev, struct wcn36xx_dxe_ch *
      size_t size;

      size = wcn_ch->desc_num * sizeof(struct wcn36xx_dxe_desc);
-    dma_free_coherent(dev, size,wcn_ch->cpu_addr, wcn_ch->dma_addr);
+    dma_free_coherent(dev, size, wcn_ch->cpu_addr, wcn_ch->dma_addr);
  }

  static void wcn36xx_dxe_init_tx_bd(struct wcn36xx_dxe_ch *ch,
