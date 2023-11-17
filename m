Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452FD7EF41D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjKQOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKQOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:11:00 -0500
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27055A8;
        Fri, 17 Nov 2023 06:10:56 -0800 (PST)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AHB0DQ8011141;
        Fri, 17 Nov 2023 15:10:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=Kws/q639MJvztK5KLu5Bbxad85uGco+6Jxy8C4cpx2Q=; b=BD
        9iFrmacyRwIL9khm8tAm6K8pdqIk8xCMfCXLR82pQt7tbLEW4Oix2rIUiDMD3MWv
        XQfqmE4YQRzljOnrRte+BSl31xhtYTohWUW8I4AjazFQIZSA8ue8jACHjinBWp0q
        uB+IHkYA6SEZOXYzNfrPhzSiz/DBI2XJroVx8L+XbSibkjcdesZIN8Izbwt/BrMg
        X45P7HNkBenL9FDVfD46sihNYqM3TkvHBIsgdsrBnk9lyMOONbiSg05M9625X7SG
        UNCpGxvONRjtpyTzLtAnkIqwyTBi4l9kM0qSmxLaZHkUdEO2SaPM0N8QdjrItwZR
        kCPzh5veHYKVMHLqj7cw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uanep95jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 15:10:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 057AF10002A;
        Fri, 17 Nov 2023 15:10:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0B2522F7DD;
        Fri, 17 Nov 2023 15:10:37 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 17 Nov
 2023 15:10:37 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add prefix for GalaxyCore Inc.
Date:   Fri, 17 Nov 2023 15:09:40 +0100
Message-ID: <20231117140947.540669-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117140947.540669-1-alain.volmat@foss.st.com>
References: <20231117140947.540669-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_12,2023-11-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for galaxycore (https://www.gcoreinc.com)

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..d35132a990f2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -494,6 +494,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^galaxycore,.*":
+    description: GalaxyCore Inc.
   "^gardena,.*":
     description: GARDENA GmbH
   "^gateworks,.*":
-- 
2.25.1

