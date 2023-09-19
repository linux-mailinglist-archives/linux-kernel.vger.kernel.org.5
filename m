Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCF7A574C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjISCPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjISCPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:15:38 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 19:15:27 PDT
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681D126
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:15:27 -0700 (PDT)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id OBH00018;
        Tue, 19 Sep 2023 10:14:18 +0800
Received: from localhost.localdomain (10.73.42.196) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 10:14:18 +0800
From:   Tom Yang <yangqixiao@inspur.com>
To:     <dhowells@redhat.com>, <marc.dionne@auristor.com>
CC:     <linux-afs@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tom Yang <yangqixiao@inspur.com>
Subject: [PATCH] fs: afs: two "the"
Date:   Tue, 19 Sep 2023 10:14:16 +0800
Message-ID: <20230919021416.49535-1-yangqixiao@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.73.42.196]
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 Jtjnmail201615.home.langchao.com (10.100.2.15)
tUid:   20239191014187a8cb11340690db51dc6d7702bcd5a48
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two "the" in this commentingy.

Signed-off-by: Tom Yang <yangqixiao@inspur.com>
---
 fs/afs/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 9c6dea3139f5..a2332d7b15d4 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
-- 
2.31.1

