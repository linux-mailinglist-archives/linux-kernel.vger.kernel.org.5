Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1E79D119
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjILM3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjILM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:29:10 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906BC1722;
        Tue, 12 Sep 2023 05:29:04 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 53058D5D;
        Tue, 12 Sep 2023 14:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1694521742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sY2JIgJ6gwjKjqWDcYYu9H0bpifdTCJ1bXAlJNUWe0Q=;
        b=v+d5epCN884OlM26IN/dG7OiVctL2x1P58IeoHGckRk2KAwo11UmIe3mVqCdbyHu5R6SNW
        9uXyC36pku1GCec7G5ArpAmAev/YSx7FrBGGRAs8plDnrqa53PMcSygGaAsjvk+q0B8J2n
        UvZ/ZHH3cTx5WqpqPQNeBopWhu7fQx/yquDUlBKAPyPTpn3XaZLn5YNssgEL55XVAaa7+U
        Wh9bfMPkvqlBzz6oZDePrGYEMThZ+23jsWOoW1NfIszzCDkiG7KGntetoyhy1W4iEnMnep
        nl0L4ZZ02cVeM5WjRPN6ha2TvUqxRaO8cJg2hOuhryu9fGEyAWTFog+Zgs6zAw==
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] MAINTAINERS: gpio-regmap: make myself a maintainer of it
Date:   Tue, 12 Sep 2023 14:28:50 +0200
Message-Id: <20230912122850.164150-1-michael@walle.cc>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I've upstreamed the gpio-regmap driver, I didn't have that much
experience with kernel maintenance, so I've just added myself as a
reviewer. I've gained quite some experience, so I'd like to step up
as a maintainer for it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69de688907ca..405f616e4960 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8872,7 +8872,7 @@ F:	drivers/gpio/gpio-mockup.c
 F:	tools/testing/selftests/gpio/
 
 GPIO REGMAP
-R:	Michael Walle <michael@walle.cc>
+M:	Michael Walle <michael@walle.cc>
 S:	Maintained
 F:	drivers/gpio/gpio-regmap.c
 F:	include/linux/gpio/regmap.h
-- 
2.39.2

