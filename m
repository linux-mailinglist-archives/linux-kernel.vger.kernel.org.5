Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D37CAC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjJPO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjJPOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:55:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F90AB;
        Mon, 16 Oct 2023 07:55:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14FD81C000A;
        Mon, 16 Oct 2023 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697468147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4UCdwwM/vYHFGtnjXt/BfQr8+RHOz42nLlox8hDx7I=;
        b=Jn+t4ambL8klBhufvO/6Mt4eVlnDDEzL3Wexe0PvgBhcWVFCcJRo1Qoyq07k0Jp1gZvSm0
        FQevd84bliIV7mLtzCd4rZhpjapU9C/NA/Zj9Nqx7dSO4N18PwEdUWOMNkg4w64sQ9KGGe
        fEh3G4Ay9qV5YpeJeEtvGRJCJesGoMJw6mEBHGwrr5hMs35d1f+5jb58Kws5+3nxoTBm5b
        b8chmLbqj6wmQXUnU14+OHr0RABsVKRCsDe8bR67wcpWgs9KvuaNN94rSCV0zid36j7M3c
        PbYXy1E8Tnwke+YcaOfybZxZIa9h0yUvGAF9IaGcde7wNaGVCbCpuuCTRoHx/w==
Date:   Mon, 16 Oct 2023 16:55:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add RTC for MStar SSD20xD SoCs
Message-ID: <169746807623.26616.11393539981836060067.b4-ty@bootlin.com>
References: <20230913151606.69494-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151606.69494-1-romain.perier@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 17:16:03 +0200, Romain Perier wrote:
> This patches series adds a new driver for the RTC found in the Mstar
> SSD202D SoCs. It adds a basic rtc driver, the corresponding devicetree
> bindings.
> 
> The rtctest (from selftests) has been passed on this driver, with the
> following output:
> 
> [...]

Applied, thanks!

[1/3] rtc: Add support for the SSD202D RTC
      commit: ebf6255868e6141c737cacb8d62b0b347f344877
[2/3] dt-bindings: rtc: Add Mstar SSD202D RTC
      commit: cfb67623ce281e045ec11e3eddb1b68b879b53a1

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
