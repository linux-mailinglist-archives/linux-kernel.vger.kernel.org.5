Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FA7840B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjHVMZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjHVMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A76199;
        Tue, 22 Aug 2023 05:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB97760C56;
        Tue, 22 Aug 2023 12:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFF5C433C8;
        Tue, 22 Aug 2023 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692707152;
        bh=8eUEWJPTSeLQx03vuAPCyuAPr8wQILlpjH22aTpmHjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjWw1AroDZC+blk+bVJ/Wub/9AcH2Fg1/1G3AKK+vV0hWW/99iUyCzY52D5R0+a5B
         r7O7/ADAwr+u3bFe493brSNtQa5W4FYi9T0Fuq4nkUQFRiU5utX7aw/HR6DDSkYy4u
         abPMxW7jxySC2xDFcjbuHOfzCr0SQBHEXYTQgQ4U=
Date:   Tue, 22 Aug 2023 14:25:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: Fix Exynos5433
 compatible
Message-ID: <2023082243-quickness-pacifier-a958@gregkh>
References: <20230816201123.3530-1-semen.protsenko@linaro.org>
 <acec7eb3-92b5-e431-f84c-500f07a2dd14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acec7eb3-92b5-e431-f84c-500f07a2dd14@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:52:15AM +0200, Krzysztof Kozlowski wrote:
> On 16/08/2023 22:11, Sam Protsenko wrote:
> > The correct compatible for Exynos5433 is "samsung,exynos5433-dwusb3".
> > Fix the typo in its usage.
> > 
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Fixes: 949ea75b7ba4 ("dt-bindings: usb: samsung,exynos-dwc3: convert to dtsche
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Greg,
> I assume this one is for you.

Great, I'll take it, thanks.

greg k-h
