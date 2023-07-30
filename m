Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3147687F0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjG3UaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjG3UaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:30:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64E113;
        Sun, 30 Jul 2023 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749011; x=1691353811; i=w_armin@gmx.de;
 bh=1EdUeSoMNd8wr3Gkc7pk6EgX5RIq5J8Xt9rcA1v6fmA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XsIunzewEyOm8RlGLbuHmNn92steIF4+jtPbLkNGX8oLP6rNZh+63ay7Qrnn3o9PXa0soM0
 meEF6F/np/KjuPQxIrhYbe/EcyWJ2H1/o46BcmIJ8HwIwudIh0U+cmdv0gvy+786XyjcIZDzx
 d5WITbH+rbX+HWRoEuLkCrG3Qp9Td6zLTZMEhEgGOCmLUUcpNWs/D6pe0fNR7GPgn8+j1nWLQ
 7tBCuIbTm5kRV0PCN8DPEIjIdvH7e+FzkXozi2NkhoOvbeXehJx0ZJz7gCjI6twIKwdOejx8K
 QD+RkovPG9oK/XCisNtXXXywIrwnwoPD6lfl8dlZ3ZqmQEhrh95g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1qNz3K41lo-00X3pV; Sun, 30
 Jul 2023 22:30:11 +0200
Message-ID: <0f761565-424b-695f-222d-64c672dfbdc5@gmx.de>
Date:   Sun, 30 Jul 2023 22:30:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] platform/x86: wmi-bmof: Update MAINTAINERS entry
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730043817.12888-1-W_Armin@gmx.de>
 <20230730043817.12888-3-W_Armin@gmx.de>
 <873de462-b06c-44af-a5d3-559a78161a7d@t-8ch.de>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <873de462-b06c-44af-a5d3-559a78161a7d@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qw14HjhCgz/eFYEuZ1ZhaX6yBB97u51HkoH/dWXItrhRaeQjl9g
 eU7Uzex06B4V8Zu58SHm/DXw9tza1hQe/N/atRUa32axnbMtSU2Uw7eJPnT7skNMFwzJwA5
 YQ6U9kMlarVaNLVBgAWdTjKXS9qoyhba85lOwUHA5BvT7l2uTqxXKsVTBxeS4Gtf1gdvOor
 8Tq+/n7wwYmDlftz7cW8A==
UI-OutboundReport: notjunk:1;M01:P0:TjD20CGeY4w=;co2UyZosuA25nvCG+/vlxtiVTrx
 1+C0nsV9jIbLWok2kfu62HXwikT6AN5YmtTCvpE+3R3On7oxvbnOQFnXu/XRWt3jKDJ6atvLh
 PfksAw2ZRkuaLPACQM921UeUluO8+EWbu5Tzgi9yKT5/0/lGJp7k1P2VrwlRzCTX/28yYB/YS
 0e6PyXtYtNmWHDV8mW8ZAmpiJ97blQxWebiTKGncTb5o0q1vep5h6w9I4Wu1GIP9hk68yphV3
 BHRNOTU+Og7wZbUsO/a07bhMa9LDH/ZwTyRcr3gtbM3W/XT/wvsx0/Pp6/ObNck3qXwW7uQsP
 V8Fd8KQKUpMKcaeuqmXVKCTvoFVacqDxAk87Y4Y7erYmp5iY7Ml+3S30TLfRVqV1u1tgQp0SB
 D+QtmTdet36Mss3/x9Rn/mffdRvflHi2n4d2nAxydCM0Uw6vb0L/p1Q+T3ZYx+kGl0E2aOimr
 VhNhmSGpEnBUdTBB8VLN09lzaLYHJSorPqVNQhUBIKWfmv/faMytaGfW+xzgBfWcs/ieVEJK8
 TWp9vypU2kbVcL3wa1Qm2QkFnadcluC0aedc4U53E6XMj/4AVoUaw5cYVoTOCLFXW7Nzl/Bsj
 2+WyFZszN9l++Nl7S/84hgYNMRa3m/5MVNXfOsWD2LyCw04VFCN0GxxlREUZP4oxPlTo9ujpL
 /ybGpCmiY9cq+mTLQ8YN7Q4dnPr+Fv17ReGNr51H/sg5GYf0NIoGZDnks1shBwPfDb2H9EB/e
 XsNztMY5eVtOGXFJKNlLwCbv+utkG9Scp+VXWjFxLXWBBh4w9nZ5DlAi7oJiLj+UaRCYB/u0K
 ds+htf/EyM0FTg4RCjZnwTfOv9QXerVEQ/At5CC9VGgop1sGXC8wKn27cU9gUxIlDEKCv5zV8
 t7oMHCP1b4hl3a3RpE1oPU3Tif6Dw00UJGLq34Hovzw6pLv9VkSbQxmz3FkedbbLK1VTbM11l
 9TsA9w==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.07.23 um 09:11 schrieb Thomas Wei=C3=9Fschuh:

> On 2023-07-30 06:38:17+0200, Armin Wolf wrote:
>> The WMI Binary MOF driver is important for the development
>> of modern WMI drivers, i am willing to maintain it.
>> Also fix the mailing list address.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   MAINTAINERS | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 426d3be71da2..9b871fb34e83 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22954,8 +22954,9 @@ S:	Odd fixes
>>   F:	drivers/net/wireless/legacy/wl3501*
>>
>>   WMI BINARY MOF DRIVER
>> -L:	platform-drivers-x86@vger.kernel.org
>> -S:	Orphan
>> +M:	Armin Wolf <W_Armin@gmx.de>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Maintained
> If you want a reviewer or second maintainer I would be volunteering.

Sure, the driver might be quite small, but having an reviewer is always go=
od.

Armin Wolf

>>   F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
>>   F:	Documentation/wmi/devices/wmi-bmof.rst
>>   F:	drivers/platform/x86/wmi-bmof.c
>> --
>> 2.39.2
>>
