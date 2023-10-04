Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4477B9683
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbjJDVdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjJDVc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:32:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D160DC1;
        Wed,  4 Oct 2023 14:32:54 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qo9UB-0005RF-Vw; Wed, 04 Oct 2023 23:32:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Bee <knaerzche@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/6] Device tree fixes for RK3128
Date:   Wed,  4 Oct 2023 23:32:44 +0200
Message-Id: <169645508393.141514.14390917103512726577.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829203721.281455-4-knaerzche@gmail.com>
References: <20230829203721.281455-4-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 22:37:19 +0200, Alex Bee wrote:
> This series contains several device tree fixes which currently prevent
> the hardware from actually working.
> Please see commit messages of the individual patches for details.
> 
> These patches have been part of the pretty huge RK3128 fix-up series [0]
> which I've splitted up now, as suggested.
> 
> [...]

Applied, thanks!

[1/5] ARM: dts: rockchip: Fix i2c0 register address for RK3128
      commit: 2e9cbc4167da3134412ce47e4cdadbfdea30bbff
[2/5] ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
      commit: 7e3be9ea299927e6d65242c247eca0a21bc26a58
[3/5] ARM: dts: rockchip: Add missing quirk for RK3128's dma engine
      commit: b0b4e978784943c4ed8412dbb475178f8c51ba8e
[4/5] ARM: dts: rockchip: Fix timer clocks for RK3128
      commit: 2c68d26f072b449bd45427241612cb3f8f997f82

As Robin mentioned, DT describes hardware not Linux's
specificalities, so I ignored patch6.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
