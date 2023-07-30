Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF607683AF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 06:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjG3Eir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 00:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjG3Ein (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 00:38:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3190;
        Sat, 29 Jul 2023 21:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690691913; x=1691296713; i=w_armin@gmx.de;
 bh=E2BkeqRCchKlZ5UcyxQtt4MhIEQUjS96zlYo9ea8ANU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YctsM5z6bD2R2i6cuAwy9pNIdWl+v3Of8byFPRfhEzaPXol9F7a93v9Jw4GFfHFHCosTO5f
 IY5beO3j7kT1PxuBPlDNVQ2kg4tY/wn5mnVzuZkc0N77/kdlkCiJrv5VAqBWXclkfZYhFCuw+
 IISPzYz/vIqgZr4SWLZa5riHItjteuzy/3gfF+RJyuIYMGKtoCYN6EVz5LlJs5FDb+Ku3mZ77
 YO0wwpKnS6Myf3KKxY/ro/D5YE5GOiqF/E3ST03t8+RgkC7Z//XAxZDwfl8iWv9Ui7ZNVnV7O
 /FoYIdmvnOT7hUIvIHdTJasVaWC+vQZJIci8FmhJr8qFRg9m6xYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MNKm0-1qFSjL2BLe-00Omus; Sun, 30 Jul 2023 06:38:33 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: wmi-bmof: Update MAINTAINERS entry
Date:   Sun, 30 Jul 2023 06:38:17 +0200
Message-Id: <20230730043817.12888-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730043817.12888-1-W_Armin@gmx.de>
References: <20230730043817.12888-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZD31ytDUWJlArlOSfgK1DEogizZfOi6umDyQasAIbzXC2Jsa/jf
 4S2OzB85Z+Oc9nioDF+noGfnr90eFNIB0fy31uh6OYkkCgpcXGpTDNYttM/8eUzY4xQ+b3y
 q7SwevFbdRNv8crhQMXtAbg06Xhil9xwFKvsoxB+SR/hWhZIW2967tqCU9iLUdeiFvPCMHl
 EwNPE6glc+uKlBpNbakfA==
UI-OutboundReport: notjunk:1;M01:P0:blwVOjIpxc0=;Dk7rdXuJFyaOWGloVcMKS5eEOsS
 vuV9O+339FgbD84970BO0U3aiMz6rWd60hZ92nnlYzXbdsj0E44vM1rSRr8UdpDXlCo4iQs9R
 8GUyOl1KycYZHdkrdrfTWEMD9O7hcOnWZdXxlVRkKn3nj2e+F1dbPLPnb9omXf81ExW5Wtj+s
 +9cuYtupt6B91rxKvQG3Sp5VyaAxDxJLA8jcGq3haYvueiaaa/tBDBhAKgOqG9LZdPBqKumSm
 z2T7Ra16k+cSVwb8Gs891gjg/V6dtlinQOxSDu5E5itwnz7NkA/U+6odGwyewxW9+Q/kJ8e76
 2o6w/Qvmc5eLVXWUUFMJh4X8E3zzuGSNQCuK1jUOfs1ZDUxchLKpelAsvIkriZ8g2irWSLsz4
 IhIISQo9JmosC/c/kKiIE+H9+5LWY7S6FLLQceLSC6s/Dr2P9VJHdBLEGgViiJidP76Ayy2ab
 G73AcfQjPjKosWgXEvgcHcW8U/eS3rWiS4cebn76p4UA4ef66XvInHtQ5XXwTZbzfEGkMqROi
 ous3MewVuiMVZC2DAlDlnM4mLSYjFin9NbCGwY/F/yEnConUEmViGX0dWBBV/AT0MI2xTEgr+
 nWauj0oofKDn3QfUUEBwpd+XVwp1RVCFmPwA2tYNMCovH+mCU0NGDdz59dxG3Hlpptzjv3LNA
 PTfD1lHalcY/9TfC3mbLIKJqlgOrjDbiH+pR8EjGUaF5LGz9pTkAzFQPNHPzFsmfUhaaoEBV8
 nJxxOD2SWiI1ehHZVCYt8GVYBiamgK5E6aCULynI3VXoGmj9XYtyr0srXgMW/Dy34f4nNiCYF
 RLQhql7NE5qtzOBtYRxcj/qu3zQiJS/u+v22B6xH8X1XOF77d1inTTzkfvLP4SMGp563tWRIN
 QZv7fONW5EFPlgtVKquXWE1mXZDtZcnthQtaWLwsrzbF9c3dh9TjnF+/qBQCFxYtyBSmHCVqX
 ysvJ71n+u1/5B4j+VeGFsFsXQh8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 426d3be71da2..9b871fb34e83 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22954,8 +22954,9 @@ S:	Odd fixes
 F:	drivers/net/wireless/legacy/wl3501*

 WMI BINARY MOF DRIVER
-L:	platform-drivers-x86@vger.kernel.org
-S:	Orphan
+M:	Armin Wolf <W_Armin@gmx.de>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
 F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
 F:	Documentation/wmi/devices/wmi-bmof.rst
 F:	drivers/platform/x86/wmi-bmof.c
=2D-
2.39.2

