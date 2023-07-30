Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0170768816
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjG3UqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjG3UqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:46:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07F010C0;
        Sun, 30 Jul 2023 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749957; x=1691354757; i=w_armin@gmx.de;
 bh=lhVCgsIuPXJy0ENSPpUKlNKgGAYT4lICUYiK693mRH4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CVmwiw+9pUEiQOoQlro+8n+GBy9Yexncc+Q5tbydXmajg7TyHOmus9rh1pgUl9ZkfbVdr5f
 DsThYAmLuG99GDq6RU9fQWUSlJFNqTU72wpJELiK5HKhYVjyTMubtpvCioBS4dBMXCAil7y8E
 1njE7JqTF2D4M+ftJh+BCxZyimFblGYahlu48V4VLZqgjPKqcuJxer30lEg5bcnr/SwIzgFCK
 ai/ZeaMMNGYrkrBZ8vfIyddr/c06PN57MGmqgFHFYGO7DkScJcgkzmwPM4J/xcUt922qrLgTT
 VAcq4otvkAfHDtdaPVFZocstN1LcbwFgNsjYMgejDcZ5a9f8wIrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MwwZX-1pfY2J4BWF-00yOYO; Sun, 30 Jul 2023 22:45:57 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] platform/x86: wmi-bmof: Update MAINTAINERS entry
Date:   Sun, 30 Jul 2023 22:45:50 +0200
Message-Id: <20230730204550.3402-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730204550.3402-1-W_Armin@gmx.de>
References: <20230730204550.3402-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SH8D/sSkiTiI8jJWXuZa+tVMUmaL6AU+kGPfCKsdqsIaqBTicRM
 lxNnoRfRhvIRHZDkTdUxDqFu25nHbKUIeHP/BtumzKg5hCifmd1nn+KA5DUzYTFFCPnZotI
 nivSmXAy+oyYGapFqY1kEjnSQkD/kAFUUNJDMvnoY1jD9LFBtqrbsL8wXXrEgA6Wy0rbW3l
 Gq1asqtiAHJahAtLpUNsA==
UI-OutboundReport: notjunk:1;M01:P0:qG86Jwi6vZE=;PYeW0Cu5coWhdgviftgAvCvpReR
 QX4X4tZRRmasdC+Z6aEClV7xpJETmzJnZECBNRLyDwEOGv4bIoZDpJAXLHH6hHOXPpt7IVcpK
 iiOqC9K0yQ9kZAaOigJd9K4cUg2bNV0HISmwjjw8RbXUip1jGnsFPkPTezYIMXdj6bMYVtWnq
 ASb3WNA9013uXyXQuQwtlfxVUweFSm+5zCGsLNPYv+xuXC2vKZ+Wdo63fC14jRv+XQ89CQEZw
 60PPF3TZk/pJfb6YrqPK40VNcW7y6cqU7i3ww7MPv8OWbxYnquM/qb2M9t8SRRgl3JabGYUt0
 d5KurykQK/vMpBBX67kuCtRnii8jOzoRw8liMtqD4g6u724f3o9yV/DQYjIKcmqMN065ba5hx
 8m9wABfLSKhQ1EU1Gq6fShs+X2HzeYXp0OZpzdi9aBKoF+ZzRUfIM/rLGKOStDPDvkImmh8k6
 GDJRVraCZRZtyPO97PL4oh5081VexG7kGjefTvmldPN2cxwtIuNpXq2Ah9nfR3HTPZzkQ0nAx
 wnIdaSjdhVaNoPMIxmm0B61Df5/1BBTdJ8JoKS81OzpZbg4yz9nu5geZxzZeVQx8HyUr0F7eQ
 TIArMvd28TqQkwhIbM/p5xVgqrH9McouqBFAu7TqUrUhSA4v5+av8wo3PPM4PlGxlgJPCbvYH
 aW4pE5P4b/oGnYDtoxTQGC0hQQdMSN3uZsBMYXPn5AgmDCiGjoGMDnfmk8jw+nEm2QoSdAfs9
 2nunXJIBusj3Ys1CXffH2uMqgksS/ZxAu/ijtk+0D5MQTTXIqloekm8+HyW0yh0XFlQDvRpTS
 oQSpCDaWHD3QA+0tL3M8DQEBjjkiqdXkyrJ+IH6A7H6CgN4tdBXaQHO/mjOjHY74/ctAQUMv7
 4FcUGhCTTS7Ldoe1XXz+YBfXAtm5CE4cIucNds9lACqGEcdn3TYHNQSYHx+35hb9NRJQQuMnt
 6j6sMhyNBgsWjvNE9lf3uFwl3X0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI Binary MOF driver is important for the development
of modern WMI drivers, i am willing to maintain it.
Also fix the mailing list address.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Chnages since v2:
- Use correct email address
Changes since v1:
- Add Thomas Wei=C3=9Fschuh as reviewer
=2D--
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 426d3be71da2..2740849d0f87 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22954,8 +22954,10 @@ S:	Odd fixes
 F:	drivers/net/wireless/legacy/wl3501*

 WMI BINARY MOF DRIVER
-L:	platform-drivers-x86@vger.kernel.org
-S:	Orphan
+M:	Armin Wolf <W_Armin@gmx.de>
+R:	Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
 F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
 F:	Documentation/wmi/devices/wmi-bmof.rst
 F:	drivers/platform/x86/wmi-bmof.c
=2D-
2.39.2

