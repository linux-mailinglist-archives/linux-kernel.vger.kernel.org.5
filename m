Return-Path: <linux-kernel+bounces-4490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E2817E21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E42A281CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00B7EFAC;
	Mon, 18 Dec 2023 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ptTE9SK9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B58768FF;
	Mon, 18 Dec 2023 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942021; x=1703546821; i=wahrenst@gmx.net;
	bh=dGQZrQAtPAAdqn1RR96G/+3tEEihlKoJ4rMV+rjxWCs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ptTE9SK9QEgevO0Z8RJqAYfcEZ4UYkuwlRSbq9cC91fHViyo9G2wafm4Dyz96/qa
	 bsOG/RataMLP7lVIymnoeb2HAdpH2Wi5YU7j/dxdsBJva1L0aUJXa5TiV0q2jWGdy
	 dVE2kXdsCSbbyhyzateE0HQsaXFwr/vlP+FakmMhqDXtgW00QlTJ0er3n/QOs0WFt
	 L7tXGRxaYigY287MyZ4c5yAdMwTvysd5aVbSmS1i3+pvU1CTRAO0lD8Orw9v1Kmrs
	 xMbKBgB27BKFJ6G5sjb7649BP6dhp92va66OduE1wue+Soik3tGa1q1fdz3DNuZr+
	 H3TnV2QVwp2lp+xThw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1rK1iO1Kmf-004log; Tue, 19
 Dec 2023 00:27:01 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 12/12 net-next] qca_7k: Replace old mail address
Date: Tue, 19 Dec 2023 00:26:39 +0100
Message-Id: <20231218232639.33327-13-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218232639.33327-1-wahrenst@gmx.net>
References: <20231218232639.33327-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:idcAzR2hwvfWhfp3JA/vOz3Apoibd8T++eB3q53hVzJTh4P73Lv
 fXJtXwqK1HTM4lfBoWeBu+UWQvaP0UtvoKrakAD468/NqQ7bfttmFeWg+6i4JOBnhPHKks6
 wrh8h6XIe7NA1CWd43qPV/dkwKclmT36c5YK2+0mpM274MPtKE6pIIxrVM/LlNT8vE1n1xp
 dWj1zf9epOKVfopYNVA2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tvMEd/mnorI=;geDrXHjqWKO7ITJR8V9vjDv52m1
 hYJCBFjxZN/WCuM8yAGtVD3dNRFCx1zyFYRfHVQtbQGAWLlXlmEVKIMGDS3P/ZRmMjW2XNeE+
 pf+4n2OlMoVG/qGlzH5GzZcCx9ECSx9dbeQlKcx5omwhWcPJ1BspWVvgvNQHcKconqc3lOvld
 3BRqh4VOcOvtdMKbQQxdNx0T1Q2cDYqLGzFRM4SEzx0XB013ZXKpGwrAivoS32rQcCs72Gwaz
 LiEl6Utdeq4bqoYbvGcJk53SiLsjgXs5vIgF6zpyMvOcAXvx4kTUwURdqhfWeMoNn6Hol4WgF
 Aj+H43lDNiP2zPC+baC8c75T3wgGfSiYN9rt2BXPBRCs8tvMQDckhciuWFL+aQbiSnktvFsab
 ycI/CteOiH+KJpLuUJjc35E55LyQBqjP1FvsJVS1tYDGHRijlxAGh4QgOPKAj+YS5mIYhLBfZ
 Ykt6lXyNtwgn/v4+Duq7ZESUeeaGuRXZM4h8vLy3Mfbbiq+VYy3MiPbg4zsh9r5IlEgPlRfMC
 fujgGtKuzQ9pTc9Fodcz0wR6bdMAzcTUowzvd3ScIF0ip6Y5XBBDZuiPZETTNrgaeXjhQEExj
 s7nTJTQBRHH0neJyPGZkb4vsXoovvhnNT1vkoqi2Ddj97IcEXwM70wCeH0OBcljlPtd4JTrgA
 61iUOlIeI4nadau2nYA8ekjqxtTW2zI0kXTTRhMiOwBbQ1xCK0QQPq46ERZDm4awW6xEi8yAP
 42VlhwR6ZY6adTUczuh26F1XbovtqKpBIzPZnkALhlsSLJMCeR3tgMtb5WVyBPrSbIUt8XR/+
 Fi6shhDyKH9dzzkqVc0RazAmPMb/kIF5fHZ3GuUfAO1+OLtY9mARZUCmYDVX8epw1eMQm0c2t
 kcS+JEfDqTN495WL3kBklOHa8uBK3TlCIxev6yKMStYX/YwCIs1b2Oe58avd5lhozW6nyNOYr
 RefPUOz+uUskTbM1Wg6aXZzYPe8=

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
index 7c63baeb3844..29be0fe0b235 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1042,6 +1042,6 @@ module_spi_driver(qca_spi_driver);

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


