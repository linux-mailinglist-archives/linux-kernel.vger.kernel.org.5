Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF464753336
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjGNHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGNHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:33:48 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E52738
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:33:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2NWR0XdwzBR9sk
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:33:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689320018; x=1691912019; bh=Usv382XFUtv6vWCn0lKYsGI5eUA
        6ReNRdRvPzAqTTgY=; b=tCToTYkumbOYIdVr/qQkJigyKOnUCpYKZrH0fHj+deX
        2/LkjxukoThj1lZIO9cBHfR7TH6pGm8gALc0/EltZFQcrMoOpTG2tRA74mwW/oX1
        WVqme1AFU1KfEu2FQEwMNRawBSqeRaGbvAEpfhU6UHkvamxqr/RYRalq8vXMa3wV
        oVReOu1hHoIh6BiqVtkw4SPfwJ4NnxL9gVH2IT9ykpXK9nxceitwVetuTu8K1Ha8
        GU+J8oTgxJm6XA5+yt5njxHnqG5zIWSzX65WJbRxI+386/9GWqfWb41xlHklZ3sG
        L3XQkx4LQm/zhXCjkHFermRnL48AiWMvlwq3lT0rL+g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 93M4ls7urC6P for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 15:33:38 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2NWQ4gjhzBJYck;
        Fri, 14 Jul 2023 15:33:38 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 15:33:38 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: net: slip: Add space after that ','
In-Reply-To: <tencent_E3C977F14A713AB42848C636A3C3711E1505@qq.com>
References: <tencent_E3C977F14A713AB42848C636A3C3711E1505@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f6eda9fd824d62f3f2099ce284467dea@208suo.com>
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

./drivers/net/slip/slhc.c:465: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:465: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:466: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:466: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/slip/slhc.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index 72e64ee..0011915 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -462,8 +462,8 @@ struct slcompress *
      *(__sum16 *)cp = csum;
      cp += 2;
  /* deltaS is now the size of the change section of the compressed 
header */
-    memcpy(cp,new_seq,deltaS);    /* Write list of deltas */
-    memcpy(cp+deltaS,icp+hlen,isize-hlen);
+    memcpy(cp, new_seq, deltaS);    /* Write list of deltas */
+    memcpy(cp+deltaS, icp+hlen, isize-hlen);
      comp->sls_o_compressed++;
      ocp[0] |= SL_TYPE_COMPRESSED_TCP;
      return isize - hlen + deltaS + (cp - ocp);
