Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95727B4240
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjI3Qkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjI3Qke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:40:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3BC6;
        Sat, 30 Sep 2023 09:40:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D89C433C8;
        Sat, 30 Sep 2023 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696092031;
        bh=V1WOXagELa59mj+GnYzaZ7OYaRk/PiZAVZbecyhdViM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DccTX/zSo73IOJtYc/b13EBS+DIlPnWitmDyAs0SaxgVFgXUYDRNEuxLLwFdmi9wa
         nQVs8gLwSve3vY7cXTpa09CnIXkGmD2LC5L3gnz7qfSYb4wSKKCsbNc9dNS0u72ycK
         JX2RKatPTO8i3pzksAualcJNtpHHQPHSa3PjgdAXqln1S3y1yNeevH80P/uS+i4fpK
         u6CdpEl+8nm5XBFt5q5Ik5HuSvOUF+W/g3CBnWl6+YaJSVSYIU6AFlY7wjovc01S/0
         945WBJY8NPCYJ0t5ZXQiOma1bMYIqh0SywRGfFeeVQ9eeYR9lx/Yu5zcb5Ds2x/n0c
         4JL9YmfPgn76g==
Date:   Sat, 30 Sep 2023 17:40:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: fix Analog Devices website link
Message-ID: <20230930174032.76719e93@jic23-huawei>
In-Reply-To: <20230926100149.4611-1-antoniu.miclaus@analog.com>
References: <20230926100149.4611-1-antoniu.miclaus@analog.com>
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

On Tue, 26 Sep 2023 13:01:49 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The http://ez.analog.com/community/linux-device-drivers link is broken.
> 
> Update website link to the new available one:
> https://ez.analog.com/linux-software-drivers
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

J
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..94066240e475 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1119,7 +1119,7 @@ ANALOG DEVICES INC AD4130 DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
> @@ -1152,7 +1152,7 @@ ANALOG DEVICES INC AD74115 DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
>  F:	drivers/iio/addac/ad74115.c
>  
> @@ -12818,7 +12818,7 @@ MAX31827 TEMPERATURE SWITCH DRIVER
>  M:	Daniel Matyas <daniel.matyas@analog.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>  F:	Documentation/hwmon/max31827.rst
>  F:	drivers/hwmon/max31827.c

