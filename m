Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07E17A77AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjITJgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjITJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:36:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BF983;
        Wed, 20 Sep 2023 02:36:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C12C433C7;
        Wed, 20 Sep 2023 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695202604;
        bh=QvrfuDunGeVeEzTT0m7V7qM30d5sUcAJp/nuSRoA/Kw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QdA1dIKg00oVg/Tj4DG0pqitCVasDs/Wfzz1pmVVUrFxCqOFNFq+rrzIkZnS4JT4w
         abqTNCAEkvI3Fmv0kF4DI3Qvh5Qbk/TZBx2spbFLJ1EANyqTsg4//fkpwtCVed1V+S
         eWKWmdU98GAMfD8baYyoe7RMo5Q5oPdaIL8fXrI5FXZWeVuTVa4KJC1jvrrWjROGF4
         3p8qz7ZVv0Ru6+0F7F/3bnxtEGw7avECx9YrNwNEhcVWav0ubrGOJAT0i9boUZTCkG
         m7ynqHyfLU6eBbPJMIj+S45/BYpZhRhW/ksj8/qq0iHH9IIHsN1DG+imqr2y1WjNTB
         PLnMvIH0FWn/w==
From:   Lee Jones <lee@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20230829171647.187787-2-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
 <20230829171647.187787-2-knaerzche@gmail.com>
Subject: Re: (subset) [PATCH 01/31] dt-bindings: mfd: syscon: Add
 rockchip,rk3128-qos compatible
Message-Id: <169520259990.3354839.11054139849766032688.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 10:36:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 19:16:17 +0200, Alex Bee wrote:
> Document Rockchip RK3128 SoC compatible for qos registers.
> 
> 

Applied, thanks!

[01/31] dt-bindings: mfd: syscon: Add rockchip,rk3128-qos compatible
        commit: 4c57b25b09932acf81ead78bd32019fc5d0ea913

--
Lee Jones [李琼斯]

