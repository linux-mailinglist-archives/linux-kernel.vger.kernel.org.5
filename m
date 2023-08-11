Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E327790DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjHKNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjHKNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:34:57 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F8ED;
        Fri, 11 Aug 2023 06:34:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMlCH31kpz4f3wtm;
        Fri, 11 Aug 2023 21:34:51 +0800 (CST)
Received: from vm-fedora-38.huawei.com (unknown [10.67.174.164])
        by APP4 (Coremail) with SMTP id gCh0CgB3BqnzONZkJBjaAQ--.33744S2;
        Fri, 11 Aug 2023 21:34:52 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tomoyo: remove unused function declaration
Date:   Fri, 11 Aug 2023 21:32:45 +0800
Message-ID: <20230811133245.1445965-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BqnzONZkJBjaAQ--.33744S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF45Jr4rJr1rZF45ZFy8uFg_yoWDCFXEyr
        ZFyF1fWa1rZ393Gw1j9r1FqF1kZ3y8Xwn7Ga409FsrAwn0qFWFyw1kKFyfAry2qr1UWFnr
        XF9xWFZ5Aw12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbo8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
        AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3w
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

The last usage of tomoyo_check_flags() has been removed by commit
57c2590fb7fd ("TOMOYO: Update profile structure."). Clean up its
residual declaration.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 security/tomoyo/common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index e669837ed0e3..0e8e2e959aef 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1037,8 +1037,6 @@ struct tomoyo_policy_namespace *tomoyo_assign_namespace
 (const char *domainname);
 struct tomoyo_profile *tomoyo_profile(const struct tomoyo_policy_namespace *ns,
 				      const u8 profile);
-unsigned int tomoyo_check_flags(const struct tomoyo_domain_info *domain,
-				const u8 index);
 u8 tomoyo_parse_ulong(unsigned long *result, char **str);
 void *tomoyo_commit_ok(void *data, const unsigned int size);
 void __init tomoyo_load_builtin_policy(void);
-- 
2.41.0

