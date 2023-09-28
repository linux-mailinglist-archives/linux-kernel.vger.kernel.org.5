Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA57B1F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjI1ODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjI1ODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:03:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E311F;
        Thu, 28 Sep 2023 07:03:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974D9C433C8;
        Thu, 28 Sep 2023 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695909809;
        bh=n2bDHzk2s5pAtaibWAwFVOIL4i6SiOY2rnYokEWoql0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D95uGPuTGA8Y7UqNsKhGsRlqlnJe4RWQUvfGWgj2Oiqdg81cL0lj4N5/qOxosGS35
         SvP2gCSX24agKDhZXJrfpkPsSjTQmB40EVJ4EVkP7NkUQsY4BPgIe3wQjm040jlvH9
         7KSxZJJNEynr3A/CTsxG65POGEpaTUUPDoCUTNEwR/NYAWcWz7PjargFlC8bomS/07
         QOmyZenXmNiowWfEP9W+UYLNLxGwU9ypIFHxP+chWW/UB+hylroPiHW6hC4VGjCd+g
         vDRDnfukLR8pou+/HDi5fcl4NxQ441P417cyMETI6OtkQUj2dlOT1x39xCMx0u9ATA
         5rE7iH3hJopKg==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
In-Reply-To: <20230925122609.78849-1-f.suligoi@asem.it>
References: <20230925122609.78849-1-f.suligoi@asem.it>
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: backlight: Add MPS
 MP3309C
Message-Id: <169590980634.1618521.3566617275020298182.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 15:03:26 +0100
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

On Mon, 25 Sep 2023 14:26:08 +0200, Flavio Suligoi wrote:
> The Monolithic Power (MPS) MP3309C is a WLED step-up converter, featuring a
> programmable switching frequency to optimize efficiency.
> The brightness can be controlled either by I2C commands (called "analog"
> mode) or by a PWM input signal (PWM mode).
> This driver supports both modes.
> 
> For device driver details, please refer to:
> - drivers/video/backlight/mp3309c_bl.c
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: backlight: Add MPS MP3309C
      commit: 02c4e661658f73d3c266c68f89f0b14bd8ba6bd8

--
Lee Jones [李琼斯]

