Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB57526AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjGMPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjGMPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE08C1B6;
        Thu, 13 Jul 2023 08:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A6AE618D9;
        Thu, 13 Jul 2023 15:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E691C433C7;
        Thu, 13 Jul 2023 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689261764;
        bh=YAmnTTFm0GwWsSdAoWWcGBrMe5QH0j2yUGMWo2AP1ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6iZOcYllQn0u0nW3hCage2h+NFDoOc3yL8/esZc84q3GLp6t1X4cohT/l5X9qPxD
         tm3n2pt/FFF0TfU6PF1wfdzKAqNzt6mtsk90LirEgDsCWALvOFa95CPy5n+O4zRnmX
         TrQ6gvqYFf65AR0D+8zPOwVmWqP2Iv7TSyAGbv4JYSPB//N8NJ/K0lWHkGFTGNFcbM
         +GJE5vNL91mqX/e5TFG1WxHd4sF6yezkiGke0d/YikP9eWL8LouSCDMZokeSFL2auM
         AxJ980mx4MngEYjtgEolUWvbHLWpBgbZwMCv+ZQIDET73NEx2Tv7cGBCRvI9b6QDhn
         xoSm+zL3SEuig==
Date:   Thu, 13 Jul 2023 16:22:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Manikandan Muralidharan <manikandan.m@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH v2 1/9] dt-bindings: mfd: Add bindings for SAM9X75 LCD
 controller
Message-ID: <20230713152236.GB968624@google.com>
References: <20230712024017.218921-1-manikandan.m@microchip.com>
 <20230712024017.218921-2-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712024017.218921-2-manikandan.m@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023, Manikandan Muralidharan wrote:

> Add new compatible string for the XLCD controller on sam9x75 variant
> of the SAM9X7 SoC family.
> The XLCD controller in sam9x75 variant supports interfacing with
> LVDS and MIPI-DSI and parallel port RGB.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
