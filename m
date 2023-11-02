Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348887DFAF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377243AbjKBTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBThz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:37:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160ADC;
        Thu,  2 Nov 2023 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=aNFzAHye6B1qO1kppIXioMOdbIXWQ22j7LwyQZ+5w4w=; b=K7lSWYtNqQzPDI7UrE8Nzcw5fJ
        ktWXy1sbrGrkYHrQyFH16m9+97VICrxW9EBI+Q0Q+AekvCJ+JpspqLFrKGgJfSFKczIE9NaImq9J+
        gCkjEelnYR18cGPF47uCpgQDmZAVcJsyzV39Qy+MqbWNy0hLkKgnK93o2bO0SkSiszV2hWe94ycwi
        cZlwoYFkuZCR7E7VIdS72Vc99xr7sCi+0BV2eg+Yegpbpf+MfvMMU5hL0fn/9Shda307j6UMCcnPv
        So7VxfEXuTPtAbSX6mcB0NB6lzixjynM3dHgPNt+HiNPWYFqLeV7kjFtUXVdYkF2fRKoH1O9ejN5t
        8y+HOf3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qydVf-00AB2q-17;
        Thu, 02 Nov 2023 19:37:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com
Cc:     j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: remove Iurii Zaikin from proc sysctl
Date:   Thu,  2 Nov 2023 12:37:42 -0700
Message-Id: <20231102193742.2425730-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iurii Zaikin has moved on to other projects and has had no time to
help with proc sysctl maintenance.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..66c2e2814867 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17224,7 +17224,6 @@ F:	tools/testing/selftests/proc/
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
-M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-- 
2.42.0

