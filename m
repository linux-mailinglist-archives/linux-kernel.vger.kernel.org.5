Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F247CCD76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjJQUFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjJQUFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:05:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635381FF3;
        Tue, 17 Oct 2023 13:02:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31BAA1B836D;
        Tue, 17 Oct 2023 16:02:46 -0400 (EDT)
        (envelope-from ihor.matushchak@foobox.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6GcGXTgpZ+yE
        9Awpf0mhf0gPRO2d2AKCVMIkXY0Dv40=; b=stXLzBvumJLPKOoNUvnIrYXUVrG1
        p2+KfsiZHotkwolQHtzVp1HLPCmDAful07VB+Ie0gEcbmVkU4HDmeb+S2uSwcNX4
        8hSweQDNKIsaZ8kAnpUheL1PgdVfifGn/xmfsah62luJ+YrXrK2v+2p4IAZNQTn4
        4/1y8lrg1T1bKKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28F1E1B836C;
        Tue, 17 Oct 2023 16:02:46 -0400 (EDT)
        (envelope-from ihor.matushchak@foobox.net)
Received: from raspberrypi.telekom.ip (unknown [84.115.221.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EACD1B836B;
        Tue, 17 Oct 2023 16:02:44 -0400 (EDT)
        (envelope-from ihor.matushchak@foobox.net)
From:   ihor.matushchak@foobox.net
To:     niklas.soderlund@ragnatech.se
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, ihor.matushchak@foobox.net
Subject: [PATCH] media: staging: max96712: Fix device name in description
Date:   Tue, 17 Oct 2023 21:02:39 +0100
Message-Id: <11a00300c76df12c13adabfc71111607619a49f9.1697572799.git.ihor.matushchak@foobox.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZS7doO43ijXhBqkm@oden.dyn.berto.se>
References: <ZS7doO43ijXhBqkm@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 23644576-6D28-11EE-A7EF-78DCEB2EC81B-19565117!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ihor Matushchak <ihor.matushchak@foobox.net>

Fix the device model name in driver description,
which appears to be a copy-paste error.

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

