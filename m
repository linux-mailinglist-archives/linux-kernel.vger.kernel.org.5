Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7804A7BCDEC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjJHK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbjJHK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:58:24 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174EDEB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696762697; bh=qXa/e6dsZkHqTj5+9b+2AVei1x9XTbZ2qUQGrtBvnEU=;
        h=From:To:Cc:Subject:Date:From;
        b=dwGbQbsLJzPpqvpntiNI1HeMG3loOi+yEI9tQrHeF7fxdSzMQ0Oou0j2gqatvXBiN
         56GY0J2qpGciNqr1rcEalDfkIwjbxdDK47+Nx7ditupOEevfuejBup7PKrNCFdgXw4
         OD1Jzee3rofXZujURlcnKQrx8lqL2KLbqCMu/TMU=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Qais Yousef <qyousef@layalina.io>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: update my email address
Date:   Sun,  8 Oct 2023 12:58:07 +0200
Message-ID: <20231008105812.1084226-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

Update my email-address in MAINTAINERS to <megi@xff.cz>. Also add
.mailmap entries to map my old, now blocked, email address.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a0a6efe87186..2084bf8ec2ab 100644
--- a/.mailmap
+++ b/.mailmap
@@ -452,6 +452,7 @@ Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
 Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
 Oliver Upton <oliver.upton@linux.dev> <oupton@google.com>
+Ondřej Jirman <megi@xff.cz> <megous@megous.com>
 Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
 Pali Rohár <pali@kernel.org> <pali.rohar@gmail.com>
 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
diff --git a/MAINTAINERS b/MAINTAINERS
index bf3e6ce86cbc..c9d53c4fb89e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6754,7 +6754,7 @@ F:	drivers/gpu/drm/panel/panel-sitronix-st7701.c
 DRM DRIVER FOR SITRONIX ST7703 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
-R:	Ondrej Jirman <megous@megous.com>
+R:	Ondrej Jirman <megi@xff.cz>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
 F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
-- 
2.42.0

