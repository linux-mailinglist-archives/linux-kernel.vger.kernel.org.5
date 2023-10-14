Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97B7C94E3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJNOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 10:43:54 -0400
X-Greylist: delayed 293 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Oct 2023 07:43:52 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976AC9;
        Sat, 14 Oct 2023 07:43:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CA6F2092F;
        Sat, 14 Oct 2023 10:38:58 -0400 (EDT)
        (envelope-from ihor.matushchak@foobox.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=8qxl7uyCWkHeF0T8u8l2FTgfQ
        vgyJ5TI56gi2Xn0Bqg=; b=wWickgK59S46qQYR5FlhSh4OU7YV3KwTvtiiAiCVZ
        JXJTOSp0YghTzOXSteLB8mqIkfl9dLHwAOiQbWwCfYzRUDaR8BZpViMim05jjksZ
        sqmrntSqaAwqNY3akKtZi2GJwtWhq8xwSgRksnWI4Ri0/yaQ7dOAzZykrov1T270
        1U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 750E72092E;
        Sat, 14 Oct 2023 10:38:58 -0400 (EDT)
        (envelope-from ihor.matushchak@foobox.net)
Received: from raspberrypi.telekom.ip (unknown [84.115.221.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C93B32092D;
        Sat, 14 Oct 2023 10:38:53 -0400 (EDT)
        (envelope-from ihor.matushchak@foobox.net)
From:   ihor.matushchak@foobox.net
To:     niklas.soderlund@ragnatech.se
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, ihor.matushchak@foobox.net
Subject: [PATCH] media: staging: max96712: fix copy-paste error
Date:   Sat, 14 Oct 2023 15:38:43 +0100
Message-Id: <20231014143843.3409-1-ihor.matushchak@foobox.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 66C38E70-6A9F-11EE-AC50-F515D2CDFF5E-19565117!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ihor Matushchak <ihor.matushchak@foobox.net>

Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
---
 drivers/staging/media/max96712/max96712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/max96712/max96712.c b/drivers/staging/=
media/max96712/max96712.c
index c44145284aa1..ea67bcf69c9d 100644
--- a/drivers/staging/media/max96712/max96712.c
+++ b/drivers/staging/media/max96712/max96712.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Maxim MAX9286 Quad GMSL2 Deserializer Driver
+ * Maxim MAX96712 Quad GMSL2 Deserializer Driver
  *
  * Copyright (C) 2021 Renesas Electronics Corporation
  * Copyright (C) 2021 Niklas S=C3=B6derlund
--=20
2.30.2

