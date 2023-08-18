Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4D780E30
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377867AbjHROmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377805AbjHROlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:45 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864313D;
        Fri, 18 Aug 2023 07:41:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EAEB20004;
        Fri, 18 Aug 2023 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lyznu4cPe0CCri4js4T7LBA0b1sDnyzuZNSR3Uosod4=;
        b=SheUuMlVRP3GeXpJVSZeRYPvFM1QyDmwi5gETIHeIRRfoQD7uaYPNIJa6fwVgSX5iIfW2V
        NUngfJe7foSHkUQH+bTdY4yceFHS6i6B6vFih/ppK5pE7VdwVVUV6Wig7YlsNsTEKjvdKL
        OoXpiZTYqUQ/f0jPHRRQ9XV3JX7hV+tGCFONTtnr6jq9LYbkPZ6woLCWdfSLHZA90uDgIX
        qSxWe+jxFQwYMVAelt9s/cz4OOLG5YZJQ+HK5UasHCJizbCL3q2wFX4rp275IWG9sZYwif
        xJ19sEoQFi1hWXjKtoTpqklLdRDlBs+OVQrPKjcCs/h9xhV387lLGfq+NIloQA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 02/10] mtd: rawnand: qcom: Rename variables in qcom_op_cmd_mapping()
Date:   Fri, 18 Aug 2023 16:41:40 +0200
Message-Id: <20230818144140.146111-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-3-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd68b7e5f49b81944656eeb70fae1b733f5ac26d8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-08-05 at 17:41:38 UTC, Manivannan Sadhasivam wrote:
> qcom_op_cmd_mapping() function accepts opcode and returns the corresponding
> command register. So let's rename the local variables and parameters to
> reflect the same.
> 
> Reported-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Closes: https://lore.kernel.org/all/20230804190750.3367a044@xps-13/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
