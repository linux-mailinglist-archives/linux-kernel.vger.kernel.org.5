Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916AD75465F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGOCqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGOCqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9F35A8;
        Fri, 14 Jul 2023 19:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464F460D2E;
        Sat, 15 Jul 2023 02:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B7CC433C7;
        Sat, 15 Jul 2023 02:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689389191;
        bh=WEI50rVQcSyh8VTyQvz5tg1wDaK8mnXylHqXNjlACkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSccMJNXEClgwpQQkkZZYv0soP9Zy2CDz6QPH7Ib4lY1ThDYZ863XARn+rSfN7FSg
         TTKHT0a2vH7GHI/zdKAg2+bUemyCM0lcCs0MaYooqPPryTRwOdO1Eu9sR9qoncYr7M
         BpHyECIiayUosfVnDnlDJZC+eR1hH67UjmgWXqI4spQOr0uiTBfKcwojr7O/KwvzYS
         Xa8hf8EqVYiKB1EZCWMGsN406NS+ZX44Kqkdq/1ZT+mWhsDqrU5AlTB4ymaOmNtcg7
         rX8RQtuc7H3KHtJJPN0qWJLNJ8PUiHvHSC79+IAj8exckeGX01y+YZpdMfxB/enyrO
         54dADmjX3NwsQ==
Received: (nullmailer pid 874840 invoked by uid 1000);
        Sat, 15 Jul 2023 02:46:29 -0000
Date:   Fri, 14 Jul 2023 20:46:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Message-ID: <20230715024629.GA872287-robh@kernel.org>
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
 <CGME20230714101434epcas2p1e0788544f244e59861f45b10e450075c@epcas2p1.samsung.com>
 <20230714100929.94563-2-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714100929.94563-2-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jul 2023 19:09:27 +0900, Jaewon Kim wrote:
> Add samsung,exynosautov9-pwm compatible string to binding document.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

