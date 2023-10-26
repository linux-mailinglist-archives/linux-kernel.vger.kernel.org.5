Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED57D7ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJZIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:48:14 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA7C1B6;
        Thu, 26 Oct 2023 01:48:10 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q70U5H020548;
        Thu, 26 Oct 2023 01:48:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=NTrxOdimbyFzIILrK8XmfcWd1ebCedbSjG6ZoVHyKLI=;
 b=iABok4XtPhJYPHxQkLh5raSDMNQvJnJgy0UDsQpvtYmekWpLkBePGEZsuaHY/IVz6Hqc
 6IhsF5VN2j5kjI/lkOK3bwgf8vpa9rHfa6ADPBuNWj/fPNzcWUOBrZjN6vTACt/5b+sS
 Jhktj+Wv8AmrXgscvscwnwhFvMmonpw3GGW/PadzghklDU65ltAtNouGd3YPcXIMO2Ox
 aHFa+TMng65TSwzisPa/pBDdX8TsTICSEvHUaEsmOVrq/VZCQJjS5Ggl65aB6Q8+2QXk
 tApCESJqBPlsjE7VcEtO1QBVt79IxfpEtKXU9ksEAtoKnfP/a5poc08MfKmVhGYa+YWM tQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3txcsr1egg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 01:48:04 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 26 Oct
 2023 01:48:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 26 Oct 2023 01:48:02 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id D14D93F70C0;
        Thu, 26 Oct 2023 01:47:58 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v3 3/3] MAINTAINERS: add ac5 to list of maintained Marvell dts files
Date:   Thu, 26 Oct 2023 11:47:35 +0300
Message-ID: <20231026084735.3595944-4-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026084735.3595944-1-enachman@marvell.com>
References: <20231026084735.3595944-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mrfEph5_XdIaU9_C9ZRhkxXq0721Djni
X-Proofpoint-GUID: mrfEph5_XdIaU9_C9ZRhkxXq0721Djni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_06,2023-10-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add ac5 dts files to the list of maintained Marvell Armada dts files

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d13bbd69adb..0d9b8cace1de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2323,6 +2323,7 @@ F:	arch/arm/boot/dts/marvell/armada*
 F:	arch/arm/boot/dts/marvell/kirkwood*
 F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
+F:	arch/arm64/boot/dts/marvell/ac5*
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	arch/arm64/boot/dts/marvell/cn913*
 F:	drivers/clk/mvebu/
-- 
2.25.1

