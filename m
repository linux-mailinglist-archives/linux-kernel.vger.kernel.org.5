Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F67F056B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjKSK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:27:04 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BEC6;
        Sun, 19 Nov 2023 02:27:01 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJAOBJS008098;
        Sun, 19 Nov 2023 02:26:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=LwgdJjLc236SAOv0r6Df0XX2tTK0RM3+IBv5YcQCeFc=;
 b=J3j2+/9yeN072qJMIUAkzkcmgy+dXvZqHklBXL5xXg1hKbqwSL912lpxa8Ayv2o2A59A
 Reugo76TlcmC/70x1eCMthOh5JsAz5r45N30LRt2xTkgzfoDG8xYKFAto+a3EhUDfTXy
 m2fWBRgXNfrzinbsdEhWUbZ/H/nUN5QzFUUiWW8pVk4TTsIRWOS9AspVrwMJTa8oQE7r
 xL0vvHH3nDC+QT3xkps9XQz9sI2jh05VADHzGTIxqmpHlTc2ab85TKeZ1uf3zC0R40Rj
 6KFkHZSZCM2rPhHQcx4KFiFOgeyxcPyYQKE16cOjEWiBReTgkv70yaANAmW7p10zSQI6 jQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ueugusvbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 02:26:49 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 19 Nov
 2023 02:26:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 19 Nov 2023 02:26:47 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 7032B3F704F;
        Sun, 19 Nov 2023 02:26:44 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v5 1/3] MAINTAINERS: add ac5 to list of maintained Marvell dts files
Date:   Sun, 19 Nov 2023 12:26:36 +0200
Message-ID: <20231119102638.1041978-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231119102638.1041978-1-enachman@marvell.com>
References: <20231119102638.1041978-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: m2aR6f9iAaJh4xHkKN2PkjmhIOJGXfCy
X-Proofpoint-ORIG-GUID: m2aR6f9iAaJh4xHkKN2PkjmhIOJGXfCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_09,2023-11-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 973568cae9e5..81779c436fde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2331,6 +2331,7 @@ F:	arch/arm/boot/dts/marvell/armada*
 F:	arch/arm/boot/dts/marvell/kirkwood*
 F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
+F:	arch/arm64/boot/dts/marvell/ac5*
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	arch/arm64/boot/dts/marvell/cn913*
 F:	drivers/clk/mvebu/
-- 
2.25.1

