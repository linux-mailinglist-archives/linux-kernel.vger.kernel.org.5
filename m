Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ECE768BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGaGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGaGQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:16:21 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 627F61724;
        Sun, 30 Jul 2023 23:16:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 56DC9809E;
        Mon, 31 Jul 2023 06:15:54 +0000 (UTC)
Date:   Mon, 31 Jul 2023 09:15:53 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: ti: add missing space before {
Message-ID: <20230731061553.GF5194@atomide.com>
References: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
 <20230711135044.5m3juyupjuha5up5@handwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711135044.5m3juyupjuha5up5@handwork>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230711 16:50]:
> On 16:57-20230705, Krzysztof Kozlowski wrote:
> > Add missing whitespace between node name/label and opening {.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts | 2 +-
> >  arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi | 2 +-
> >  arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts    | 8 ++++----
> 
> Tony: Could you pick this up?
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>

Thanks applying into omap-for-v6.6/dt.

Regards,

Tony
