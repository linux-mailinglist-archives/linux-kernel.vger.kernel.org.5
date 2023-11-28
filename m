Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7E7FB813
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjK1KiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjK1Khj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:37:39 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDD92D62;
        Tue, 28 Nov 2023 02:36:16 -0800 (PST)
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r7vRr-0003E0-50; Tue, 28 Nov 2023 11:36:11 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64: dts: rockchip: add USB3 host to rock-5b
Date:   Tue, 28 Nov 2023 11:36:09 +0100
Message-Id: <170116776016.2189213.11963461092677000892.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106155934.80838-1-sebastian.reichel@collabora.com>
References: <20231106155934.80838-1-sebastian.reichel@collabora.com>
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

On Mon, 6 Nov 2023 16:54:31 +0100, Sebastian Reichel wrote:
> Enable USB3 host controller for the Radxa ROCK 5 Model B. This adds
> USB3 for the upper USB3 port (the one further away from the PCB).
> 
> The lower USB3 and the USB-C ports use the RK3588 USB TypeC host
> controller, which use a different PHY without upstream support.
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: add USB3 host to rock-5b
      commit: 3585766438c4c24dcc6cc93e26e9eccccce50a13
[2/2] arm64: dts: rockchip: add USB3 host to rock-5a
      commit: bbda1bf9586f0f0745ab1097df6975a9354a03ff

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
