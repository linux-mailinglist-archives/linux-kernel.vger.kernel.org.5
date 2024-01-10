Return-Path: <linux-kernel+bounces-22314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65190829C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119DC1F22B48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C94CB53;
	Wed, 10 Jan 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bb0BNeTD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F24BA9A;
	Wed, 10 Jan 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE977F082839;
	Wed, 10 Jan 2024 08:09:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895747;
	bh=L66jMX2jvlN9fTPlU9V+qXS/LtYpl/UZA+0RQhBR9zs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bb0BNeTD/SXsJRoYHAwjQvN6qr1sCZnS9zdkq+ZFTIY+LifgHLq5aCm+VOxQ8uRdK
	 hN4FRUajmrrlIqcK1vUe+AUlduN2NHEt82Kb/7TEFe+wXduDGRO8r4lin5v7FOGmH1
	 0GNPQQ+g6kzLBqvbWSeKjZiD8WghklALt37FTvI0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE97uK103025
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:07 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE97if041083;
	Wed, 10 Jan 2024 08:09:07 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Garrett
 Giordano <ggiordano@phytec.com>,
        Wadim Egorov <w.egorov@phytec.de>
Subject: [PATCH 15/16] arm64: dts: ti: phycore*: Clarify GPL-2.0 as GPL-2.0-only
Date: Wed, 10 Jan 2024 08:09:02 -0600
Message-ID: <20240110140903.4090946-16-nm@ti.com>
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

Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Wadim Egorov <w.egorov@phytec.de>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index aa43e7407eee..0c8e79de1c71 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index 4bc0134c987d..69b76c18207a 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
  * Author: Wadim Egorov <w.egorov@phytec.de>
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 1678e74cb750..dc76ed1adec7 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
  * Author: Matt McKee <mmckee@phytec.com>
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 53b64e55413f..5339aa107865 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
  * Author: Matt McKee <mmckee@phytec.com>
-- 
2.43.0


