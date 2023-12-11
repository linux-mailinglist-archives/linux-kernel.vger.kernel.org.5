Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2803E80D380
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjLKRR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjLKRR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:17:58 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2863BBD;
        Mon, 11 Dec 2023 09:18:03 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBDVP24026392;
        Mon, 11 Dec 2023 09:17:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        pfpt0220; bh=Nz/ciRfsh/WF2pc9D1372ur84zBkx7DS+s7HdFnw1xA=; b=dAv
        SfiIy/0rHHyc6HaZ4EM/eyzYJ/RQWS7a5OBq6mIJvX4VXD1W+9W2Og5aOg7G/lsV
        kjJHGYslOUxPrfH0847mamZkH8zsFLcdqOJ2ZtfbChwdj9KUaIWR/ChKWPdwYOJ7
        tEn5a58gaVxhxRC6of4sESMJqgJIqPbl/Vsdr53hHCphtYN/6wZDinXb/Mxr4MS8
        3ah+0k4x6qmiblJOOXTnl4W8bELp9vETYYB/Sq7tJldweRTKgH2R0IDiBQgG52yo
        nZ8Ta2bUqsNyQkf+ZlGhhGuV/T2NXh/Je1BGOrqWqetNU/zc01TF7iSWN8sC2V0m
        08ZwDieRyAtazwk6PLQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uvrmjnfne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:17:51 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Dec
 2023 09:17:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 11 Dec 2023 09:17:48 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 5E6C63F7068;
        Mon, 11 Dec 2023 09:17:45 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v8 1/3] MAINTAINERS: add ac5 to list of maintained Marvell dts files
Date:   Mon, 11 Dec 2023 19:17:37 +0200
Message-ID: <20231211171739.4090179-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211171739.4090179-1-enachman@marvell.com>
References: <20231211171739.4090179-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QjFulp7MFb59FlrYZa_S93hgiH8ZBuNK
X-Proofpoint-ORIG-GUID: QjFulp7MFb59FlrYZa_S93hgiH8ZBuNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add ac5 dts files to the list of maintained Marvell Armada dts files
by defining the entry as covering the entire marvell arm64 directory

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a229ce6f4169..17d07fde3aab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2326,8 +2326,7 @@ F:	arch/arm/boot/dts/marvell/armada*
 F:	arch/arm/boot/dts/marvell/kirkwood*
 F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
-F:	arch/arm64/boot/dts/marvell/armada*
-F:	arch/arm64/boot/dts/marvell/cn913*
+F:	arch/arm64/boot/dts/marvell/
 F:	drivers/clk/mvebu/
 F:	drivers/cpufreq/armada-37xx-cpufreq.c
 F:	drivers/cpufreq/armada-8k-cpufreq.c
-- 
2.25.1

