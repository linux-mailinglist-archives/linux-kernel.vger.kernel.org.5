Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406607C605F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbjJKWhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJKWhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:37:05 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C733398;
        Wed, 11 Oct 2023 15:37:01 -0700 (PDT)
Received: from i53875b94.versanet.de ([83.135.91.148] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qqhov-0005Ma-F3; Thu, 12 Oct 2023 00:36:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org,
        =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Remove duplicate regulator vcc3v3_wf from rock-5b
Date:   Thu, 12 Oct 2023 00:36:46 +0200
Message-Id: <169706370545.498990.15528130446226264985.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011181757.58047-1-tszucs@protonmail.ch>
References: <20231011181757.58047-1-tszucs@protonmail.ch>
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

On Wed, 11 Oct 2023 18:18:05 +0000, Tamás Szűcs wrote:
> Regulator for VCC3V3_WF has been added as vcc3v3_pcie2x1l0 first. Clean this up.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Remove duplicate regulator vcc3v3_wf from rock-5b
      commit: 0002c377e862140ad65b67b8b9dbf086d4578f95

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
