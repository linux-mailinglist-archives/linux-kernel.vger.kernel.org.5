Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76BF7C9BEC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjJOV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:28:00 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D95A9;
        Sun, 15 Oct 2023 14:27:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F8A540004;
        Sun, 15 Oct 2023 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697405276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdMRx8br8SeWSRivCJNP8GFBf/hF1S6spfkm5EdDU+U=;
        b=GWtNwtwVZVGA37CYP/uWFREKzaVwEviAa/ScPlxutY4nGC89oMQH0x8GrpT8FM1Hu4hm26
        WGizviQ3Sfah3/Xte+7+oidkFbl78KVpieFrahbyllFoa6OYFwxLnDiVfu8VD6gznSfxVz
        KSxxmMxVTanTogBWcVLB4/krw+TfGxupsAMwhyyibB2cHMNRbYP2J8TgOxNj2IDuJZjwHV
        VCTbtdQiP6mJWP9hgpK/Xmh/bMaOC9DIarNmrKC6swUIJBmexIPpML9WKnPRBhm2y+76r8
        uIEMkhm5Kpj+cRSG/vjYHmRa9MMrcStCWgybRsEWXqHF7S0XXvxE3KaLVB1uow==
Date:   Sun, 15 Oct 2023 23:27:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier.carrasco@wolfvision.net, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] dt-bindings: rtc: pcf8523: Convert to YAML
Message-ID: <169740521773.186593.13753987148905752249.b4-ty@bootlin.com>
References: <20230905220826.79901-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905220826.79901-1-festevam@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Sep 2023 19:08:26 -0300, Fabio Estevam wrote:
> Convert the PCF8523 bindings from text format to YAML.
> 
> The YAML format is preferred as it allows validation.
> 
> 

Applied, thanks!

[1/1] dt-bindings: rtc: pcf8523: Convert to YAML
      commit: 539cbe1b81f44e13103795e41f2e000fdc170859

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
