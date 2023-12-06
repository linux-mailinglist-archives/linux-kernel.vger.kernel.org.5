Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCC80766D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378342AbjLFRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442599AbjLFQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:48:15 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FEED6D;
        Wed,  6 Dec 2023 08:48:20 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6DIRgF018532;
        Wed, 6 Dec 2023 17:48:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        selector1; bh=wvfG5Rqta7GIdBWHc4KD1cLXXRlWbLdzhdJJUIP85QQ=; b=dY
        FqNmqWA9bgtrlse3TCx5oANS5jtggnYpkrn0i5rGH9eOqmOhghP1152ooj3sfxg0
        b62EWBHo6pw3r8UXVPfx8xnUpR3jxgVf7tegZX8b9+AM4VhLUV3N4IPxqCnZNPlx
        1AzfrxSWQjZJQui7BUTfJDwjK/lvIyIzR97aWvq5b2YcR/o9MSUuNaNgTyzAMo5B
        XA12zoyj2MNLTnehy9FCS87HRQFCSjiNENWfl8GNpFc5Sas+ulUFDol1UABUGldj
        U/1brbu2OEaUqnlv+kmcPFQSsjHqrQrjHkw7Wmg6hXYTl4xc1WG6fOWe2gw2SiiQ
        h108nsP1S+lS6VAyo+vg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3utd2jc0c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 17:48:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1CA86100052;
        Wed,  6 Dec 2023 17:48:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 165C526C9F0;
        Wed,  6 Dec 2023 17:48:17 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Dec
 2023 17:48:14 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>
CC:     <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] MAINTAINERS: add myself as counter watch events tool maintainer
Date:   Wed, 6 Dec 2023 17:47:26 +0100
Message-ID: <20231206164726.418990-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for the counter watch events tool. William has
been asking to add at least me as the point of contact for this utility.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3: Add MAINTAINERS entry. This is a split of another patch
series[1].
[1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..b8541ab7866a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5322,6 +5322,11 @@ F:	include/linux/counter.h
 F:	include/uapi/linux/counter.h
 F:	tools/counter/
 
+COUNTER WATCH EVENTS TOOL
+M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
+S:	Maintained
+F:	tools/counter/counter_watch_events.c
+
 CP2615 I2C DRIVER
 M:	Bence Csókás <bence98@sch.bme.hu>
 S:	Maintained
-- 
2.25.1

