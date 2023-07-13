Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA4F751A87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjGMH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjGMH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283BC26A5;
        Thu, 13 Jul 2023 00:57:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56988E0004;
        Thu, 13 Jul 2023 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzsWKu93YUuwDnnOYLybugWHj+sLe8pGA0PY2y1AfTY=;
        b=RpuvX0wATqkGz3AN4v96SEsjo5sXZy/JmAWgdT7IrbPqC7Y1i2HOFQqFujeTrrcWhnguRi
        X5m0qZ5TBmbMqoEUKFehAOacSzmoJdF3MADTC/cNEHKE+5dpoIRsQiJgAYC0haIEDklmin
        rL4x7sC4PHdeHk+l56BO2hrm5g4pfCKIzG21xYdaSSNGx3aQjL1OLSXs6CRo7cPdg5w23v
        xMu2IwB5R81/XJisyaglpUpgxF0rKRaErUd7hwNfMp1G05VCpW6lCgz38mTw2xaybyqZIu
        TaY2iZygJ6DSdcQ8g9dbburtjRJz6kCxYqXpwYOQdItfFjnFE8E035mKvC4cpw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: Add AC5 specific binding
Date:   Thu, 13 Jul 2023 09:57:39 +0200
Message-Id: <20230713075739.485988-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703035044.2063303-2-chris.packham@alliedtelesis.co.nz>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4729fa4304c3e5191cb407885abfc9ec55a1429b'
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

On Mon, 2023-07-03 at 03:50:42 UTC, Chris Packham wrote:
> Add binding for AC5 SoC. This SoC only supports NAND SDR timings up to
> mode 3 so a specific compatible value is needed.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
