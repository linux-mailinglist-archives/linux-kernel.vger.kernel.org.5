Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D98F75B3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGTQDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGTQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:03:14 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA7FD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:03:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6HXW4HqczBKy7b
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:03:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689868987; x=1692460988; bh=XZEkCdxgWC7BY4D//p6DxEPNGp4
        R49mMNuUDxqgfEjw=; b=dXlBo69256qjZktVGdMQzFDDZUr/g2bfkCBvH7X81vS
        pKPuQ8l9HIqMIu8hMrBNw2lOjirlrFyWDt9a5nrvUGApXuuW0J8BVfnQ8elHcS2M
        i/z0nJtpF0CzntlvArlLBM4sT3cW2aVryVeZ1qmrjun5OMp54p/ULAUfGlhOQ0VN
        px+KrRov5XbjGwvek8CqZadcpneMgEiMeJf/DSOsTparXDf4n4Ugp9rbSfVrdY/g
        dHwqcNvEP4D5LJ+5tbuVDqDliv0EA9aPltKYOPKSGoRlHf+8xFzFTMC1bXdjXK07
        QsKPdeGfwlBqkvUMUVzPlcJvTSeu+oQgdn9UghSuFMg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4dLKJZgnkrrf for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 00:03:07 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6HXW1sYRzBHXgs;
        Fri, 21 Jul 2023 00:03:07 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 00:03:07 +0800
From:   pangzizhen001@208suo.com
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/afs: Fix typos in comments
In-Reply-To: <20230720160136.1902-1-wangjianli@cdjrlc.com>
References: <20230720160136.1902-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <4e4279d109cc2f0156483700b628fe41@208suo.com>
X-Sender: pangzizhen001@208suo.com
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

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  fs/afs/flock.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 9c6dea3139f5..a2332d7b15d4 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, 
int error)
  }

  /*
- * Kill off all waiters in the the pending lock queue due to the vnode 
being
+ * Kill off all waiters in the pending lock queue due to the vnode 
being
   * deleted.
   */
  static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
