Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8B79D581
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjILQAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjILQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:00:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3610EA;
        Tue, 12 Sep 2023 09:00:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35662C433C8;
        Tue, 12 Sep 2023 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534450;
        bh=bxv0fBANA2mqdoQ6AccAVVP77okB+6dX9LpeEKV17mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7ylpWLwmuGHO5sqkzLEIUJ+5Mv4uZPzfayVn70exPBnqgG3SJTsQIr35EKUmF2iP
         J4xgwcHl2JlJ2kUkclfL8yrkZWq6hjWpr2FeVxTwW+LQaEz5eQLkCFbrvkk9mMdxT0
         nwnKDhHMn/XcpyWp9KeKQm2B20QEs6gh38q8T1jHIugt+Q5PtfHJWZ6tjBL5bp4xap
         eoY8pMwE32rJIJpM7a9RuSvfu1UcWxsvfunmPnGugx8T24PXwBrQ+VYoaFuXPJ7YjR
         QlalUI5H5nbkGecgJ95+Fe5omjkKxIJHFkq+7VLn3O9XjYy4RCae5j0nXfnil9ylE8
         rjkTLiSs75pDA==
Received: (nullmailer pid 862469 invoked by uid 1000);
        Tue, 12 Sep 2023 16:00:46 -0000
Date:   Tue, 12 Sep 2023 11:00:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com,
        nfraprado@collabora.com, linux-clk@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        neil.armstrong@linaro.org, rafal@milecki.pl, sboyd@kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, arnd@arndb.de,
        wsa+renesas@sang-engineering.com, konrad.dybcio@linaro.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        linux-gpio@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-serial@vger.kernel.org, catalin.marinas@arm.com,
        conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        jirislaby@kernel.org
Subject: Re: [PATCH 01/37] dt-bindings: serial: renesas,scif: document
 r9a08g045 support
Message-ID: <169453444566.862414.5516209615917856191.robh@kernel.org>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-2-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045157.177966-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 07:51:21 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/G3S (R9A08G045) SoC. SCIF interface in
> Renesas RZ/G3S is similar to the one available in RZ/G2L.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

