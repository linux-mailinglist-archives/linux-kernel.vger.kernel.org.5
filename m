Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25017759CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGSR5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGSR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:57:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307AC1FF5;
        Wed, 19 Jul 2023 10:57:25 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.68]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQy0N-1qbOZE21MF-00O1y2; Wed, 19 Jul 2023 19:51:51 +0200
Message-ID: <f1d46c8c-2dfd-4fe7-6005-fc7b97f5cafb@i2se.com>
Date:   Wed, 19 Jul 2023 19:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
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
 <20230719164427.1383646-2-umang.jain@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230719164427.1383646-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8VJip2zrPWfOrkss/26VVuw/ZEQ+jciPFDMSIIifivfwfYruXyv
 MMZanM2hs9O1N/y2K98q/zamtKAScB5ijAGqLi7J++xqTwI6HANrxDKz15jNb01OxWDhA08
 NW5yOgtMJ8KhXEvZHFPvGwi20ar0uzlUnUXPqLGcOxC0fFU9Ovj2giyiTCCR46caPLRPqrv
 tAZcpzAu0+wkS5XX1XU8w==
UI-OutboundReport: notjunk:1;M01:P0:hMttlQkVM2g=;HIJk1JqgwdmnPTy+Myjm+1cI1jY
 LIoSjk084Anhiyf+nuyKaPrSmEzpOqL0XDBvXpAPmIfwTExJLrt401CuROIHqJHkQ9AY+Jf6v
 r3HS48txAC1+KK7Dxqt7vr13Qq7K4iH+n1En/4d0JH8jjHOcfc0JZbLQ1HXhHi/sVxpNEubVk
 F9Omty/amA+GzgiUEO2Z47iWojttilcCXcN20whmj9IaaKX8JoTb8iiahwXFz6R3Vrlm7xZHI
 1er4Xad6u0Zqy09lc2tTIYDzxxCx1IJ8EMI87kHRm4xU8iNqZj3Kt2++rGrCRaX5/W8YS8r9t
 IlnIizGZLr3EqL2vjDoGrfIDL9GZJ12dAl1IiHaLQnb3Dy0orcAkf4iVkj9u9jH8DTUmWIuxV
 6/GBEHuoV3sSD7RtNq2JiRowwdUz5DweDpOSQ/01o7IKiBqmnYh4L21zyiCLl3aQHKyhVcEtk
 tjgHj5QG0JbDx/BHBiTmBeIYdiZJKGMBgZqwIhDEmdg9AbRHdjJO2QJH+ZI5KUbe96WJetsjw
 fEt7xrWAnmS54vHJhfC3Wwi/BLWGcitAdrDmtx4tOKwStLpIqU+l+wRyX79uiK4np/kkTqskU
 BfuDBnvxs7EVGrKw5e2v3V6I6qnj4BWf0jYT2iHHejKU3grsm1x3sEtTcdRcgI40wKmjYdrYR
 hyy6y37oFvHoA3s4FAzHpt8vL8ss/Ci0dYGHqwun8g==
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
> The devices that the vchiq interface registers (bcm2835-audio,
> bcm2835-camera) are implemented and exposed by the VC04 firmware.
> The device tree describes the VC04 itself with the resources required
> to communicate with it through a mailbox interface. However, the
> vchiq interface registers these devices as platform devices. This
> also means the specific drivers for these devices are getting
> registered as platform drivers. This is not correct and a blatant
> abuse of platform device/driver.
> 
> Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
> which will be used to migrate child devices that the vchiq interfaces
> creates/registers from the platform device/driver.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   drivers/staging/vc04_services/Makefile        |   1 +
>   .../interface/vchiq_arm/vchiq_device.c        | 102 ++++++++++++++++++
>   .../interface/vchiq_arm/vchiq_device.h        |  54 ++++++++++
>   3 files changed, 157 insertions(+)
>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> 
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> index 44794bdf6173..2d071e55e175 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -5,6 +5,7 @@ vchiq-objs := \
>      interface/vchiq_arm/vchiq_core.o  \
>      interface/vchiq_arm/vchiq_arm.o \
>      interface/vchiq_arm/vchiq_debugfs.o \
> +   interface/vchiq_arm/vchiq_device.o \
>      interface/vchiq_arm/vchiq_connected.o \
>   
>   ifdef CONFIG_VCHIQ_CDEV
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> new file mode 100644
> index 000000000000..d7dfe4173579
> --- /dev/null
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * vchiq_device.c - VCHIQ generic device and bus-type
> + *
> + * Copyright (c) 2023 Ideas On Board Oy
> + */
> +
> +#include <linux/device/bus.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "vchiq_device.h"
> +
> +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
> +{
> +	if (dev->bus == &vchiq_bus_type &&
> +	    strcmp(dev_name(dev), drv->name) == 0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int vchiq_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
> +{
> +	const struct vchiq_device *device = container_of_const(dev, struct vchiq_device, dev);
> +
> +	return add_uevent_var(env, "MODALIAS=%s", dev_name(&device->dev));
> +}
> +
> +static int vchiq_bus_probe(struct device *dev)
> +{
> +	struct vchiq_device *device = to_vchiq_device(dev);
> +	struct vchiq_driver *driver = to_vchiq_driver(dev->driver);
> +	int ret;
> +
> +	ret = driver->probe(device);
> +	if (ret == 0)
> +		return 0;
> +
> +	return ret;

Why not returning the result of probe directly?

> +}
> +
> +struct bus_type vchiq_bus_type = {
> +	.name   = "vchiq-bus",
> +	.match  = vchiq_bus_type_match,
> +	.uevent = vchiq_bus_uevent,
> +	.probe  = vchiq_bus_probe,
> +};
> +
> +static void vchiq_device_release(struct device *dev)
> +{
> +	struct vchiq_device *device = to_vchiq_device(dev);
> +
> +	kfree(device);
> +}
> +
> +struct vchiq_device *
> +vchiq_device_register(struct device *parent, const char *name)
> +{
> +	struct vchiq_device *device;
> +	int ret;
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device) {
> +		dev_err(parent, "Cannot register %s: Insufficient memory\n",
> +			name);
> +		return NULL;
> +	}
> +
> +	device->dev.init_name = name;
> +	device->dev.parent = parent;
> +	device->dev.bus = &vchiq_bus_type;
> +	device->dev.release = vchiq_device_release;

Not sure, but maybe a good place to set the DMA mask?

> +
> +	ret = device_register(&device->dev);
> +	if (ret) {
> +		dev_err(parent, "Cannot register %s: %d\n", name, ret);
> +		put_device(&device->dev);
> +		return NULL;
> +	}
> +
> +	return device;
> +}
> +
> +void vchiq_device_unregister(struct vchiq_device *vchiq_dev)
> +{
> +	device_unregister(&vchiq_dev->dev);
> +}
> +
> +int vchiq_driver_register(struct vchiq_driver *vchiq_drv)
> +{
> +	vchiq_drv->driver.bus = &vchiq_bus_type;
> +
> +	return driver_register(&vchiq_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(vchiq_driver_register);
> +
> +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv)
> +{
> +	driver_unregister(&vchiq_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(vchiq_driver_unregister);
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> new file mode 100644
> index 000000000000..7eaaf9a91cda
> --- /dev/null
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 Ideas On Board Oy
> + */
> +
> +#ifndef _VCHIQ_DEVICE_H
> +#define _VCHIQ_DEVICE_H
> +
> +#include <linux/device.h>
> +
> +struct vchiq_device {
> +	struct device dev;
> +};
> +
> +struct vchiq_driver {
> +	int		(*probe)(struct vchiq_device *device);
> +	void		(*remove)(struct vchiq_device *device);
> +	int		(*resume)(struct vchiq_device *device);
> +	int		(*suspend)(struct vchiq_device *device,
> +				   pm_message_t state);
> +	struct device_driver driver;
> +};
> +
> +static inline struct vchiq_device *to_vchiq_device(struct device *d)
> +{
> +	return container_of(d, struct vchiq_device, dev);
> +}
> +
> +static inline struct vchiq_driver *to_vchiq_driver(struct device_driver *d)
> +{
> +	return container_of(d, struct vchiq_driver, driver);
> +}
> +
> +extern struct bus_type vchiq_bus_type;
> +
> +struct vchiq_device *
> +vchiq_device_register(struct device *parent, const char *name);
> +void vchiq_device_unregister(struct vchiq_device *dev);
> +
> +int vchiq_driver_register(struct vchiq_driver *vchiq_drv);
> +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv);
> +
> +/**
> + * module_vchiq_driver() - Helper macro for registering a vchiq driver
> + * @__vchiq_driver: vchiq driver struct
> + *
> + * Helper macro for vchiq drivers which do not do anything special in
> + * module init/exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module_exit()
> + */
> +#define module_vchiq_driver(__vchiq_driver) \
> +	module_driver(__vchiq_driver, vchiq_driver_register, vchiq_driver_unregister)
> +
> +#endif /* _VCHIQ_DEVICE_H */
