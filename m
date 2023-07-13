Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5236C751ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjGMIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjGMH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:03 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7FA26A8;
        Thu, 13 Jul 2023 00:57:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 592F440003;
        Thu, 13 Jul 2023 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWvSrNQunJ8ljMyTw5kxdvMC1BOQXWHCrsc3G1hJsBo=;
        b=JbaSEYRUVfWqRnpwE/jRxxG2KLFHKBdC8YfqQtMFvmelVCGOazhplWIOtHok+NGIbu9ar3
        +iLUgAz2RaM8eO16BNZ18tR0zS6XhjE6PmFmHF/BeZmsIw7O7ghm0IzaEz0pu6AQxyIAY/
        ZJ0TkE4/JT/S69hirpbbWImb2P2P0aXVQWjwhp7s1n6dtW1g5YpgwubS06DHN2XWkltlnu
        /+H+AieYTLYcE+nuoaByzVshnbiZxW1OZMbI+8GVNKteCyS0p4+ubmVOZMfd8b7B0iTbOP
        +1sTKaQaIQXWxbAOkfFLsHNAbkgUR0BtjgTRjROr8GoEQPC7XAG/xV+1JkYyAw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, mani@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com
Subject: Re: [PATCH v5 2/2] mtd: rawnand: qcom: Remove legacy interface
Date:   Thu, 13 Jul 2023 09:57:43 +0200
Message-Id: <20230713075743.486017-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710054440.23297-2-quic_mdalam@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'30e6a7c17d40e76ab4c4ef86e0e47b823a15ee17'
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

On Mon, 2023-07-10 at 05:44:40 UTC, Md Sadre Alam wrote:
> Remove legacy interface implementation
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
