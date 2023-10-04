Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2E7B8330
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbjJDPIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjJDPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:08:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72BAB;
        Wed,  4 Oct 2023 08:07:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45EBC433C8;
        Wed,  4 Oct 2023 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696432077;
        bh=Y5zy75t86c7p9cSZYuR4myWn71kdv7zk6WSRuY/yi70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ce1gg4PsElaaWDOjFq5MbANyHN9jnSvSgiKmKaHFY07okOGDOdCjtNz/9DIzcajIH
         tYz7u0j4NoFIncrNUumckrrLKO+Pjn9TqLigAv/u+KpqqYrc19FWWVCtq22GToN+Pb
         Y4cG8n6yuGik7UO0S2TKpW6kRS0Mn538qhzGuI4PPfizyz1NNNIz2YVxrHblKrELbo
         wJl/bGuodTO/oR7uTMrMS8hcSi6TKPoiu6WQ6MF0gVpZrAqLTZyBifLsCxxHhErOoz
         E4YtchTIzlm8kGDRBm+ga2HckD8C77GN8zHCOQMcrIv44N41MM9Z9CmbwxOyCnT8G9
         WRxu5mvH2O7Wg==
Received: (nullmailer pid 3140478 invoked by uid 1000);
        Wed, 04 Oct 2023 15:07:55 -0000
Date:   Wed, 4 Oct 2023 10:07:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add T-HEAD PWM controller
Message-ID: <169643207539.3140422.9692233405638400871.robh@kernel.org>
References: <20231004092731.1362-1-jszhang@kernel.org>
 <20231004092731.1362-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004092731.1362-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Oct 2023 17:27:30 +0800, Jisheng Zhang wrote:
> T-HEAD SoCs such as the TH1520 contain a PWM controller used
> to control the LCD backlight, fan and so on.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/pwm/thead,th1520-pwm.yaml        | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

