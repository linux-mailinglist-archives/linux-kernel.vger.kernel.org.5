Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB6813431
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573766AbjLNPKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573678AbjLNPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220C8E;
        Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566605; x=1703171405; i=wahrenst@gmx.net;
        bh=MoAx11XgLr0ouL9US7uE3kzhp+UdCYk0oyan3ug6VsY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=e8pKeY3cqsbQ9o7XQU1uC1SmpDzmfwond6qtJLwY3z/QsklD+/WI3WiFtnPjBmQ3
         Q32FMVvGpZuGnlmacQRHEFKJMUjFHNdBO9ZQZDMgNLKg8Ta1Vwo89zW6l/HekVqxg
         L9cu35Xfn40ahECSQ7BHUt6t3M1ZKXdF8XVPUFPLBgR5gvFCcNbVSzMQkzvsa6cjo
         W2g3nc/QZNJYCpUY45bo7YXHU+OXmBuq4dqubu3Ax3m8MZhbgU0Yq9beKFPle7qJH
         +GmhLW3VacbTTb16DYo3Fsbimhgyyjqyg3JJGnEJ8B5M2HiSTUNqGHpn63Nxxvv5i
         gsXKZ6bTPSaJ/f6mjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1rDF7O3ktG-000YJG; Thu, 14
 Dec 2023 16:10:04 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 11/12 net-next] qca_7k: Replace BSD boilerplate with SPDX
Date:   Thu, 14 Dec 2023 16:09:43 +0100
Message-Id: <20231214150944.55808-12-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hw+SWl3SzyaI8G8Qd4WjAOMmiThtvdfxmBucxvgN4fLMcTHxHr+
 eIC4DWwaRsilm1q1iTMiop3IjoW3gBEkOTw027Z86U7EiijUCBvXVz0cEmEZDIXS3uMQLeZ
 Ip5/n4Q8Xi6IoxBE2CkIXBpw10HGvi/xD66VLga2pomhnJfuHF+csJ+bsn23W8In70z6YGj
 MuO47NhP2gh7cEp0pZNuA==
UI-OutboundReport: notjunk:1;M01:P0:51dXrrmYPrg=;hL4GE5ciazS5pgIBV1Q1JbU8rbU
 v8oJYwoGz0NfhqleJqVIXKLlDxMqcg4YFQ41kYN7fq/DorSI5ESV/PEPEuAtmp8NvqaYBo7bL
 8FkaS/XiW+Kv3dUWnSvztiyqnv34iGQemWn390+SwWdDfD4mjtCiZ0DFZnbnjh1E4jB0BbzAq
 iFrTRFV7H82QRALL3koLpgRgzc4EM3P4G1ViUF5OstORMBIrU50idZyixUVSbsB+m3Rw6eUGp
 RFEGmM1vM7bXJIv0l+YcWdBLizxjJGzdcS5QFlK/lSjb1SUn+aqEqauaLJOBpXyXi4pE2YfI9
 mdfcxXUvrwLDmdUXDmeYbOsYDx7MljLwezmu4REM+nmTqcFGlmVMvsesOLSMM2jGLjnbOS0gM
 T3duifib/fkThSdbfXU5VR0MFIb6kptA/p0Ns3hV6dOOVGjh8Qititv7oe1oizWbIynyEAPlB
 10YZ2tDuwX5wiwnJdpf1MtCyVXFXe/zyJTCJH3L8HQtMsg00nJ+nD3g3MxhgWUSNaYTRjduKf
 12JiHRQm8vJg3j/fSgirwQEtQky25l+DuBmcXlaMsDCXFG1xyUQB5A2F0FtK4lDQOzZfYuaOJ
 5Bkn3cdlgvq79g51DKUzLJFRU4/bMxjRi9K2AaRgJ/fprQ8LvykEaOidVT7sNWgTD6JFhJbOX
 O9fHM3f+3YehukGTDaOQVN5kaFLloTL+UsxIdZmt5mSX/njxgnkAefbVgVGo5GGwMSU5zHQpy
 5sqrwfVHDIOWqkNCD0De7nyr6SsxqS2QONUPP9tKE4pvjtvunSWuEoFAZKOStl5i/w0+CEY/5
 gfAg6jSrKRY4VMfBr7YM2rQFXigKfFCwppyZyg4BVZSor4fQl7xUI+4oorBqOPIOiMAm4E2pe
 RrUUsvqH0WJ5vIZ1rc1ZjY/vhBOyCSHfZuCiDOsUyWaY1kiq2TbjI7g9C9lh+dIYVqm23DQPf
 w9VKyq7M+bdKasRr5E39DZ9RA6U=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

According to MODULE_LICENSE the driver is under a dual license.
So replace the BSD license text with the proper SPDX tag.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k.c        | 17 +----------------
 drivers/net/ethernet/qualcomm/qca_7k.h        | 16 +---------------
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_debug.c     | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_debug.h     | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_spi.c       | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_spi.h       | 15 +--------------
 drivers/net/ethernet/qualcomm/qca_uart.c      | 15 +--------------
 9 files changed, 9 insertions(+), 129 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k.c b/drivers/net/ethernet=
/qualcomm/qca_7k.c
index 4292c89bd35c..6263e4cf47fa 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- *
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  */

 /*   This module implements the Qualcomm Atheros SPI protocol for
diff --git a/drivers/net/ethernet/qualcomm/qca_7k.h b/drivers/net/ethernet=
/qualcomm/qca_7k.h
index 356de8ec5d48..828ee9c27578 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k.h
@@ -1,21 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- *
  */

 /*   Qualcomm Atheros SPI register definition.
diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.c b/drivers/net/e=
thernet/qualcomm/qca_7k_common.c
index 6b511f05df61..be2f754efd21 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Atheros ethernet framing. Every Ethernet frame is surrounded
diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 088cca7f61db..44ed66fdb407 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Atheros Ethernet framing. Every Ethernet frame is surrounded by an a=
theros
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 12d68fdaad8e..a011a1c5d427 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This file contains debugging routines for use in the QCA7K driver.
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.h b/drivers/net/ether=
net/qualcomm/qca_debug.h
index 46a785844421..0d98cef3abc4 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.h
+++ b/drivers/net/ethernet/qualcomm/qca_debug.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This file contains debugging routines for use in the QCA7K driver.
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index fc05959ba825..a075193f3787 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This module implements the Qualcomm Atheros SPI protocol for
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index f735ad77402f..d59cb2352cee 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -1,20 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2014, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   Qualcomm Atheros SPI register definition.
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethern=
et/qualcomm/qca_uart.c
index 9adec91f35e9..f911effccfe0 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  *   Copyright (c) 2011, 2012, Qualcomm Atheros Communications Inc.
  *   Copyright (c) 2017, I2SE GmbH
- *
- *   Permission to use, copy, modify, and/or distribute this software
- *   for any purpose with or without fee is hereby granted, provided
- *   that the above copyright notice and this permission notice appear
- *   in all copies.
- *
- *   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
- *   WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
- *   WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
- *   THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
- *   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- *   LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
- *   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- *   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */

 /*   This module implements the Qualcomm Atheros UART protocol for
=2D-
2.34.1

