Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C067DFB91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbjKBUcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjKBUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:32:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87041138;
        Thu,  2 Nov 2023 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KgLnpwY8xc2H1YfXXJvpwZu7+Y0INuXs3yqtkGE0lBo=; b=jrFzCw2huxP0A+qMzS4GI5Dmqp
        DYjPJtYAoucNoaN9Bo7nJTZjPBUTfArCm5uZYUnCBhHk2Kdt5zw+XxhY1HF+biqZYhsneox33o3Jr
        fXTwxPtNwP2EkgTfMSv/bMlpZsVRiU4/cL1DWyPStRhLdzsehPtun/iS0ixMeO+D7xy54QQ0c7wsF
        Eaqw0Szqno3Vccw5xtAtHOwVL4yuyffCBxYdGOLmL8JjGlbpuBKEGnbwzGC6O6zU83Ke7xys+9h+6
        h49z/e8h00nRp36u7rKYEDbammQhXezilIXLfxqeqverGkygw9paCUw7GgSQEaJFXxNHlZwtg2FsM
        fl5Mtn1w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyeME-00AFax-1m;
        Thu, 02 Nov 2023 20:32:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org
Cc:     j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: Add Joel Granados as co-maintainer for proc sysctl
Date:   Thu,  2 Nov 2023 13:31:58 -0700
Message-Id: <20231102203158.2443176-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Granados has been doing quite a bit of the work to help us move
forward with the proc sysctl cleanups, and is keen on helping and
so has agreed to help with maintenance of proc sysctl. Add him as
a maintainer.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66c2e2814867..c9b077e779d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17224,6 +17224,7 @@ F:	tools/testing/selftests/proc/
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Joel Granados <j.granados@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-- 
2.42.0

