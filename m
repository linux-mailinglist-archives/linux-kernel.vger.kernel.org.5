Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381967B426E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjI3RBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjI3RBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:01:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7EDA;
        Sat, 30 Sep 2023 10:01:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D365C433C8;
        Sat, 30 Sep 2023 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696093280;
        bh=PtP8kQO7PSDeECoZK0s8MvcnNBLnIZH+JHVGfpAN/dQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fjYDDDhFufw5uPZYpXeI8gzp9zlxjQkRaEktPEE/pPzoV8USME1/DH898ClvwWi/I
         Pmx2omTOtJ4+9UcJ8IHjRnqU3CE7k+bvdc12S+w+9bSOzZYjAIsntTkRoDqmCRwMB7
         7r/YtIAibV7gTHSObGZTVrr5jdj52L++aRiLKNOeInEMk75SbWPR+LJcWfKzEUphy4
         5AwUJ2HpjnafeTpRluTuh5Z6DbqtfsPARHp4DkC6xvdnOj9/kMIVrDSWOAmIQRNQ6J
         A16HFdih+weJWgII9l/84JdsZVwrRHqvZ5AV341JXOxu3ZugTBiDUDvK50U5o9E1BA
         VSS1NRbEKZLfA==
Date:   Sat, 30 Sep 2023 18:01:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] MAINTAINERS: Add ROHM BM1390
Message-ID: <20230930180118.04acbd33@jic23-huawei>
In-Reply-To: <fb19d3027ac19663789e18d4dc972a5dac0fde74.1695727471.git.mazziesaccount@gmail.com>
References: <cover.1695727471.git.mazziesaccount@gmail.com>
        <fb19d3027ac19663789e18d4dc972a5dac0fde74.1695727471.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 11:28:29 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add myself as a maintainer for ROHM BM1390 pressure sensor driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied, 3-5 (as well as 2 that I replied to separately).

Nice driver.  Thanks,

Jonathan

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..91390f571a05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18563,6 +18563,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
>  F:	drivers/iio/light/bh1750.c
>  
> +ROHM BM1390 PRESSURE SENSOR DRIVER
> +M:	Matti Vaittinen <mazziesaccount@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	drivers/iio/pressure/rohm-bm1390.c
> +
>  ROHM BU270xx LIGHT SENSOR DRIVERs
>  M:	Matti Vaittinen <mazziesaccount@gmail.com>
>  L:	linux-iio@vger.kernel.org

