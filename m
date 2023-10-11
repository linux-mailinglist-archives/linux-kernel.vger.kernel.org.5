Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744AC7C51F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjJKLZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJKLZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:25:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F8AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:25:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qqXL8-0004kg-QL; Wed, 11 Oct 2023 13:25:22 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qqXL7-000tKt-Qn; Wed, 11 Oct 2023 13:25:21 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qqXL7-005zFu-2U;
        Wed, 11 Oct 2023 13:25:21 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mailmap: Correct email aliasing for Oleksij Rempel
Date:   Wed, 11 Oct 2023 13:25:19 +0200
Message-Id: <20231011112519.1427077-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the current work email addresses for Oleksij Rempel are
preserved and not overridden by private address. Alias the
alternate work email to the primary work email address.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .mailmap | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index c80903efec75..32c8978f99b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -450,8 +450,8 @@ Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
 Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
-Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
-Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
+Oleksij Rempel <o.rempel@pengutronix.de>
+Oleksij Rempel <o.rempel@pengutronix.de> <ore@pengutronix.de>
 Oliver Upton <oliver.upton@linux.dev> <oupton@google.com>
 Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
 Pali Rohár <pali@kernel.org> <pali.rohar@gmail.com>
-- 
2.39.2

