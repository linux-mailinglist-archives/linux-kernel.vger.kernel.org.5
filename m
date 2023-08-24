Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D917877E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbjHXScF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbjHXSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:31:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8371BE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:31:51 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ZF7QqAefwuWDMZF7Rqe7Po; Thu, 24 Aug 2023 20:31:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692901908;
        bh=nPsDNUjBoakY0a/VnBFZAypFsdRwpC9qQ/hznAqbH/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VPg0zs3QpX8+1VbR+lNw3MYEEhAA7PHPxtG6IO0tPTiMoUC+tB5S+AbPMwkT4YPrW
         gMT1XE1GyCj99tRP6zCmczJVRrwCrWXecpfMR2w63qVrU5jktnvAxwUO0kyHe41dE4
         EkFPetm+uWmlgkV2+Emhfp3XJVG7zFQMZ9mAv52NYzetCRYWC2nGBKcK3vu75+o7CN
         lZU4ZmqLdwU+L5eO1II6bO/8bF9ppd7zwHsV22JA61zlIPTfnB7pf7xZ2E9O8qk3mr
         ITF/u93ACO/yi4tTqGx8VZv7KIsgmJbIaaH237zFUCo5jzcds+3ENhtNkWAZO0U+8Z
         64EQnUi+QWYFQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Aug 2023 20:31:48 +0200
X-ME-IP: 86.243.2.178
Message-ID: <74183f7b-6e53-ba3d-2160-1e526d61073b@wanadoo.fr>
Date:   Thu, 24 Aug 2023 20:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/8] media: staging: media: starfive: camss: Add core
 driver
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
References: <20230824080109.89613-1-jack.zhu@starfivetech.com>
 <20230824080109.89613-4-jack.zhu@starfivetech.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230824080109.89613-4-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/08/2023 à 10:01, Jack Zhu a écrit :
> Add core driver for StarFive Camera Subsystem. The code parses
> the device platform resources and registers related devices.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---

...

> diff --git a/drivers/staging/media/starfive/camss/Kconfig b/drivers/staging/media/starfive/camss/Kconfig
> new file mode 100644
> index 000000000000..8d20e2bd2559
> --- /dev/null
> +++ b/drivers/staging/media/starfive/camss/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VIDEO_STARFIVE_CAMSS
> +	tristate "Starfive Camera Subsystem driver"
> +	depends on V4L_PLATFORM_DRIVERS
> +	depends on VIDEO_DEV && OF
> +	depends on HAS_DMA
> +	depends on PM
> +	select MEDIA_CONTROLLER
> +	select VIDEO_V4L2_SUBDEV_API
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_FWNODE
> +	help
> +	   Enable this to support for the Starfive Camera subsystem
> +	   found on Starfive JH7110 SoC.
> +
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called stf-camss.

stf_camss? (s/-/_)

> diff --git a/drivers/staging/media/starfive/camss/Makefile b/drivers/staging/media/starfive/camss/Makefile
> new file mode 100644
> index 000000000000..f53c5cbe958f
> --- /dev/null
> +++ b/drivers/staging/media/starfive/camss/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for StarFive Camera Subsystem driver
> +#
> +
> +starfive-camss-objs += \
> +		stf_camss.o
> +
> +obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o

I'm not an expert in Makefile files, but this stf_camss.o and 
starfive-camss.o look strange to me.

> diff --git a/drivers/staging/media/starfive/camss/stf_camss.c b/drivers/staging/media/starfive/camss/stf_camss.c
> new file mode 100644
> index 000000000000..75ebc3a35218
> --- /dev/null
> +++ b/drivers/staging/media/starfive/camss/stf_camss.c

...

> +static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
> +{
> +	struct device_node *node = NULL;
> +	int ret, num_subdevs = 0;
> +
> +	for_each_endpoint_of_node(stfcamss->dev->of_node, node) {
> +		struct stfcamss_async_subdev *csd;
> +
> +		if (!of_device_is_available(node))
> +			continue;
> +
> +		csd = v4l2_async_nf_add_fwnode_remote(&stfcamss->notifier,
> +						      of_fwnode_handle(node),
> +						      struct stfcamss_async_subdev);
> +		if (IS_ERR(csd)) {
> +			ret = PTR_ERR(csd);
> +			dev_err(stfcamss->dev, "failed to add async notifier\n");
> +			v4l2_async_nf_cleanup(&stfcamss->notifier);

having it here, looks strange to me.
It is already called in the error handling path of the probe.

Should there be a "of_node_put(node);" if we return here?

> +			return ret;
> +		}
> +
> +		ret = stfcamss_of_parse_endpoint_node(stfcamss, node, csd);
> +		if (ret)
> +			return ret;
> +
> +		num_subdevs++;
> +	}
> +
> +	return num_subdevs;
> +}

...

> +static int stfcamss_remove(struct platform_device *pdev)
> +{
> +	struct stfcamss *stfcamss = platform_get_drvdata(pdev);
> +
> +	v4l2_device_unregister(&stfcamss->v4l2_dev);
> +	media_device_cleanup(&stfcamss->media_dev);

Is a "v4l2_async_nf_cleanup(&stfcamss->notifier);" missing to match the 
error handling path of the probe?

> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +

...
