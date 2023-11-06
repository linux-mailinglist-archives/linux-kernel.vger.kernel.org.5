Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2564B7E2110
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjKFMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:15:20 -0500
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A136D92
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:15:11 -0800 (PST)
Received: from localhost.localdomain (unknown [172.16.99.211])
        by app2 (Coremail) with SMTP id zQmowABXMHvB2Ehl44nfAA--.27045S2;
        Mon, 06 Nov 2023 20:14:57 +0800 (CST)
From:   dslab@lzu.edu.cn
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yang Hubin <yanghb2019@lzu.edu.cn>
Subject: [PATCH] f2fs: the name of a struct is wrong in a comment.
Date:   Mon,  6 Nov 2023 04:14:18 -0800
Message-Id: <20231106121418.3675-1-dslab@lzu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQmowABXMHvB2Ehl44nfAA--.27045S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF43WFyUXw4kGr4rGry3Arb_yoWftrX_uF
        10qrsrAw4fAFnIqa1Ykr1avFs8Zr4vkF1rWFs2yrnF9a4DJrsxuwn2qwnxZ3y5Gw1IkryU
        Z3Z7Zw1xJw1DCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
        kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxAIw28I
        cVCjz48v1sIEY20_Cr4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2rcTDUUUU
X-CM-SenderInfo: pgvotuo6o23hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Hubin <yanghb2019@lzu.edu.cn>

The macro SUMMARY_SIZE represents the size of the struct f2fs_summary,

instead of the size of the struct summary.

Signed-off-by: Yang Hubin <yanghb2019@lzu.edu.cn>
---
 include/linux/f2fs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 2ef6ad75edb6..e0e28fc53644 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -460,7 +460,7 @@ struct summary_footer {
 #define NAT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
 				sizeof(struct nat_journal_entry))
 #define NAT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
-				sizeof(struct nat_journal_entry))
+				sizeof(struct nat_journal_entry))SIT_JOURNA
 #define SIT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
 				sizeof(struct sit_journal_entry))
 #define SIT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
-- 
2.25.1

