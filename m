Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0506C755C57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjGQHES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGQHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:04:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34BF0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:04:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4Cjs694FzBQHHX
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:04:01 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689577441; x=1692169442; bh=myKEdCAbM5yxWamoUqPx5G8iLCz
        lCrrZkWCdNkmucXk=; b=XzI5ucUftMKcRL/UG9U0qOWuBf6L2SC3qkc+fXC5sel
        N3T7RmdCM4xppwbp9A3N6g7wAzvhvSTicTTsaCUJFan9F2cqnPT+C1wV+bJ5tnxj
        /vIBRML0sJe2PSCgh3PH2OdcRD6urVDIB68aL7b6jWa8pqtZynJCGC+i9qPsq6QK
        li77c97GANbNARt7Mr5YU2xVAZcOzvT2tXd3bOSsbsrJq1DPkzsmRhXeJqj04S27
        wAcHHHqOOUwxi9ID9auBLM5VjP3P9IcnYMykfYrSfDAWuxJQgCo4J5OlrV2wR5eC
        hjfX5mGX466aOLh7MHxiKl0N847NLjdKSOwXlZHdIfw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zQ5T-C7frJ8U for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 15:04:01 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4Cjs3sPxzBJR3x;
        Mon, 17 Jul 2023 15:04:01 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:04:01 +0800
From:   hanyu001@208suo.com
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] wcn36xx: remove space before ')'
In-Reply-To: <tencent_5D948ECE7946A4A04536C5EAD0B120565B07@qq.com>
References: <tencent_5D948ECE7946A4A04536C5EAD0B120565B07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f2d9a75e98698b245e5126eb425944a1@208suo.com>
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

Fixes checkpatch.pl error:

./drivers/net/wireless/ath/wcn36xx/dxe.c:470: ERROR: space prohibited 
before that close parenthesis ')'
./drivers/net/wireless/ath/wcn36xx/dxe.c:509: ERROR: space prohibited 
before that close parenthesis ')'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/wireless/ath/wcn36xx/dxe.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c 
b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 9013f05..b8d7676 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -467,7 +467,7 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, 
void *dev)
                         WCN36XX_DXE_0_INT_CLR,
                         WCN36XX_INT_MASK_CHAN_TX_H);

-        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK ) {
+        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK) {
              wcn36xx_dxe_write_register(wcn,
                             WCN36XX_DXE_0_INT_ERR_CLR,
                             WCN36XX_INT_MASK_CHAN_TX_H);
@@ -506,7 +506,7 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, 
void *dev)
                         WCN36XX_DXE_0_INT_CLR,
                         WCN36XX_INT_MASK_CHAN_TX_L);

-        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK ) {
+        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK) {
              wcn36xx_dxe_write_register(wcn,
                             WCN36XX_DXE_0_INT_ERR_CLR,
                             WCN36XX_INT_MASK_CHAN_TX_L);
