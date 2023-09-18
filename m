Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D47A4394
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjIRHyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbjIRHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:53:37 -0400
Received: from ssh249.corpemail.net (ssh249.corpemail.net [210.51.61.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2152730DF;
        Mon, 18 Sep 2023 00:49:41 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id NGG00157;
        Mon, 18 Sep 2023 15:40:57 +0800
Received: from localhost.localdomain.com (10.73.42.143) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.32; Mon, 18 Sep 2023 15:40:56 +0800
From:   Charles Han <hanchunchao@inspur.com>
To:     <corbet@lwn.net>, <djwong@kernel.org>, <dchinner@redhat.com>,
        <allison.henderson@oracle.com>, <bhelgaas@google.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Charles Han <hanchunchao@inspur.com>
Subject: [PATCH v2 1/1] Documentation: xfs: Remove duplicate 'the' in transaction sequence process
Date:   Mon, 18 Sep 2023 15:40:54 +0800
Message-ID: <20230918074054.313204-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.73.42.143]
tUid:   2023918154057640eaf18f255fa527821e0d728988d24
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "the" in comments.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
index 1625d1131093..a0678101a7d0 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs-online-fsck-design.rst
@@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
 2. The second transaction contains a physical update to the free space btrees
    of AG 3 to release the former BMBT block and a second physical update to the
    free space btrees of AG 7 to release the unmapped file space.
-   Observe that the the physical updates are resequenced in the correct order
+   Observe that the physical updates are resequenced in the correct order
    when possible.
    Attached to the transaction is a an extent free done (EFD) log item.
    The EFD contains a pointer to the EFI logged in transaction #1 so that log
-- 
2.31.1

