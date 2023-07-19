Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9F1759CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGSRzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGSRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:55:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871771FC8;
        Wed, 19 Jul 2023 10:55:49 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.68]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0WsG-1q1VmE3ZMC-00wZJi; Wed, 19 Jul 2023 19:55:34 +0200
Message-ID: <153d3a8f-26b9-fdf3-e96f-a1e338c977b7@i2se.com>
Date:   Wed, 19 Jul 2023 19:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 4/5] staging: bcm2835-audio: Register bcm2835-audio
 with vchiq_bus_type
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
References: <20230719164427.1383646-1-umang.jain@ideasonboard.com>
 <20230719164427.1383646-5-umang.jain@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230719164427.1383646-5-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IrHo+yQKjQZP8ufddu3tihy98TNvPWemx/TN6KSs51LFKI15ndm
 DehgGQTo3sRzoiu8PkADCbiwegPb9AUScsHHkA8Cd+C515hHMZEbBesvIcJBs71Zsmrl832
 H9I6UGzhdYd1oJ2RuFHzE9PxIsYWjYdhWtBrC09ZotzgjEGSb5ctMvfiacYdqFGeaso53xq
 wxycDQwuBYj6H956RjmiQ==
UI-OutboundReport: notjunk:1;M01:P0:FKpyv9qePPA=;adpoBBO3/O2qrN3L9RZuwCT6cST
 xoTVo36MlQL0KyAo39JAWVAOa0OKtdbgFCZMA4DInEalUnLno0HC+vGMhvUhA93ZkklQaDIPS
 /2J1UskIpqkf2L8pvEgJ6g3qdPtEiTYa4NVMFspC6s3Q7BQu49BXE1pRyBBfZQ+k8253l1PfH
 Nj7WWdTRZDKMJjQbRAJRzJlC5f0R0w45hTwXOcBX/1p9GV5l6zY0d6syyBhrbDzY+o3EpiBdT
 dvUHd7RQDb0xVZkvFnTDHr90CuSpwPMXyyWAu0wveA0ciQGh4tp4KQWPmu/qbRThbBP6rxmxw
 fKm3nWpQggn5T50czfHw96yLxgEaiFkSSCT4JEHfluI5fgBEUrZcr4PBPhvtmw5MLDfgd+cPt
 O48M43vi9M42R2DPQOAjm2Nc9ZDFjdM4wpUjsXUFPPHKAdT4lRe5HPlzBIHBeOAPa5HLFWTLU
 rxidgNuqvDi2CauzcHyrNncaH/DFaeiIbbD1IB2iqX027rbQPupGI2POzBM3boHtihn47Baxw
 JUMiwFYQ4rAoWqhTeLIX4I9HinsFZXl3sl9cvi6sHKakncgJ1GYSV2mx11TTQSs+/qGZZ11qM
 893S4Dx2CO6nvQln9V+FLbVxMETeLkXVr0MAQ3u0+Ai38xMjAdrSLjLWA6uVgy8ArfNmthgbY
 8kkIFmt3vxAto5kS6ez3PbUkFHTOVxXjxLW0+zphdg==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 19.07.23 um 18:44 schrieb Umang Jain:
> Similar to how bcm2385-camera device is registered, register the
> bcm2835-audio with vchiq_bus_type as well.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../vc04_services/bcm2835-audio/bcm2835.c     | 20 +++++++++----------
>   .../interface/vchiq_arm/vchiq_arm.c           |  6 +++---
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> index 00bc898b0189..70e5e0942743 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> @@ -1,12 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
>   
> -#include <linux/platform_device.h>
> -
>   #include <linux/init.h>
>   #include <linux/slab.h>
>   #include <linux/module.h>
>   
> +#include "../interface/vchiq_arm/vchiq_arm.h"
> +#include "../interface/vchiq_arm/vchiq_device.h"
>   #include "bcm2835.h"
>   
>   static bool enable_hdmi;
> @@ -268,9 +268,9 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
>   	return 0;
>   }
>   
> -static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
> +static int snd_bcm2835_alsa_probe(struct vchiq_device *device)
>   {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = &device->dev;
>   	int err;
>   
>   	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
> @@ -292,32 +292,32 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
>   
>   #ifdef CONFIG_PM
>   
> -static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
> +static int snd_bcm2835_alsa_suspend(struct vchiq_device *device,
>   				    pm_message_t state)
>   {
>   	return 0;
>   }
>   
> -static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
> +static int snd_bcm2835_alsa_resume(struct vchiq_device *device)
>   {
>   	return 0;
>   }
>   
>   #endif
>   
> -static struct platform_driver bcm2835_alsa_driver = {
> +static struct vchiq_driver bcm2835_alsa_driver = {
>   	.probe = snd_bcm2835_alsa_probe,
>   #ifdef CONFIG_PM
>   	.suspend = snd_bcm2835_alsa_suspend,
>   	.resume = snd_bcm2835_alsa_resume,
>   #endif
>   	.driver = {
> -		.name = "bcm2835_audio",
> +		.name = "bcm2835-audio",

At least this change is not mentioned in the commit log.

Thanks

>   	},
>   };
> -module_platform_driver(bcm2835_alsa_driver);
> +module_vchiq_driver(bcm2835_alsa_driver);
>   
>   MODULE_AUTHOR("Dom Cobley");
>   MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
>   MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:bcm2835_audio");
> +MODULE_ALIAS("bcm2835-audio");
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index d941e9640415..f7c2dce5ab09 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -67,12 +67,12 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
>   DEFINE_SPINLOCK(msg_queue_spinlock);
>   struct vchiq_state g_state;
>   
> -static struct platform_device *bcm2835_audio;
>   /*
>    * The devices implemented in the VCHIQ firmware are not discoverable,
>    * so we need to maintain a list of them in order to register them with
>    * the interface.
>    */
> +static struct vchiq_device *bcm2835_audio;
>   static struct vchiq_device *bcm2835_camera;
>   
>   struct vchiq_drvdata {
> @@ -1845,7 +1845,7 @@ static int vchiq_probe(struct platform_device *pdev)
>   		goto error_exit;
>   	}
>   
> -	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
> +	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
>   	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
>   
>   	return 0;
> @@ -1858,7 +1858,7 @@ static int vchiq_probe(struct platform_device *pdev)
>   
>   static void vchiq_remove(struct platform_device *pdev)
>   {
> -	platform_device_unregister(bcm2835_audio);
> +	vchiq_device_unregister(bcm2835_audio);
>   	vchiq_device_unregister(bcm2835_camera);
>   	vchiq_debugfs_deinit();
>   	vchiq_deregister_chrdev();
