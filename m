Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6522F7C76E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442252AbjJLTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442185AbjJLTci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CA4E5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59FAC433C7;
        Thu, 12 Oct 2023 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139155;
        bh=pIVHG4vplV6etOcNL+CVUEJMJ5tK2surh60uQoBDLIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOVpNjxf0fWIgX8uOW7iQgzAhsM6mlXHvcTWkqiivOgwxeHHYcCdmP3xUYp9/oJbD
         z2rdi4Lkbx5W/d082xZ3/FAgXfWXr9DNco1IHKvY6sRcE8uoYGFHb42TSm/+P/V/Yo
         gESVTCo3cJb+rOCB0vrHLLN/3zgTvTOvzRt/QTxXZxqhSwGAOMeTtwfchcfxyHtTHd
         wYnjRnjR9s5vHf/JZ3erYrwlTR+fBh3wSs6zL1qqwG1ml87XI7R8xI8l9+7nOynhlV
         Yk5cHpUPo6tcqlLaCpsfgy6erI0kiuVrk7/4WRE+kOdD9IrQPpGJ0N4ukQwX4IgOfu
         tKZmc3w10f1gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3FEA4CE09C2; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 02/19] MAINTAINERS: nolibc: update tree location
Date:   Thu, 12 Oct 2023 12:32:16 -0700
Message-Id: <20231012193233.207857-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

The nolibc tree moved out of Willys user namespace into its own.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20230916-nolibc-tree-v1-1-06c9b59a5035@weissschuh.net
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..6c83087ea396 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15131,7 +15131,7 @@ NOLIBC HEADER FILE
 M:	Willy Tarreau <w@1wt.eu>
 M:	Thomas Weißschuh <linux@weissschuh.net>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
 F:	tools/include/nolibc/
 F:	tools/testing/selftests/nolibc/
 
-- 
2.40.1

