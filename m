Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573F67A7CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjITMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjITMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:05:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B0A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:05:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E570C433C9;
        Wed, 20 Sep 2023 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211541;
        bh=SVjZrp8GMvacQryLgLqV5iIILxg3tgUYy/85oR1BDMA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Hj8bQdfcJPwjPJKUHJIrD/0xAHWpeD1vUEyyc+KnEGasnQ9sUDJqCcuu9RJj3/waY
         YWhyHtwVOHUGUn400nP0EqUnR4b3ZVaQw+9ZT/d2JASvfCAxhX2rH1N6s207EQ94wz
         5vRTv+vBPDvUgldLTwUDAnAuZi4XWtuPiFyrtHt0UNKEeI35imSf7TTa8AeShUNxgb
         0nccPDlvet3Js6EkSESLkJtPOpC59hz11WiTe8IAE8U9sA9v4jZkpdtcxAQObRdtvM
         GQ697eQYDXrlorGoIFhjuQP8DjcPK5AkafFDqoHEVBgREKoEKlRRzJE4fSzQIAKLKx
         iinBGcuhHvi1w==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20230911120135.37528-1-krzysztof.kozlowski@linaro.org>
References: <20230911120135.37528-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH RESEND] dt-bindings: mfd: maxim,max8998:
 Convert to DT schema
Message-Id: <169521153989.3405714.14729013886378279472.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 13:05:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 14:01:35 +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for Maxim MAX8998, National/TI LP3974 Power
> Management IC to DT schema.  Adjust example to real DTS and make second
> interrupt optional (like on s5pv210-aries.dtsi).
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: maxim,max8998: Convert to DT schema
      commit: f62fbc01e78ff3f055092b22dc62dcedff90879e

--
Lee Jones [李琼斯]

