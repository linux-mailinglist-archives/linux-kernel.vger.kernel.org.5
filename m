Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4346E7BFD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjJJN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjJJN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:29:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4867B0;
        Tue, 10 Oct 2023 06:29:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B583C433C7;
        Tue, 10 Oct 2023 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696944563;
        bh=oXg4rj2otetPYJ6T13k9X1CS147vwxf2ulCrsyT4wYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQfwUGGXsKAEQTAHxbbnFIMA0eEFZGWH2ZkJIPF00NVyZDOsOF27XQupUQ6REiZR+
         j40UD9mKvDUoJfT71MOEo7xxaBP5vD8ZE919w51mJ+rFojER4RmezHU2bzhiwYcmhE
         uAjQUo70Xxjq3/AIu1LgBfDuHSZ3UXA6gb2F7ytrBmA1e+Gl6NwCs0FaYmbVje2c1I
         LJlsN0Gs7sk8OIuqDOhd0BiFpe2gewP4nwANE+ZzVK5i0u+GWqysREW2rcazj3WlV4
         1SIQTfBGPFHoW7VjsaRyme2nRpzfxZ7HoSLxuo4XXZpnFPzM3J4lRJIeJ76PdR+DLw
         PkmIEzkwP5ABA==
Received: (nullmailer pid 631157 invoked by uid 1000);
        Tue, 10 Oct 2023 13:29:21 -0000
Date:   Tue, 10 Oct 2023 08:29:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nik Bune <n2h9z4@gmail.com>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        skhan@linuxfoundation.org, claudiu.beznea@microchip.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert
 txt to yaml
Message-ID: <20231010132921.GA628810-robh@kernel.org>
References: <20230924181959.64264-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924181959.64264-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 08:19:59PM +0200, Nik Bune wrote:
> Convert txt file to yaml.
> 
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v3:
> - Removed trailing whitespace in an element of the maintainers list.
> 
> v2 patch: https://lore.kernel.org/linux-devicetree/20230924172004.59208-1-n2h9z4@gmail.com/ 
> 
>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 33 +++++++++++++++++++
>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 -----
>  2 files changed, 33 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt

Are the watchdog maintainers going to pick up this and other watchdog 
bindings?

Rob
