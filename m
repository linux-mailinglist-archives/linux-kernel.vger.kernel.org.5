Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0027FB710
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjK1KXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjK1KXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:23:30 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AD512C;
        Tue, 28 Nov 2023 02:23:35 -0800 (PST)
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r7vFd-00030f-06; Tue, 28 Nov 2023 11:23:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Trevor Woerner <twoerner@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: rockchip: dts: rk3308-rock-pi-s add gpio-line-names
Date:   Tue, 28 Nov 2023 11:23:31 +0100
Message-Id: <170116700275.2183789.12263120893522806404.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120162232.27653-1-twoerner@gmail.com>
References: <20231120162232.27653-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 11:22:32 -0500, Trevor Woerner wrote:
> Add names to the pins of the general-purpose expansion header as given in the
> Radxa GPIO page[1] following the conventions in the kernel documentation[2] to
> make it easier for users to correlate the pins with functions when using
> utilities such as gpioinfo.
> 
> [1] https://wiki.radxa.com/RockpiS/hardware/gpio
> [2] Documentation/devicetree/bindings/gpio/gpio.txt
> 
> [...]

Applied, thanks!

[1/1] arm64: rockchip: dts: rk3308-rock-pi-s add gpio-line-names
      commit: 6204c84c196889c54ce5c4d44d69472c93e56c39

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
