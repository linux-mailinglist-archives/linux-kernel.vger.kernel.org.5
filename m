Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB08030F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbjLDKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLDKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:52:28 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB40B9;
        Mon,  4 Dec 2023 02:52:33 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66B6C2000D;
        Mon,  4 Dec 2023 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701687152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGW0aYaSSgY7TbVn7mSy7EgFtx4MSa9KcaOfi7zh3LA=;
        b=iv8ooXpqwTm8wRYeLHrtRDLvjizLyoyApYNVhbJn9vWZSMP9gMM4ji/koDOEB4AWp7Hcfq
        Kvhe+28Bn2YS2xI8QgV9y5Q954Gw+wiSxRge4R1kVkkd1HfxqyyHdDoCXs5t7dRF4+YMma
        SEF8wBl66viXznFYmTc53TT+Hk63OqhWLn7Cg/t1EgCIk4C0+FgN0RJ/i/9+fuvxDzp7DI
        g+7zW1zQyZAzg82Ta4jymaQOPGyU6+VPPjfRhDwg7EpUwvaur+kPlIIoko47pBf5EO+CZh
        yurS+qGrc+x0Dkz5x8DsCpF0ICc0sAgaqmynU2hAHlyhgzIrk7wFVoiI9fcuHg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan <dregan@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] mtd: rawnand: Add deassert_wp comment
Date:   Mon,  4 Dec 2023 11:52:29 +0100
Message-Id: <20231204105229.870290-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201212446.189491-1-dregan@broadcom.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'578dc962ff2000ba4bf52d50717aea0819615634'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 21:24:46 UTC, dregan wrote:
> From: David Regan <dregan@broadcom.com>
> 
> Add deassert_wp description comment
> 
> Signed-off-by: David Regan <dregan@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
