Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F47A8E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjITVKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjITVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:10:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A19FC9;
        Wed, 20 Sep 2023 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=x49hznF5dKVq5xpLQ2IV7G/0gHzi5fDYWHSxVPaTUUg=; b=AszzIwc3lmIw4h30I+1GCcelEj
        4cAAMJB77+enJp1daQCOdeFfw94xHEs3kqDkv0V8dzyVuEFEws7Yf4p80g2Qgtz9xDz+3fsxRG4uu
        3nyc4zH9WyCH/b6B+WXu8GYBsvOH5Jb3EZiaMHJ+Xr76dT685GGBdBrS3iGYgjOsfQb+QfxjJgO09
        S7jAoLdm4VhFX9fjf80GTGbD0LCZbpKgnXZbNstrlF9AObNcYq6Vdkz7Ygpx/+7Yw/R032a8qV15w
        YOPl2Mxnp4rsold13gqug4cZZtIZ8hhRnM/HH+2CyO7bvu9iof5TSLUIjKBxg7QL+IP7TuG67SZ5i
        jRUclQpQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj4SY-004EWx-0Q;
        Wed, 20 Sep 2023 21:10:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Cc:     mcgrof@kernel.org
Subject: [PATCH] MAINTAINERS: add include/linux/module*.h to modules
Date:   Wed, 20 Sep 2023 14:10:09 -0700
Message-Id: <20230920211009.1009150-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use glob include/linux/module*.h to capture all module changes.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..b78cf8dc7f16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14289,7 +14289,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/kmod.h
-F:	include/linux/module.h
+F:	include/linux/module*.h
 F:	kernel/module/
 F:	lib/test_kmod.c
 F:	scripts/module*
-- 
2.39.2

