Return-Path: <linux-kernel+bounces-22309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1B829C15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424741C2217B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F914C62D;
	Wed, 10 Jan 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ReIrpcHb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8954BA86;
	Wed, 10 Jan 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE97W3082845;
	Wed, 10 Jan 2024 08:09:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895747;
	bh=93QnWTwpjLdmFplR5QOGy0kgdS5AD0e+GekQxYjtSrU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ReIrpcHbbYFpJZoe0Y4N0t6qArl3PLU5f1yrPwb/nQ1Jh9sJVyW16DLLbbO13uWjT
	 MUAryzFREWHuzXfIwTcqeddZolm9D7J9KowoIWUd/Zm5h+VmBlj7vLWknDMVv8O66i
	 ugSjsowC23lwd0ZFU/6eN62sMA2ozetxde7i6kbQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE97Yi022991
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:07 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE97Tq025526;
	Wed, 10 Jan 2024 08:09:07 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Chao Zeng
	<chao.zeng@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Le Jin
	<le.jin@siemens.com>
Subject: [PATCH 14/16] arm64: dts: ti: iot2050*: Clarify GPL-2.0 as GPL-2.0-only
Date: Wed, 10 Jan 2024 08:09:01 -0600
Message-ID: <20240110140903.4090946-15-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110140903.4090946-1-nm@ti.com>
References: <20240110140903.4090946-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

SPDX identifier GPL-2.0 has been deprecated since license list version
3.0. Use GPL-2.0-only to be specific.

Cc: Chao Zeng <chao.zeng@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Le Jin <le.jin@siemens.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi            | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi    | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts            | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts      | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts     | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
index 1d1979859583..c424fef19d5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2021-2023
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
index e9b57b87e42e..5eeeca27dee6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 61a634afaa4f..00520c75e0f5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 1d6cddb11991..c927c8679017 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
index c62549a4b436..ec62dd7921d6 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
index 87928ff28214..4968a47f31ea 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index 3864ec54e371..ae842b85b70d 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index bd6f2e696e94..8f559f4e7dda 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2023
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
index f00dc86d01b9..173c941b1c4b 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
index 077f165bdc68..48b908c19ef7 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) Siemens AG, 2018-2021
  *
-- 
2.43.0


