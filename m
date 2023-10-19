Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B07CFC05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbjJSOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbjJSOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:05:54 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4151130;
        Thu, 19 Oct 2023 07:05:49 -0700 (PDT)
Received: from i5e861907.versanet.de ([94.134.25.7] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qtTef-0004bU-GJ; Thu, 19 Oct 2023 16:05:41 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de, Vincent Legoll <vincent.legoll@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Chanwoo Choi <chanwoo@kernel.org>, devicetree@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: (subset) [PATCH v8 00/26] Add perf support to the rockchip-dfi driver
Date:   Thu, 19 Oct 2023 16:05:39 +0200
Message-Id: <169772432936.1425163.10520107144640249546.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018061714.3553817-1-s.hauer@pengutronix.de>
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
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

On Wed, 18 Oct 2023 08:16:48 +0200, Sascha Hauer wrote:
> This series integrates the recent review feedback from Chanwoo Choi to
> v7.
> 
> Chanwoo, I am sending the full patchset again for people to try this
> series. You said that you applied 1-5 already, so please start picking
> from 6/26.
> 
> [...]

Applied, thanks!

[24/26] arm64: dts: rockchip: rk3399: Enable DFI
        commit: f57ef11ec63c17201b27569fbfb58801c227137d
[25/26] arm64: dts: rockchip: rk356x: Add DFI
        commit: 085be8875ca8a087e3cc102893f384894962c87e
[26/26] arm64: dts: rockchip: rk3588s: Add DFI
        commit: 5a6976b1040a2f99ab84eddbfa7cd072ac5d10fc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
