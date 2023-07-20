Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29AE75A6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGTGzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjGTGzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:55:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253C12F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:55:42 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R63Nn32YkzBRDsQ
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:55:37 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689836137; x=1692428138; bh=NEZ/o7/CYbI/STdiYnu78RjdMH3
        ly697rFlKyHDjoWw=; b=Y3Cn5b2W3vn6QuInxM2KFWsA92zQ10YVH0ISCm7isGs
        5uLAGaovhnuW8e2RMwaBw5GeGoa5IyY2bRZeaudqMuMNe6R0toetf2RSJweQSCYe
        o3V1EQR2BYRfuvaC2g+lh/kpcfI0cP7aG74YFsBWuWG12puscYQ2OP/1yel0oujh
        PRvimccqUWSWwwda1J67IRx5zVPm9n795vc66n4B/5MA8LbUZRoa1GHea1nYVhmp
        bMD9bpFGbAB0+OggeUFwC/zX1C1gwU9ZLXYTpVnJDRo0Yq5RjAaRi9JrtUByFVov
        iQn4oJj+5cZzRqwsa0gKqUlHr6l3B0KZz1FEHiXklbw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WL7e_udTW8A7 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:55:37 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R63Nn0zSwzBRDsD;
        Thu, 20 Jul 2023 14:55:37 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:55:37 +0800
From:   hanyu001@208suo.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: gpio: Remove unnecessary spaces
In-Reply-To: <tencent_E888A1BD4167B61E1D3EF3F8488A8B148A08@qq.com>
References: <tencent_E888A1BD4167B61E1D3EF3F8488A8B148A08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <6c89e70749c462d441bd0c157d260570@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

./drivers/gpio/gpio-pca953x.c:1352: ERROR: space prohibited after that 
open parenthesis '('
./drivers/gpio/gpio-pca953x.c:1353: ERROR: space prohibited after that 
open parenthesis '('
./drivers/gpio/gpio-pca953x.c:1354: ERROR: space prohibited after that 
open parenthesis '('
./drivers/gpio/gpio-pca953x.c:1359: ERROR: space prohibited after that 
open parenthesis '('
./drivers/gpio/gpio-pca953x.c:1360: ERROR: space prohibited after that 
open parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/gpio/gpio-pca953x.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index a806a3c..7f4f7ee 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1349,15 +1349,15 @@ static int pca953x_resume(struct device *dev)
      { .compatible = "maxim,max7315", .data = OF_953X( 8, PCA_INT), },
      { .compatible = "maxim,max7318", .data = OF_953X(16, PCA_INT), },

-    { .compatible = "ti,pca6107", .data = OF_953X( 8, PCA_INT), },
-    { .compatible = "ti,pca9536", .data = OF_953X( 4, 0), },
-    { .compatible = "ti,tca6408", .data = OF_953X( 8, PCA_INT), },
+    { .compatible = "ti,pca6107", .data = OF_953X(8, PCA_INT), },
+    { .compatible = "ti,pca9536", .data = OF_953X(4, 0), },
+    { .compatible = "ti,tca6408", .data = OF_953X(8, PCA_INT), },
      { .compatible = "ti,tca6416", .data = OF_953X(16, PCA_INT), },
      { .compatible = "ti,tca6424", .data = OF_953X(24, PCA_INT), },
      { .compatible = "ti,tca9539", .data = OF_953X(16, PCA_INT), },

-    { .compatible = "onnn,cat9554", .data = OF_953X( 8, PCA_INT), },
-    { .compatible = "onnn,pca9654", .data = OF_953X( 8, PCA_INT), },
+    { .compatible = "onnn,cat9554", .data = OF_953X(8, PCA_INT), },
+    { .compatible = "onnn,pca9654", .data = OF_953X(8, PCA_INT), },
      { .compatible = "onnn,pca9655", .data = OF_953X(16, PCA_INT), },

      { .compatible = "exar,xra1202", .data = OF_953X( 8, 0), },
