Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE27BB30A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjJFIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjJFIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:24:56 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 206C5FA;
        Fri,  6 Oct 2023 01:24:54 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qog8g-0002lP-00; Fri, 06 Oct 2023 10:24:50 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 64F71C0243; Fri,  6 Oct 2023 10:22:27 +0200 (CEST)
Date:   Fri, 6 Oct 2023 10:22:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mips: dts: ralink: mt7621: rename to GnuBee GB-PC1 and
 GnuBee GB-PC2
Message-ID: <ZR/Dw5l3ljiJJbQy@alpha.franken.de>
References: <20230918075915.87029-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918075915.87029-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:59:15AM +0300, Arınç ÜNAL wrote:
> Rename GB-PC1 to GnuBee GB-PC1, and GB-PC2 to GnuBee GB-PC2 to include
> brand and model name.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts | 2 +-
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
> index 129b6710b699..f9c262cc2e96 100644
> --- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
> +++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	compatible = "gnubee,gb-pc1", "mediatek,mt7621-soc";
> -	model = "GB-PC1";
> +	model = "GnuBee GB-PC1";
>  
>  	memory@0 {
>  		device_type = "memory";
> diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
> index f810cd10f4f4..b281e13f22ed 100644
> --- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
> +++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	compatible = "gnubee,gb-pc2", "mediatek,mt7621-soc";
> -	model = "GB-PC2";
> +	model = "GnuBee GB-PC2";
>  
>  	memory@0 {
>  		device_type = "memory";
> -- 
> 2.39.2
> 

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
