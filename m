Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D37BD058
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbjJHVl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjJHVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:41:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677DDAC;
        Sun,  8 Oct 2023 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5oCCkNgvbUHSsCsaO/gYrO0Jg80vhFklPWNFZlpC5ng=; b=BEC3aOnoc6D40FR4QXG1FDQgsx
        hWil8guCdpiVBgK2khdaxrkTejo9lfT2ec0HleG02JdR53A+/LlcyCd9qcRgKR2Gxh8/4dBTk4Qqh
        ATATEBRZD1YMBptQd1tpXGI9TO8EpEuuYVmYelj8Y9OojZx0dDHkS7rANJ5Fo7AhXATDESjdnuPiM
        +09PsZ5UikgBIqpj6RuRdoLUu8oQeFqBidtLlax6PxfAnflZfdCmRoQhdNBsheIhGuGioI2roVn9J
        XnkfUXQDoYQXTCRpmVAzIZeYBtFrxj0uT3CBrx5qAoDJnHH00YD4XifXYvEh7/jYYSvThHVNf+O4M
        pUQ/zfjw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpbWd-009M4Q-0L;
        Sun, 08 Oct 2023 21:41:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v2] net: skbuff: fix kernel-doc typos
Date:   Sun,  8 Oct 2023 14:41:21 -0700
Message-ID: <20231008214121.25940-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct punctuation and drop an extraneous word.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: change "that this" to just "that" since "this" is unneeded
    (Simon and Jakub)

 include/linux/skbuff.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1309,7 +1309,7 @@ struct sk_buff_fclones {
  *
  * Returns true if skb is a fast clone, and its clone is not freed.
  * Some drivers call skb_orphan() in their ndo_start_xmit(),
- * so we also check that this didnt happen.
+ * so we also check that didn't happen.
  */
 static inline bool skb_fclone_busy(const struct sock *sk,
 				   const struct sk_buff *skb)
@@ -2016,7 +2016,7 @@ static inline struct sk_buff *skb_share_
  *	Copy shared buffers into a new sk_buff. We effectively do COW on
  *	packets to handle cases where we have a local reader and forward
  *	and a couple of other messy ones. The normal one is tcpdumping
- *	a packet thats being forwarded.
+ *	a packet that's being forwarded.
  */
 
 /**
