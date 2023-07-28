Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9759A76778E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjG1VWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjG1VWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:22:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BDA44AF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690579315;
        bh=Rz5aF/hjgQ2zhjoUnOtXjSZ0wmQtpfWw5pPg2Ss5nzo=;
        h=From:Date:Subject:To:Cc:From;
        b=tX7hY0SXyQqq7VoE9xqM/+atqEU9Pop73XF8DC8UGPLlC60vIXzOBd1S9O6kdLPHB
         yt8ZkECQv1O6bEGqqe7Yw/cZMrnfDRMjFegg4RO4RET2Nly50HgRM9bhHXpifQaf7W
         e/ncXwLEG3AARqAl5j5tYDW+co/e8R75u+sRRwZ0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Fri, 28 Jul 2023 23:21:52 +0200
Subject: [PATCH] MAINTAINERS: nolibc: add myself as co-maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAG8xxGQC/x2MSwqAIBQArxJvnWBmJF0lWvh51YPS0IhAvHvSY
 hazmMmQMBImmJoMER9KFHyVrm3A7tpvyMhVB8FFz0ehmA8HGctOTf6uYGRonBu4VVKig9pdEVd
 6/+e8lPIByriwwmMAAAA=
To:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690579314; l=882;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Rz5aF/hjgQ2zhjoUnOtXjSZ0wmQtpfWw5pPg2Ss5nzo=;
 b=SluxY3dZMSJ2Gf5f3sVMQPmN//mATifbEk3vfieNvOuv4IXnF+mYn+V1ohKajyEWae0EttT44
 hZtGEM2DtxxDsXR2NJrHBjEg23NCF3uQmS5y4qLUSKvOLhRNRo7mITg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed with Willy, Paul and Shuah add myself as maintainer for
the nolibc subsystem.

Link: https://lore.kernel.org/lkml/7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b87fbcecd905..a67b50caea2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14993,6 +14993,7 @@ F:	include/linux/power/bq27xxx_battery.h
 
 NOLIBC HEADER FILE
 M:	Willy Tarreau <w@1wt.eu>
+M:	Thomas Weißschuh <linux@weissschuh.net>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
 F:	tools/include/nolibc/

---
base-commit: f837f0a3c94882a29e38ff211a36c1c8a0f07804
change-id: 20230728-nolibc-maintainer-ebdd50c844ed

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

