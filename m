Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E6775746
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjHIKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHIKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:44:09 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC7F10F3;
        Wed,  9 Aug 2023 03:44:06 -0700 (PDT)
Received: from i53875a28.versanet.de ([83.135.90.40] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qTgfP-0006VP-GY; Wed, 09 Aug 2023 12:43:51 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Thomas McKahan <tmckahan@singleboardsolutions.com>
Cc:     Thomas McKahan <tmckahan@singleboardsolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Support for the FriendlyElec NanoPC T6
Date:   Wed, 09 Aug 2023 12:43:50 +0200
Message-ID: <12777866.O9o76ZdvQC@diego>
In-Reply-To: <20230809054213.27447-1-tmckahan@singleboardsolutions.com>
References: <20230809054213.27447-1-tmckahan@singleboardsolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Am Mittwoch, 9. August 2023, 07:42:08 CEST schrieb Thomas McKahan:
> Hello,
> 
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
> v1: https://lore.kernel.org/all/20230802051441.3106-1-tmckahan@singleboardsolutions.com/
> 
> Thomas McKahan (2):
>   dt-bindings: arm: rockchip: Add NanoPC T6
>   arm64: dts: rockchip: Add NanoPC T6

somehow the actual patches are missing from this submission?

I also checked the linux-rockchip archive, and they're missing
there too.

I guess you'll need to resend or check where they took the wrong exit.


Heiko


