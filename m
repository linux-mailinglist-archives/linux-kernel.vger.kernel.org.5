Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA975339D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjGNHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjGNHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:51:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2B30DC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:51:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2NwP61ghzBR9sk
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:51:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689321109; x=1691913110; bh=IaiEwpWcOFHXscK+oYD5U76t98y
        szi7NqZeEKNSqRBk=; b=UPQQYe7d9sTS+WovY2u4zuZoESRBRfC2obBygIUenvk
        z+wc5Wqx6ZLK5zRG1FRiVTN5Fwgu8+RkZeh/3DF44CP5kskmtX6+25sx7WWQ2PP4
        Jk+28ueE9oZ/iwYObD3oRidI3DwWNiAbmCeqeWtj/Q8X/Lgyr8+tFpmr+6NIv0DI
        5bgtqM/1Qh0dD0yAyQ+rjfHOtI0+WE2thbhhzvSQhPuz2fIobgxXH34wwXf8HL2a
        MB6vUuO4Kb+9BBYcYZyF4/CmyvXxxoowaItvrFfLh400OYfgC3G75lRGaX0V6x8X
        u5O5tH5Zu/gEwaXt1KyvWUpuku19I4KBK15C3JveYeA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lj8EFzDTeEsl for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 15:51:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2NwP1rV8zBJYck;
        Fri, 14 Jul 2023 15:51:49 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 15:51:49 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] drivers/net/slip: Add space after that ','
In-Reply-To: <tencent_222320492FD62B52855A0449D87275D0CD0A@qq.com>
References: <tencent_222320492FD62B52855A0449D87275D0CD0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <05e49e0f838eb127cbaee30f1b404c19@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Error reported by checkpatch.pl

./drivers/net/slip/slhc.c:476: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:476: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:477: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:477: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/slip/slhc.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index 0011915..befdf4a 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -473,8 +473,8 @@ struct slcompress *
       * to use on future compressed packets in the protocol field).
       */
  uncompressed:
-    memcpy(&cs->cs_ip,ip,20);
-    memcpy(&cs->cs_tcp,th,20);
+    memcpy(&cs->cs_ip, ip, 20);
+    memcpy(&cs->cs_tcp, th, 20);
      if (ip->ihl > 5)
        memcpy(cs->cs_ipopt, ip+1, ((ip->ihl) - 5) * 4);
      if (th->doff > 5)
