Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7219F751AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjGMIBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjGMIAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:00:40 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35E272C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:59:34 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A76CE40012;
        Thu, 13 Jul 2023 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v46T/BXZeGNZxgZP5hKS5TeDg3icWstv/h6ECEftRxs=;
        b=VM+MAlmzxfKag5UwLRraD1Bnxh0o3dqq1fLdQMCxtIJgwuAd+rrUJT4RkuoynpiT+sYDVP
        jcLdBxqpl9yiivsqRNIww4Sdi/SXG5Rkt3tMyzVb3nYEBEj6UJYdR3RFgOB1aJ/pMpTj/N
        7YsBVt8ZPyUmFCRZ6Tuy5PWNx5H3Wft3wxLRaHQNfz1MX4k9lCnVleBcOishCf23EQViCW
        Zv5nic8hp68ln9BlEo0dTAWiIi7EWhZXPDdDZ/IGMeOQMbQE6iXPs3URkmadDl2soQ46lz
        nmAsbZOKuZTfTi0D3RnWJQDaH7R70gXeVvAWyHzYYdw49ISwXClrC6+HEdSlMQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sridharan S N <quic_sridsn@quicinc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, ddrokosov@sberdevices.ru,
        gch981213@gmail.com, mmkurbanov@sberdevices.ru,
        quic_mdalam@quicinc.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mtd: spinand: add support for ESMT F50D2G41KA
Date:   Thu, 13 Jul 2023 09:59:25 +0200
Message-Id: <20230713075925.486851-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623045757.30055-3-quic_sridsn@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'aa08bf187f322b6e38810d93896d052ea7cd6758'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-23 at 04:57:56 UTC, Sridharan S N wrote:
> This adds support for ESMT F50D2G41KA. This is 2Gb SLC NAND flash
> with 8b/512b on-die ECC capability.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
