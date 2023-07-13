Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0302751AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjGMIBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjGMIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:00:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8A2D41
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:59:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DDBA20008;
        Thu, 13 Jul 2023 07:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GQ9csKcB6A9a2ezYkOqBmEGVpBq6Q7Z6rQ+Q1GoYuc=;
        b=JfOl9Iyi+L0P1JpDkgZz9CSkvjGoxswlv/6l6AdDTe+V3ETGy7/7MeXqoBM1VRDf5DocNV
        eXL2L30Bul98eedSHNp1wR2aCfm3UvB+39mMoci/BO8Vu+rX1XEelsH5fKArly3b4vAoCy
        bGmdhB/wz+l9r6E8qUBG7ht3H/+h4PGQVu5duLaIc9WZodvaskvXGcujXujDtlwvJKRgWz
        LJOPgkvG/kOubcarSxBflMjU+UnTWl+rC0GQjDG/f5FzySh70jR762n5sCkXs6dIqN5XSt
        t3fcG+YRSFYGZLr2RSS0bInFBcooR0DyaUNLxrzpzS7xo1x9H8YGuzgd1XGXtw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sridharan S N <quic_sridsn@quicinc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, ddrokosov@sberdevices.ru,
        gch981213@gmail.com, mmkurbanov@sberdevices.ru,
        quic_mdalam@quicinc.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: spinand: gigadevice: add support for GD5F1GQ{4,5}RExxH
Date:   Thu, 13 Jul 2023 09:59:28 +0200
Message-Id: <20230713075928.486879-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623045757.30055-2-quic_sridsn@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'746b0f2675de6cc2197a9363873de7274c539d84'
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

On Fri, 2023-06-23 at 04:57:55 UTC, Sridharan S N wrote:
> Add support for:
> 	GD5F1GQ5RExxH
> 	GD5F1GQ4RExxH
> 
> Both are 1Gb SLC NAND flash with 4b/512b on-die ECC capability and has
> 2K + 64B PageSize.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
