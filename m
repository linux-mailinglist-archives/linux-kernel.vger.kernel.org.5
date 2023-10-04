Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E47B814F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbjJDNsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242657AbjJDNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:48:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64351E5;
        Wed,  4 Oct 2023 06:48:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D795C433C9;
        Wed,  4 Oct 2023 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696427299;
        bh=RUJjmiMMWjZtXTFzdT9tp6cJ3CJdB+HdueoIl8WZhxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUuzD63iuA5lAHtweqik8IcWR5KMJN/01sZ2ngWDFRwR0RLFrxP+HypZ38LtWcmho
         SwHQ6mEcQ4yIMphU2O8ZNTB4t2f7LWB0ffXVzYqopP+59V/CAAGG9RKjIKWSlXhQGx
         P8NmZC3tLKlzxcdYzFay1/va/PzvL4NFhVoLbH8a5SbIdI9azBTdVQdmVCEcImTuBe
         oIWAiuDLrjPmYpXNwrXwO0mBbitHd6m/2oIS7EClTi1/3p0T/yM0OYUWjQOuGu6RNa
         M3XjHstu0HLZMXEnPbUWsGIfOBoQSgkVtfKkHgGW85Z4vG8Eo6DcdoQXLjpN1HUWtu
         s+XH5flGlGuNw==
Received: (nullmailer pid 2777363 invoked by uid 1000);
        Wed, 04 Oct 2023 13:48:17 -0000
Date:   Wed, 4 Oct 2023 08:48:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: document Ebisu-4D support
Message-ID: <169642729623.2777302.15535104828742110554.robh@kernel.org>
References: <20231002165957.11388-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002165957.11388-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 02 Oct 2023 18:59:57 +0200, Wolfram Sang wrote:
> Document properly that Ebisu-support includes the Ebisu-4D variant, so
> there won't be confusion what happened with support for this board.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 2 +-
>  arch/arm64/boot/dts/renesas/ebisu.dtsi                     | 2 +-
>  arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

