Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A907F91E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjKZJBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:01:05 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26CFD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:01:10 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id 7B0krUMd82dY37B0kraNCf; Sun, 26 Nov 2023 10:01:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700989269;
        bh=uLAwvAAw9PRiZuXD+6doOUly5ZTCKAXXgKs3wN26bqg=;
        h=From:To:Cc:Subject:Date;
        b=J6KXICCr6llIFdEffwtufDqPcslGoM3bGKSPDjuoU452CGKf816J8EgCR6YaRtrZs
         lOz7lxE9OAu2ZKTBY5gBGEcRAZKDsW9yqzc3gdd4uRI8oxGLOW+cnsXpnasw0mjpzW
         nOVNgCfyYJd3d0J84t/02TXF2WOcbS8LYE93dcckaCSszaLGjMaXxdwQuv7rHNQfg0
         LAZYYG7gZwG5lEUliFKr/O+B6TUwuOoZ/1+86PfL4+uBK7VCnGSN75/g7WINy6M+WI
         S3B6PufaqWQi7q64dvq4VHWmd5YlChz9E2tflLhmuWB1FhQm8FFKFaXGo920oFPnSo
         vk/9AI9U+nN6A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Nov 2023 10:01:09 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] MAINTAINERS: add include/linux/lockdep*.h
Date:   Sun, 26 Nov 2023 10:00:59 +0100
Message-Id: <e722abd043e5de64d2acd28d581e4a952994a94e.1700989248.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have lockdep_api.h and lockdep_types.h match as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2b2cd60eb20..2a1480051583 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12492,7 +12492,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 F:	Documentation/locking/
 F:	arch/*/include/asm/spinlock*.h
-F:	include/linux/lockdep.h
+F:	include/linux/lockdep*.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/rwsem*.h
-- 
2.34.1

