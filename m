Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A5E79D595
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjILQB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjILQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:01:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638AC10EB;
        Tue, 12 Sep 2023 09:01:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD160C433C8;
        Tue, 12 Sep 2023 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694534509;
        bh=USLe8NO9mr/GvExbbP1aMe8bwl931+sbAYmKET7wefc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scopz8OU+QEHSAC4nvA63UOgVuFKCLGMJKSbuyIZKaog+6n0hdGJ/o/mbdFUtqsBL
         YdA2oYpldtopMwgq1IpxDRdscGI97h20sI/ArRlrHgB+nY8I8K7qrMdihlTLym020D
         jBJZPRY5ehjl+wtfEaFe0iUGq0KSuR7yUhrvWvo3JukM8in9ftShc3Lrm7ucVPaW4l
         34457EJ4DHZydSH5hnLdULJLg88aGXjnpHSbhodvhsV7owFVPHm9Dcjt+V92w6bqOC
         WTxKlXV2CnecZ0/iSn9x/NjlX++IGGYouQwacObznHhV/Cd4DmMqVTnbCdxr2aHR5h
         t5qDsJlr80hkg==
Received: (nullmailer pid 863711 invoked by uid 1000);
        Tue, 12 Sep 2023 16:01:44 -0000
Date:   Tue, 12 Sep 2023 11:01:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     sboyd@kernel.org, arnd@arndb.de, conor+dt@kernel.org,
        quic_bjorande@quicinc.com, jirislaby@kernel.org,
        linux-clk@vger.kernel.org, will@kernel.org,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        geert+renesas@glider.be, nfraprado@collabora.com,
        linux-mmc@vger.kernel.org, wsa+renesas@sang-engineering.com,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        magnus.damm@gmail.com, catalin.marinas@arm.com, rafal@milecki.pl,
        linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
        mturquette@baylibre.com, linux-serial@vger.kernel.org,
        konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 03/37] dt-bindings: soc: renesas: renesas,rzg2l-sysc:
 document RZ/G3S SoC
Message-ID: <169453450434.863656.1292142758934692586.robh@kernel.org>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-4-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045157.177966-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 07:51:23 +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Document RZ/G3S (R9A08G045) SYSC bindings. The SYSC block found on the
> RZ/G3S SoC is similar to one found on the RZ/G2UL.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  .../devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

