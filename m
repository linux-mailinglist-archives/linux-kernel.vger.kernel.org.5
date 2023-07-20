Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99BD75B376
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjGTPvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGTPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:51:21 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50E123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:51:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6HGf2kVkzBRDsm
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:51:06 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689868266; x=1692460267; bh=QHWNe1mqz3NvIUz3H4DBgQVNjFe
        BHcnxIh6enZ//wnQ=; b=10MJxVoh2/j1mWb66F/BHH0337J6kutgh2mj587GoT4
        U12y9QXiX0J/FQHUfK8lySeV3FH7jC/zxpvyZWJIKv4C80aCEpft4GiYCvrKsXsq
        5pEq6hC+AElkA6CMPWpSVAuyC4UY+cpj6GNvRlIHXQDBNhs0T4dJnCEV4oda20Zv
        gzu4kMN/OUju59gHcgXYFTRTstA0660wH9+9r+SU/SknpidxEJCDxK/aBDzJIEmW
        bOJMRjZRfP07J8sFOVabuJPIrhk1BD85F1NIuxbhJENSYV6DSUaTksE85o9PvlkF
        KEIO8q8NGQUqg+q6p5AGwacidqNL62BBFhRQzcdO3kQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hvtP98v-gVXy for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 23:51:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6HGf14BwzBHXgs;
        Thu, 20 Jul 2023 23:51:06 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 23:51:06 +0800
From:   pangzizhen001@208suo.com
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/xfs: Fix typos in comments
In-Reply-To: <20230720154942.56848-1-wangjianli@cdjrlc.com>
References: <20230720154942.56848-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d8927acfb0f11e0bcd2d7a015a0238a7@208suo.com>
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
  fs/xfs/xfs_aops.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 451942fb38ec..66b311ccc4f9 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -478,7 +478,7 @@ xfs_discard_folio(
              folio, ip->i_ino, pos);

      /*
-     * The end of the punch range is always the offset of the the first
+     * The end of the punch range is always the offset of the first
       * byte of the next folio. Hence the end offset is only dependent 
on the
       * folio itself and not the start offset that is passed in.
       */
