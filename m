Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928379D051
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjILLrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjILLq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:46:59 -0400
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB0B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:46:54 -0700 (PDT)
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id IMH00048;
        Tue, 12 Sep 2023 19:46:48 +0800
Received: from localhost.localdomain (10.200.104.31) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.32; Tue, 12 Sep 2023 19:46:48 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>, <kishon@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] phy: qualcomm: Fix typos in comments
Date:   Tue, 12 Sep 2023 07:46:46 -0400
Message-ID: <20230912114646.8452-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.31]
tUid:   202391219464892185f47b6da30f4b9d140dc948cea35
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the description of the 'succesfully'.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c b/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
index 8814f4322adf..3642a5d4f2f3 100644
--- a/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
+++ b/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
@@ -152,7 +152,7 @@ static int qcom_apq8064_sata_phy_init(struct phy *generic_phy)
 		return ret;
 	}
 
-	/* SATA phy calibrated succesfully, power up to functional mode */
+	/* SATA phy calibrated successfully, power up to functional mode */
 	writel_relaxed(0x3E, base + SATA_PHY_POW_DWN_CTRL1);
 	writel_relaxed(0x01, base + SATA_PHY_RX_IMCAL0);
 	writel_relaxed(0x01, base + SATA_PHY_TX_IMCAL0);
-- 
2.27.0

