Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0D76216E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGYSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGYSdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:33:06 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FE1FC2;
        Tue, 25 Jul 2023 11:33:03 -0700 (PDT)
Received: from [185.230.175.137] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qOMqD-0006Er-Pt; Tue, 25 Jul 2023 20:33:01 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rk3399: switch to enable-gpios
Date:   Tue, 25 Jul 2023 20:32:59 +0200
Message-Id: <169030979754.2939984.15402031320478531435.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725142616.157405-1-krzysztof.kozlowski@linaro.org>
References: <20230725142616.157405-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 16:26:15 +0200, Krzysztof Kozlowski wrote:
> The recommended name for enable GPIOs property in regulator-gpio is
> enable-gpios.  This is also required by bindings:
> 
>   rk3399-gru-bob.dtb: ppvar-sd-card-io: Unevaluated properties are not allowed ('enable-gpio' was unexpected)
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: rk3399: switch to enable-gpios
      commit: fcedb69be2700d5d07634bcdf06ca98e20a19677
[2/2] arm64: dts: rockchip: px30-engicam: switch to enable-gpios
      commit: a02913e886351f039b9d5346be7926c1b05a3eef

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
