Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F3813437
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573744AbjLNPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573693AbjLNPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D886112E;
        Thu, 14 Dec 2023 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566605; x=1703171405; i=wahrenst@gmx.net;
        bh=+V6TWgFQD0QXBTOYOaUZSTtj4sBFwWacPDZFwSXHg/I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=GHuBBxfFaB6ZyTNo4lRdXOHi63HVIWERahhiNG0k3XpfiM+wWW4kqixq9tV6jI0z
         yFgDbRHZ0YD0p46ASx8PU6dVNiJRw2KwUF8Yp6qxOkvlW0VnMnKG85ax25QVUDyXz
         ajz67alULldzIzm32kZ19HpdgE51dDYA74muR+SvVMI2cnvWg0nqp56Feg50XcYD3
         iVyVI9jIVCnY3vZ6Zc79xspwUI/huzLrzYvAWggNwylt8Yu1J5RLfSktWd9NUVYBP
         LDyzDJxI5rgOxSx1l4/sK8IAVYZL4HKq4gFggK9tudv/A+8iWebaPo7jxg/ehUGy+
         97ughMfdCJHC9OTIXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1qtVJ912YE-00KQe2; Thu, 14
 Dec 2023 16:10:05 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 12/12 net-next] qca_7k: Replace old mail address
Date:   Thu, 14 Dec 2023 16:09:44 +0100
Message-Id: <20231214150944.55808-13-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uCDwzQ3sQIrP/AtvuPo1Sz9yf6dROMs+l0kalkMuagerhgEeg0s
 emuIf+WS8z8St0CycyIRf5Y4qeLrKvYSBZiIXzoAyFLYsqijKMtwfvzAkBT/OWLBPlqzOvs
 gFnWj/U/wxkKAdmmr0AjenvWlxDm2hS7AuuQxzaS/tw5iUkdGAAYX72bBlBNVFfKOPEKGLc
 LGHKud9KeY6BZmQ8eLvEg==
UI-OutboundReport: notjunk:1;M01:P0:6C6IfB+febI=;Upp/2WWO5+IRrWVvZgzBHRipSDv
 LyO+7rrTcY9lgg1YBiwTV/2Rn5ZDgtgEP9LUVeWSCqjKo7ptjF3FwQgF1kUqeI11TJHrytanE
 0QZ8uc9jBS0ybJ75xEfpbulO1tTk+d1D8FHPxKMR5lX9R2qAPMtW2yCc0t4yzF3h3/pYzP+KR
 2vD58kryHN0xQk99ZQlZoRlOebeRZfirsmq6hIBQlcO8PAvLbT3hHs6FesgsvfIYJDMNkX+Eg
 BcVJGEQIz3fMGSChrrwyNBHGcifiezIcXa7/RLxsdKHdFoB9J43MJTEPokb4mFfCOR7FgYFR7
 YXLipVb6DLzyneA52QNMIMDKmtQPzwobct8yLmp9lUCjEQzgUcU0wpUA3bi3w1Mm9c7pwnM6e
 KgIu1DJdG8Eerm/oQMWCDYOlZ6Q9VT5JW5NSr1DRPCIOR/yNLO7rXhi2hMfli6N9BvorTtItA
 ksoNy7A4ip97yEbNDkO+KTiDHM77GYb6fXAlAQQwsqNvLRVFRurMmWFo46AD2dLxwBinCSgd7
 Jp8Ltq11KGtL1/wQSI5BFlSfI8TTfVKyCts2SCaZOEiipjlX5jlT4cokBhVYlYT758TFiFOrr
 j8kOhGTF0N5sYrolaD/Q7BBEnB03+4tifcOJd9QkHQOpBc+SMXJaqK91r2PrjOHW9ioXpLwoL
 y1+vQhUTZS62tVCfL2sVykelyIgEFO4GvdFtcHLPsrY7VXoEtZ5fj8smyzddPsgnfPueimFgo
 IC9JJ/DqxzcSYVyvoXME8mskX0Bu0R1qakElTa3ye+TyoK6fQuGGiMknXxjAhhjMlhsk8SKQV
 FFw9MxqRSwE7MaYf8SkB0SgOUPk6RYiUb47klDaKE1s8ZqwV+s0agAyCJ+PsRQNjOu703PeQb
 gcuX4a0aAOVsl5CJ7mJJ7rdr7uj9EQgskNZdPqn9ZTfiUYBl8wWj2LuiO7I1+0Q57tGQTNffo
 UByQ3A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

The company I2SE has been acquired a long time ago. Switch to
my private mail address before the I2SE account is deactivated.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 2 +-
 drivers/net/ethernet/qualcomm/qca_spi.c       | 2 +-
 drivers/net/ethernet/qualcomm/qca_uart.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.c b/drivers/net/e=
thernet/qualcomm/qca_7k_common.c
index be2f754efd21..5302da587620 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.c
@@ -149,5 +149,5 @@ EXPORT_SYMBOL_GPL(qcafrm_fsm_decode);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 common");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index a075193f3787..ccf9a9d7ecb0 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1024,6 +1024,6 @@ module_spi_driver(qca_spi_driver);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 SPI Driver");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(QCASPI_DRV_VERSION);
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethern=
et/qualcomm/qca_uart.c
index f911effccfe0..fb53a0c32898 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -398,6 +398,6 @@ module_serdev_device_driver(qca_uart_driver);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 UART Driver");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(QCAUART_DRV_VERSION);
=2D-
2.34.1

