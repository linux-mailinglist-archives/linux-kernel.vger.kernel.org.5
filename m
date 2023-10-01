Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493C7B44D3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjJAAiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjJAAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:38:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5552CA;
        Sat, 30 Sep 2023 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=z88LOIZ7EHuBVYquetgM5Awx0oSZmDtFncHgndSEXL8=; b=c+v9RdPLbFnKnkqj77DOIeop5v
        dJI/ZozCdVWv+B8NUgRZEtN/fRQ0N+vT5b3DpWRlldnPHOWW1EfTuZ9w58yXDegSeCFDft+nmzFIp
        rzbkpEirDTyAEpt3tbVHW1aisXd3hy7CS6I7OvkAOolIMjhsle2k01q4vgrUBlyQcrKycbi/dj5Qh
        yoXyxobqiBAIQ2Ay4VMq4zZNkDh0PZqLLDbsEm1v+vdHGusjHOQyIcalTEvQdtA+aqD2li/3AaXr4
        0suSpZCMJ0Auca2HsEkYUCdKiZZK4exQoU2OI8b+f2v/PW7aNXBSMFk4dH3QVtMxQdVPy/lWu/o0d
        uPmUggaA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmkTv-00AI3H-1b;
        Sun, 01 Oct 2023 00:38:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] net: skbuff: fix kernel-doc typos
Date:   Sat, 30 Sep 2023 17:38:46 -0700
Message-ID: <20231001003846.29541-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
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

Correct punctuation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
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
+ * so we also check that this didn't happen.
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
