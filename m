Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EB179D58D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjILQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbjILQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:01:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD110DE;
        Tue, 12 Sep 2023 09:01:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B11DC433C8;
        Tue, 12 Sep 2023 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534491;
        bh=UxMKoPMSW2LIYOuWg8hodpOwfZ9OUS9s0x6HB2uaZqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwsHUy+lEd8lPdudwzTYY3OnlL237gTsKF7vuP0yilmf4SWxrb30nlp/OQPdjPvAu
         H/N0Ct+Flrv6wIDEzXfwIS6pvMQ9w/AweYVJGfxFrOC1pC04gRdpvtCbrUf0v4VcpT
         3ldJWPrA5oV0Tc50C4byL3nlQ+agFIVlyltHxp/CLp2chULQdrPFv7+DCeXJEGey7I
         3a/GE6H/MBAMEDXnvtdclnqRb5aZwng16lZGDSgQp00/xmEbpIYbjlnHCJA22nhM9o
         AwvKsNIv7rVEIFmQoLrcp1GQCHCLWs6cqHncvJ/KeT78MY3a7VBLSUXBqr0TRgNRdz
         fV4hrkpcqAS/g==
Received: (nullmailer pid 863337 invoked by uid 1000);
        Tue, 12 Sep 2023 16:01:27 -0000
Date:   Tue, 12 Sep 2023 11:01:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, biju.das.jz@bp.renesas.com,
        mturquette@baylibre.com, will@kernel.org,
        neil.armstrong@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, quic_bjorande@quicinc.com,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        arnd@arndb.de, linux-gpio@vger.kernel.org, magnus.damm@gmail.com,
        conor+dt@kernel.org, ulf.hansson@linaro.org, rafal@milecki.pl,
        nfraprado@collabora.com, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, sboyd@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH 02/37] dt-bindings: soc: renesas: document Renesas RZ/G3S
 SoC variants
Message-ID: <169453447177.862969.9970481946230019779.robh@kernel.org>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-3-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045157.177966-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 07:51:22 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Document RZ/G3S (R9A08G045) SoC variants.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

