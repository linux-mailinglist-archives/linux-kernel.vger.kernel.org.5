Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300375594B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGQB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQB7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:59:38 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FC19F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:59:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R44yR466kzBHXlG
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:59:27 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689559167; x=1692151168; bh=vAL+WidRa02nINUEn9kYmeUSeJl
        hPvOGfn7BLzlnckY=; b=sqPm9FBnhy/XZeRmrEcgFSdglOquHI4GsLBTGlhnLyf
        4WiMRCIpssVCJrWIkjEWGBd9uaaZc8sO0+JE3pEaIkLYUPKtXoY+zRfQ4jq/eoOQ
        FfO5oPMCAa+wOccU1Gk31yLM8Dtm6iVM/2+RRx8+F9zddHQC0ypuNi1Sz12uUyAF
        AO0D/Sl5dhCL1J1T/fns40XjfCtG7MeAw9uNyZk5BohHwv/Y4KMQHGensmrDuPMO
        wYxlMEXEuiA9AlmxpdH+M2CxsUrhnrtvVjiNRiMvmnkmkE7nro4y/KN3OlQpArCh
        uiPh62OlSwAp5JfBgkKm7KsTsIoLwAP174HI2p26emQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3DOEYdtyzqz1 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 09:59:27 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R44yR19vyzBHXR9;
        Mon, 17 Jul 2023 09:59:27 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 09:59:27 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net: space required after that ','
In-Reply-To: <tencent_86D2297E856205A9DAA674C8CD5B23912C0A@qq.com>
References: <tencent_86D2297E856205A9DAA674C8CD5B23912C0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <9a2f9dac0bd4ec9a110ce66a1f26f6cd@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:354: ERROR: space 
required after that ',' (ctx:VxV)
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:354: ERROR: space 
required after that ',' (ctx:VxV)
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:354: ERROR: space 
required after that ',' (ctx:VxV)
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:354: ERROR: space 
required after that ',' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c 
b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index c5687d9..65d7057 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -351,7 +351,7 @@ struct myri10ge_priv {
  (sizeof (X) == 8) ? ((u32)((u64)(X) >> 32)) : (0)
  #define MYRI10GE_LOWPART_TO_U32(X) ((u32)(X))

-#define myri10ge_pio_copy(to,from,size) 
__iowrite64_copy(to,from,size/8)
+#define myri10ge_pio_copy(to, from, size) __iowrite64_copy(to, from, 
size/8)

  static void myri10ge_set_multicast_list(struct net_device *dev);
  static netdev_tx_t myri10ge_sw_tso(struct sk_buff *skb,
