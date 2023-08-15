Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2445E77CA58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjHOJXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjHOJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:22:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83B9F198D;
        Tue, 15 Aug 2023 02:21:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxXOqpQ9tk+bQYAA--.23671S3;
        Tue, 15 Aug 2023 17:21:45 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxsyYQ9tkLw1bAA--.4228S3;
        Tue, 15 Aug 2023 17:21:45 +0800 (CST)
Message-ID: <88f22101-f15b-f8f3-23b7-e7514031e367@loongson.cn>
Date:   Tue, 15 Aug 2023 17:21:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Mips: loongson3_defconfig: Enable ast drm driver by
 default
Content-Language: en-US
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230803091637.971924-1-suijingfeng@loongson.cn>
 <ZNs3ZwYH5N/uumJP@alpha.franken.de>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <ZNs3ZwYH5N/uumJP@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxxsyYQ9tkLw1bAA--.4228S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurWUCr1xKr1UArW7AFy8Xrc_yoWkWwc_tF
        9Fka48Cr4FyrWIg397X395CrWY9a4UA3WfAFnrXryfXw1Fyr43Xw1kAr98G3W5W34DKFZ3
        Z3y8AF97CF1SqosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
        14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
        4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxU7_MaUUUUU
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/8/15 16:29, Thomas Bogendoerfer wrote:
> On Thu, Aug 03, 2023 at 05:16:37PM +0800, Sui Jingfeng wrote:
>> ASpeed GPU is typically found on the Loongson server platform, as a
>> peripheral device driver, it generally should be compiled as a module.
>>
>> Tested on loongson 3B4000 server[1].
>>
>> [1] https://github.com/loongson-gfx/loongson_boards/tree/main/ls3b4000x2_server
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   arch/mips/configs/loongson3_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
>> index 3087e64e6ebe..a9fadea72da5 100644
>> --- a/arch/mips/configs/loongson3_defconfig
>> +++ b/arch/mips/configs/loongson3_defconfig
>> @@ -283,6 +283,7 @@ CONFIG_DRM_AMDGPU_USERPTR=y
>>   CONFIG_DRM_AMD_ACP=y
>>   CONFIG_DRM_AMD_DC=y
>>   CONFIG_DRM_AMD_DC_SI=y
>> +CONFIG_DRM_AST=m
>>   CONFIG_DRM_RADEON=m
>>   CONFIG_DRM_QXL=y
>>   CONFIG_DRM_VIRTIO_GPU=y
>> -- 
>> 2.34.1
>>
> applied to mips-next.
>
> Thomas.
Thanks a lot.

