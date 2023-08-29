Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448FA78C529
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjH2NZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbjH2NYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:24:48 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E2CE4C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:24:31 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TC0wki022715;
        Tue, 29 Aug 2023 15:24:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=+Vgl2Y8JXKDXR1iSacggPnRmH2K1tDbZ6cx1kaU+7ow=; b=ya
        fVsqnlRy37dQDyop3OvbZgAEBGKyXz7OytwfAggOYrSBt3w+WVZDSsB3AWJUH/lB
        zky8XVkVs9EuVSz5P5iZfFad1eNgxM1tw0Cy5LVVlJfVkFKDuoYOEdhW0TYuulGJ
        Sn10ax2FQYowCt2OJuGRbOiqxO9lpqahlC4yw1gM+zIrl0bZ+v5NfmiuFRfdoiKg
        BrqNxLUKsL2UxEoux9/iwn1gW8DaHvQqoKTIYfNTvIigN0rNL4UxFa3Z1OQfhT/U
        mxQq8U9TxOZPl50GVVJvHsBd8pDIaK9tUr1rZeLsWpnB13H2Vh63PqxHWw/+QVBd
        eJ8Qqt6W5yB80EcMD2jw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq8qwc11e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:24:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B502A100063;
        Tue, 29 Aug 2023 15:24:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AD35422A6DF;
        Tue, 29 Aug 2023 15:24:09 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:24:09 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] media: MAINTAINERS: add entry for STM32 DCMIPP driver
Date:   Tue, 29 Aug 2023 15:23:46 +0200
Message-ID: <20230829132357.192535-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829132357.192535-1-alain.volmat@foss.st.com>
References: <20230829132357.192535-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entry related to the STM32 MEDIA DCMIPP driver within the
MAINTAINERS file.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 228bed60e006..d2c6fd410dcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13171,6 +13171,15 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
 F:	drivers/media/platform/st/stm32/stm32-dcmi.c
 
+MEDIA DRIVERS FOR STM32 - DCMIPP
+M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
+M:	Alain Volmat <alain.volmat@foss.st.com>
+L:	linux-media@vger.kernel.org
+S:	Supported
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
+F:	drivers/media/platform/st/stm32/stm32-dcmipp/*
+
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
-- 
2.25.1

