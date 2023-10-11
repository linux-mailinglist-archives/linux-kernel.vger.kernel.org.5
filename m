Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CED7C6060
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbjJKWhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjJKWhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:37:05 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D6A4;
        Wed, 11 Oct 2023 15:37:03 -0700 (PDT)
Received: from i53875b94.versanet.de ([83.135.91.148] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qqhou-0005Ma-RZ; Thu, 12 Oct 2023 00:36:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-arm-kernel@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/2] Add support for Pine64 QuartzPro64
Date:   Thu, 12 Oct 2023 00:36:45 +0200
Message-Id: <169706370544.498990.15767954270891425478.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011215856.2082241-1-megi@xff.cz>
References: <20231011215856.2082241-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 23:58:43 +0200, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> This series adds an initial support for Pine64 QuartzPro64 SBC.
> 
> The series was tested against Linux 6.6-rc4.
> 
> Please take a look.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Pine64 QuarzPro64
      commit: a6fa0d4a704d7af51a5d02f76c73046cf957c1b5
[2/2] arm64: dts: rk3588-quartzpro64: Add QuartzPro64 SBC device tree
      commit: 8152d3d070a9ca4f48020d11925718f1707db4f1

Thanks a lot for following along my changes.

While I did plan on doing the same for the original QuartzPro64
series, I hadn't found the time yet and this makes everything
so much easier :-) .


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
