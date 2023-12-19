Return-Path: <linux-kernel+bounces-4946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD09818437
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC7B282906
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD513AF9;
	Tue, 19 Dec 2023 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="IY8ZJwZV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C849134A7;
	Tue, 19 Dec 2023 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 7E51A4FB;
	Tue, 19 Dec 2023 10:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702977151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nb4BQkMn7CZUy/4xRlRCnIBheKJWvx746c+gdEFQdbI=;
	b=IY8ZJwZVbahaHuHYYGRoZk0kSMGVxk+tKPqTsXVE+4DDGlMISmg79kT+Sghj60CI0WAKxN
	2/PP1dsYYIKYq6lVBwvZ6tEcLH/A6jHi05mGOrrGKQkEdf0srOkkMGajQ1p1nrHVbqFSyn
	S//CGgvlTToDRG4QG5sE/8x6dhNZZLLN2Bg0vK/IVtDnwccJ4jO7VYdOJ3mbOfgcWR+OSX
	Mlbbxvv6CscqpY/eTKtitayDiKaFqmRKKw4zk67pjJhzVSm+Pdm5oyoLQHokHDIU+X+I1z
	Cvle7foK5RxmjIATmv0CqUjzmLk6CuDayPx61PeVh/Axqs9+jzTfakzlmZk2hw==
From: Michael Walle <michael@walle.cc>
To: linux-gpio@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	mwalle@kernel.org,
	Michael Walle <michael@walle.cc>
Subject: [PATCH] MAINTAINERS: change my mail to the kernel.org one
Date: Tue, 19 Dec 2023 10:12:18 +0100
Message-Id: <20231219091218.2846297-1-michael@walle.cc>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As I'm doing more and more work professionally, move away from my
private mail address.

Signed-off-by: Michael Walle <michael@walle.cc>
---
I'd like this to go through the spi-nor tree. Hope everyone is fine with
that.

No update to the mailmap as I still (and will indefinetly) own my private
mail address :)

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d3ada3bb3652..8279761421ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9056,7 +9056,7 @@ F:	drivers/gpio/gpio-mockup.c
 F:	tools/testing/selftests/gpio/
 
 GPIO REGMAP
-M:	Michael Walle <michael@walle.cc>
+M:	Michael Walle <mwalle@kernel.org>
 S:	Maintained
 F:	drivers/gpio/gpio-regmap.c
 F:	include/linux/gpio/regmap.h
@@ -19920,7 +19920,7 @@ W:	http://www.winischhofer.at/linuxsisusbvga.shtml
 F:	drivers/usb/misc/sisusbvga/
 
 SL28 CPLD MFD DRIVER
-M:	Michael Walle <michael@walle.cc>
+M:	Michael Walle <mwalle@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 F:	Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
@@ -19935,7 +19935,7 @@ F:	drivers/pwm/pwm-sl28cpld.c
 F:	drivers/watchdog/sl28cpld_wdt.c
 
 SL28 VPD NVMEM LAYOUT DRIVER
-M:	Michael Walle <michael@walle.cc>
+M:	Michael Walle <mwalle@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
 F:	drivers/nvmem/layouts/sl28vpd.c
@@ -20446,7 +20446,7 @@ F:	drivers/pinctrl/spear/
 SPI NOR SUBSYSTEM
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 M:	Pratyush Yadav <pratyush@kernel.org>
-M:	Michael Walle <michael@walle.cc>
+M:	Michael Walle <mwalle@kernel.org>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
 W:	http://www.linux-mtd.infradead.org/
-- 
2.39.2


