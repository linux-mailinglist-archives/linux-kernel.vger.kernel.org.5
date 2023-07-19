Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D05759C77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGSRff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGSRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:35:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B61735;
        Wed, 19 Jul 2023 10:35:31 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.68]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MODeL-1qXUnT04gT-00OaQ4; Wed, 19 Jul 2023 19:35:14 +0200
Message-ID: <546b2da6-994a-ebc7-60c1-1d1ff2202f88@i2se.com>
Date:   Wed, 19 Jul 2023 19:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 0/5] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
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
 <fe8ed301-dda8-9038-a035-c24e84bc2c5c@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <fe8ed301-dda8-9038-a035-c24e84bc2c5c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4SS1245RzPigCM1wMhAUPam6YNO7JzdB7efPqrngJgpBI5tEjIs
 Si3zOT2SC9I4yO17o6acAoKDgcn/omA4rQ0T1KZs7C2ZIcmiQHF+diCXj2kMW/sIhCuECGS
 Ky8iaPgeJTLA+W37SHQTPz7hZjLpk/AfTcxwgf716PxPTTfF9G+A0tnQ7S86LByy0qQZie+
 z+U2HK8J+YHF+M70rRwMw==
UI-OutboundReport: notjunk:1;M01:P0:zjewoO0cnX4=;8/+Vyh8JEhTBo0Vpw3mVe1iYF8m
 HMryiuOWemjxJnGTXOMWz10tBLj8DCt/KhvapVlBv72jSGrR7oSbUaErPZ++AINrFC7OQhWfx
 UeoslNMMvlAoBZvWds5FXg72HRVtt8c1jA5ChPa800lVlpzKIPd1ejfipHztj4IhCqPiumYD/
 Ew9miauGa7+9b5I6lbVg5k/jPrCMIMDF8fUCo/qA6Q4JFyOZRInMM2GXgZHfQUgOoAlQfjWpa
 ywz3W9fRxFfnrFxjmelgHBTpo/LPVYdXdeBHLkKCHOMabjoxAe5QP63nCVUbMDg98k5hz7Flk
 CbFCxl6FC7wUlRvKS0StC/RAVn881S1gu6CPsd3l8dKzynXeQmHhF5REILwh/etJaIJGY9PJl
 /zBFlqsOlSfpdLE0DEd8/Alvhdj+obbCNwyK1d2qaGPq8MR4424cmPvr0/4CThi7W2tdriAwA
 7jaeLjWQmmvX5E3SEsbBVJzPQ7/lvEQvWLxoBds7fG4Iwp0UxS/cNgjuM3mpfYLMs4SIwROrW
 dd0Fa0++SytbH399+PpKWZCGx3MkhOt02tQC7RgffUYe506XycLNpO+GHduP+CO0PxAx/clwX
 hEgdhHB+G3ZFv6eqcP+8WK3ceEocztMcA0K3p8tvH3UDZvqtigHiRRnneR0AcF8BlrNMU+7u4
 CGV0mhuwnwyjKcXuFTuWNHgb0rt4PrLjIzbGAgiafA==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 19.07.23 um 18:54 schrieb Umang Jain:
> Hi,
> 
> One comment,
> 
> On 7/19/23 10:14 PM, Umang Jain wrote:
>> The patch series added a new bus type vchiq_bus_type and registers
>> child devices in order to move them away from using platform
>> device/driver.
>>
>> Patch 1/5 and 2/5 adds a new bus_type and registers them to vchiq
>> interface
>>
>> Patch 3/5 and 4/5 moves the bcm2835-camera and bcm2835-audio
>> to the new bus respectively
>>
>> Patch 5/5 removes a platform registeration helper which is no
>> longer required.
>>
>> Changes in v9:
>> - Fix module autoloading
> 
> While the autoloading of bcm2835-audio, bcm2835-camera is fixed as part 
> of this series, there is one WARN coming in when bcm2835-audio is loaded 
> regarding dma_alloc_attr
> 
> dmesg output: https://paste.debian.net/plain/1286359

is it possible that after your patch series no DMA mask like 
DMA_BIT_MASK(32) is provided?

> 
> I am investigating further...
>> - Implement bus_type's probe() callback to load drivers
>> - Implement bus_type's uevent() to make sure appropriate drivers are
>>    loaded when device are registed from vchiq.
>>
>> Changes in v8:
>> - Drop dual licensing. Instead use GPL-2.0 only for patch 1/5
>>
>> Changes in v7:
>> (5 out of 6 patches from v6 merged)
>> - Split the main patch (6/6) as requested.
>> - Use struct vchiq_device * instead of struct device * in
>>    all bus functions.
>> - Drop additional name attribute displayed in sysfs (redundant info)
>> - Document vchiq_interface doesn't enumerate device discovery
>> - remove EXPORT_SYMBOL_GPL(vchiq_bus_type)
>>
>> Changes in v6:
>> - Split struct device and struct driver wrappers in vchiq_device.[ch]
>> - Move vchiq_bus_type definition to vchiq_device.[ch] as well
>> - return error on bus_register() failure
>> - drop dma_set_mask_and_coherent
>> - trivial variable name change
>>
>> Changes in v5:
>> - Fixup missing "staging: " in commits' subject line
>> - No code changes from v4
>>
>> Changes in v4:
>> - Introduce patches to drop include directives from Makefile
>>
>> Changes in v3:
>> - Rework entirely to replace platform devices/driver model
>>
>> -v2:
>> https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/
>>
>> -v1:
>> https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/
>>
>> Umang Jain (5):
>>    staging: vc04_services: vchiq_arm: Add new bus type and device type
>>    staging: vc04_services: vchiq_arm: Register vchiq_bus_type
>>    staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
>>    staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
>>    staging: vc04_services: vchiq_arm: Remove vchiq_register_child()
>>
>>   drivers/staging/vc04_services/Makefile        |   1 +
>>   .../vc04_services/bcm2835-audio/bcm2835.c     |  20 ++--
>>   .../bcm2835-camera/bcm2835-camera.c           |  17 +--
>>   .../interface/vchiq_arm/vchiq_arm.c           |  48 ++++-----
>>   .../interface/vchiq_arm/vchiq_device.c        | 102 ++++++++++++++++++
>>   .../interface/vchiq_arm/vchiq_device.h        |  54 ++++++++++
>>   6 files changed, 196 insertions(+), 46 deletions(-)
>>   create mode 100644 
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>>   create mode 100644 
>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>>
> 
