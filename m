Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0EA7761D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjHIN5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:57:47 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743A798;
        Wed,  9 Aug 2023 06:57:44 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qTjgv-0007Qm-02; Wed, 09 Aug 2023 15:57:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Thomas McKahan <tmckahan@singleboardsolutions.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v2 0/2] Add Support for the FriendlyElec NanoPC T6
Date:   Wed,  9 Aug 2023 15:57:34 +0200
Message-Id: <169158939223.3288791.10539753296615964681.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809112120.99-1-tmckahan@singleboardsolutions.com>
References: <20230809112120.99-1-tmckahan@singleboardsolutions.com>
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

On Wed, 9 Aug 2023 07:21:15 -0400, Thomas McKahan wrote:
> This adds support for the RK3588-based NanoPC T6 single board computer.
> Note this series is dependent on the PCIe 3 support [0] being
> upstreamed. The NanoPC T6 uses PCIe3x4 like the Rock 5B and EVB1.
> 
> [0] https://lore.kernel.org/all/20230717173512.65169-1-sebastian.reichel@collabora.com/
> 
> v2:
>  - remove unnecessary "okay" status from sound
>  - add '-regulator' suffix on 2 regulators that were missing them
>  - use generic node name for rtc
>  - remove extra lines
>  - fix alignment in I2S entry
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add NanoPC T6
      commit: 99c81c127408e6b2e4725303fc2e0a09616877ce
[2/2] arm64: dts: rockchip: Add NanoPC T6
      commit: 893c17716d0cf68f5ff4dc71c90e0c2bd1f7da46

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
